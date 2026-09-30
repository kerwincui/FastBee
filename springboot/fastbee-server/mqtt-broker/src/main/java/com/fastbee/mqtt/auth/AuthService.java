package com.fastbee.mqtt.auth;

import com.fastbee.common.constant.CacheConstants;
import com.fastbee.common.constant.Constants;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.core.domain.model.LoginUser;
import com.fastbee.common.core.domain.model.MqttClientPrincipal;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.iot.model.MqttAuthenticationModel;
import com.fastbee.iot.service.IToolService;
import com.fastbee.mqttclient.MqttClientConfig;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 客户端认证
 *
 * @author gsb
 * @date 2022/9/15 13:40
 */
@Slf4j
@Component
public class AuthService {

    @Resource
    private IToolService toolService;
    @Resource
    private RedisCache redisCache;
    @Resource
    private MqttClientConfig mqttConfig;
    @Resource
    private com.fastbee.system.service.ISysUserService userService;
    // 令牌秘钥
    @Value("${token.secret}")
    private String secret;


    /**
     * MQTT客户端认证
     *
     * <p>web / phone 客户端使用平台登录 JWT 作为 MQTT 密码。此处不能只做签名校验：
     * 必须回查 Redis 中的登录态并取出 userId，一方面让已注销/已过期的令牌立即失效，
     * 另一方面让 PUBLISH 阶段能校验该用户对目标设备的归属权限。</p>
     *
     * @param clientId 客户端id
     * @param username 用户名
     * @param password 密码
     * @return 认证主体，认证失败返回 null
     */
    public MqttClientPrincipal authenticate(String clientId, String username, String password) {
        if (StringUtils.isEmpty(clientId) || StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            log.error("=>客户端参数缺少,clientId:{}", clientId);
            return null;
        }
        try {
            if (clientId.startsWith("server")) {
                // 服务端认证：配置的账号密码认证
                if (mqttConfig.getUsername().equals(username) && mqttConfig.getPassword().equals(password)) {
                    log.info("-----------服务端mqtt认证成功,clientId:" + clientId + "---------------");
                    return MqttClientPrincipal.of(clientId, MqttClientPrincipal.ClientType.SERVER);
                } else {
                    ResponseEntity response = toolService.returnUnauthorized(new MqttAuthenticationModel(clientId, username, password), "mqtt账号和密码与认证服务器配置不匹配");
                    log.warn("=>服务端认证失败[{}]", response.getBody());
                    throw new ServiceException("服务端认证失败:" + response.getBody());
                }
            } else if (clientId.startsWith("web") || clientId.startsWith("phone")) {
                return authenticateWebClient(clientId, username, password);
            } else {
                // 设备端认证
                ResponseEntity response = toolService.clientAuth(clientId, username, password);
                if (response.getStatusCodeValue() == HttpStatus.OK.value()) {
                    return MqttClientPrincipal.of(clientId, MqttClientPrincipal.ClientType.DEVICE);
                } else {
                    log.warn("=>设备端认证失败");
                    throw new ServiceException("设备端认证失败:" + response.getBody());
                }
            }
        } catch (Exception e) {
            log.error("=>客户端认证失败", e);
            return null;
        }
    }

    /**
     * Web / 移动端认证：校验 JWT 并解析出平台用户身份
     */
    private MqttClientPrincipal authenticateWebClient(String clientId, String username, String password) {
        String token = password;
        if (StringUtils.isNotEmpty(token) && token.startsWith(Constants.TOKEN_PREFIX)) {
            token = token.replace(Constants.TOKEN_PREFIX, "");
        }
        Claims claims;
        try {
            claims = Jwts.parser().setSigningKey(secret).parseClaimsJws(token).getBody();
        } catch (Exception ex) {
            ResponseEntity response = toolService.returnUnauthorized(new MqttAuthenticationModel(clientId, username, password), ex.getMessage());
            log.warn("=>移动端/Web端mqtt认证失败[{}]", response.getBody());
            throw new ServiceException("移动端/Web端mqtt认证失败:" + response.getBody());
        }
        // 回查登录态：令牌签名合法但已注销/已过期时必须拒绝
        String uuid = (String) claims.get(Constants.LOGIN_USER_KEY);
        if (StringUtils.isEmpty(uuid)) {
            log.warn("=>移动端/Web端mqtt认证失败[令牌中缺少登录标识]");
            throw new ServiceException("移动端/Web端mqtt认证失败:令牌中缺少登录标识");
        }
        LoginUser loginUser = redisCache.getCacheObject(CacheConstants.LOGIN_TOKEN_KEY + uuid);
        if (loginUser == null || loginUser.getUser() == null) {
            log.warn("=>移动端/Web端mqtt认证失败[登录态已失效],clientId:{}", clientId);
            throw new ServiceException("移动端/Web端mqtt认证失败:登录态已失效，请重新登录");
        }
        MqttClientPrincipal principal = MqttClientPrincipal.ofWeb(clientId, loginUser.getUser().getUserId(), false);
        principal.setSessionId(uuid);
        SysUser user = currentWebUser(principal);
        if (user == null) throw new ServiceException("登录态不可用或必须先修改默认密码");
        log.info("-----------移动端/Web端mqtt认证成功,clientId:{},userId:{}---------------", clientId, user.getUserId());
        principal.setAdmin(user.isAdmin());
        return principal;
    }

    /** Check every Web operation/delivery; a valid old TCP connection is not a valid login session. */
    public SysUser currentWebUser(MqttClientPrincipal principal) {
        if (principal == null || !principal.isWeb() || StringUtils.isEmpty(principal.getSessionId())) return null;
        LoginUser login = redisCache.getCacheObject(CacheConstants.LOGIN_TOKEN_KEY + principal.getSessionId());
        if (login == null || login.getUser() == null || !java.util.Objects.equals(principal.getUserId(), login.getUser().getUserId())
                || !"0".equals(login.getUser().getStatus()) || "2".equals(login.getUser().getDelFlag())
                || com.fastbee.common.utils.PasswordPolicy.requiresChange(login)) return null;
        SysUser current = userService.selectUserById(principal.getUserId());
        if (current == null || !"0".equals(current.getStatus()) || "2".equals(current.getDelFlag())
                || !java.util.Objects.equals(current.getPassword(), login.getUser().getPassword())) return null;
        return current;
    }

}
