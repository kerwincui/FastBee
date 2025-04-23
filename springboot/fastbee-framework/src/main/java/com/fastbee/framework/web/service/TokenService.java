package com.fastbee.framework.web.service;

import com.fastbee.common.constant.CacheConstants;
import com.fastbee.common.constant.Constants;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.core.domain.model.LoginUser;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.utils.ServletUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.common.utils.ip.AddressUtils;
import com.fastbee.common.utils.ip.IpUtils;
import com.fastbee.common.utils.uuid.IdUtils;
import com.fastbee.system.domain.SysClient;
import com.fastbee.system.service.ISysClientService;
import eu.bitwalker.useragentutils.UserAgent;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;


/**
 * token验证处理
 *
 * @author ruoyi
 */
@Slf4j
@Component
public class TokenService {
    // 令牌自定义标识
    @Value("${token.header}")
    private String header;

    // 令牌秘钥
    @Value("${token.secret}")
    private String secret;

    // 令牌有效期（默认30分钟）
    @Value("${token.expireTime}")
    private int expireTime;

    protected static final long MILLIS_SECOND = 1000;

    protected static final long MILLIS_MINUTE = 60 * MILLIS_SECOND;

    private static final Long MILLIS_MINUTE_TEN = 20 * 60 * 1000L;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private ISysClientService sysClientService;

    @Autowired
    private UserDetailsServiceImpl userDetailsServiceImpl;

    /**
     * 获取用户身份信息
     *
     * @return 用户信息
     */
    public LoginUser getLoginUser(HttpServletRequest request) {
        // 获取请求携带的令牌
        String token = getToken(request);
        if (StringUtils.isNotEmpty(token)) {
            try {
                Claims claims = parseToken(token);
                // 解析对应的权限以及用户信息
                String uuid = (String) claims.get(Constants.LOGIN_USER_KEY);
                String userKey = getTokenKey(uuid);
                LoginUser user = redisCache.getCacheObject(userKey);
                user.setRequestToken(token);
                return user;
            } catch (Exception e) {
                log.info("获取缓存报错：{}", e.getMessage());
            }
        }
        return null;
    }

    /**
     * 获取用户身份信息
     *
     * @return 用户信息
     */
    public LoginUser getLoginUserByToken(String token) {
        if (StringUtils.isNotEmpty(token)) {
            try {
                Claims claims = parseToken(token);
                // 解析对应的权限以及用户信息
                String uuid = (String) claims.get(Constants.LOGIN_USER_KEY);
                String userKey = getTokenKey(uuid);
                LoginUser user = redisCache.getCacheObject(userKey);
                return user;
            } catch (Exception e) {
                log.info("获取缓存报错：{}", e.getMessage());
            }
        }
        return null;
    }

    /**
     * 根据用户id获取用户身份信息
     * 由于多端登录，根据token获取的用户信息不一样，所以增加一个根据用户id获取用户信息的缓存key，以后多端需要获取用户最新信息就用这个方法吧
     *
     * @return 用户信息
     */
    public LoginUser getLoginUserByUserId(Long userId) {
        if (userId != null) {
            try {
                String userKey = getUserIdKey(userId);
                return redisCache.getCacheObject(userKey);
            } catch (Exception e) {
                log.info("获取缓存报错：{}", e.getMessage());
            }
        }
        return null;
    }

    /**
     * 设置用户身份信息
     */
    public void setLoginUser(LoginUser loginUser) {
        if (StringUtils.isNotNull(loginUser) && StringUtils.isNotEmpty(loginUser.getToken())) {
            refreshToken(loginUser);
        }
    }

    /**
     * 删除用户身份信息
     */
    public void delLoginUser(String token) {
        if (StringUtils.isNotEmpty(token)) {
            String userKey = getTokenKey(token);
            redisCache.deleteObject(userKey);
        }
    }

    /**
     * 创建令牌
     *
     * @param loginUser 用户信息
     * @return 令牌
     */
    public String createToken(LoginUser loginUser) {
        String token = IdUtils.fastUUID();
        loginUser.setToken(token);
        setUserAgent(loginUser);
        refreshToken(loginUser);

        Map<String, Object> claims = new HashMap<>();
        claims.put(Constants.LOGIN_USER_KEY, token);
        return createToken(claims);
    }

    public int addToken(SysUser user, SysClient sysClient) {
        UserDetails userDetails = userDetailsServiceImpl.createLoginUser(user);
        LoginUser loginUser = (LoginUser) userDetails;
        sysClient.setToken(Constants.TOKEN_PREFIX + createToken(loginUser, sysClient.getClientSecret(), Math.toIntExact(sysClient.getTimeout())));
        return sysClientService.insertSysClient(sysClient);
    }

    public int updateToken(SysUser loginuser, SysClient sysClient) {
        LoginUser user;
        Claims claims = parseToken(sysClient);
        if (claims == null) {
            UserDetails userDetails = userDetailsServiceImpl.createLoginUser(loginuser);
            user = (LoginUser) userDetails;
            sysClient.setToken(Constants.TOKEN_PREFIX + createToken(user, sysClient.getClientSecret(), Math.toIntExact(sysClient.getTimeout())));
        } else {
            // 解析对应的权限以及用户信息
            String uuid = (String) claims.get(Constants.LOGIN_USER_KEY);
            String userKey = getTokenKey(uuid);
            user = redisCache.getCacheObject(userKey);
            if (user == null) {
                UserDetails userDetails = userDetailsServiceImpl.createLoginUser(loginuser);
                user = (LoginUser) userDetails;
            }
            log.debug("loginUser:{}", user);
            if (sysClient.getEnable() != null && "1".equals(sysClient.getEnable())) {
                delLoginUser(uuid);
                sysClient.setToken(Constants.TOKEN_PREFIX + createToken(user, sysClient.getClientSecret(), Math.toIntExact(sysClient.getTimeout())));
            } else if ("0".equals(sysClient.getEnable())) {
                delLoginUser(uuid);
            }
        }
        return sysClientService.updateSysClient(sysClient);
    }

    public String createToken(LoginUser loginUser, String secret, int expireTime) {
        String token = IdUtils.fastUUID();
        loginUser.setToken(token);
        setUserAgent(loginUser);
        refreshToken(loginUser, expireTime);

        Map<String, Object> claims = new HashMap<>();
        claims.put(Constants.LOGIN_USER_KEY, token);
        return createToken(claims, secret);
    }

    /**
     * 验证令牌有效期，相差不足20分钟，自动刷新缓存
     *
     * @param loginUser
     * @return 令牌
     */
    public void verifyToken(LoginUser loginUser) {
        long expireTime = loginUser.getExpireTime();
        long currentTime = System.currentTimeMillis();
        if (expireTime - currentTime <= MILLIS_MINUTE_TEN) {
            refreshToken(loginUser);
        }
    }

    /**
     * 刷新令牌有效期
     *
     * @param loginUser 登录信息
     */
    public void refreshToken(LoginUser loginUser, int expireTime) {
        loginUser.setLoginTime(System.currentTimeMillis());
        loginUser.setExpireTime(loginUser.getLoginTime() + expireTime * MILLIS_MINUTE);
        // 根据uuid将loginUser缓存
        String userKey = getTokenKey(loginUser.getToken());
        redisCache.setCacheObject(userKey, loginUser, expireTime, TimeUnit.MINUTES);
        // 使用token作为用户信息缓存key，多端不能同步最新信息，需要重新登录，因此添加一个使用用户id作为缓存key
        String userIdKey = getUserIdKey(loginUser.getUserId());
        redisCache.setCacheObject(userIdKey, loginUser, expireTime, TimeUnit.MINUTES);
    }

    public void refreshToken(LoginUser loginUser) {
        loginUser.setLoginTime(System.currentTimeMillis());
        loginUser.setExpireTime(loginUser.getLoginTime() + expireTime * MILLIS_MINUTE);
        // 根据uuid将loginUser缓存
        String userKey = getTokenKey(loginUser.getToken());
        String userIdKey = getUserIdKey(loginUser.getUserId());
        if (Boolean.TRUE.equals(loginUser.getNeverExpire())) {
            redisCache.setCacheObject(userKey, loginUser);
            // 使用token作为用户信息缓存key，多端不能同步最新信息，需要重新登录，因此添加一个使用用户id作为缓存key
            redisCache.setCacheObject(userIdKey, loginUser);
        } else {
            redisCache.setCacheObject(userKey, loginUser, expireTime, TimeUnit.MINUTES);
            // 使用token作为用户信息缓存key，多端不能同步最新信息，需要重新登录，因此添加一个使用用户id作为缓存key
            redisCache.setCacheObject(userIdKey, loginUser, expireTime, TimeUnit.MINUTES);
        }
    }

    /**
     * 设置用户代理信息
     *
     * @param loginUser 登录信息
     */
    public void setUserAgent(LoginUser loginUser) {
        UserAgent userAgent = UserAgent.parseUserAgentString(ServletUtils.getRequest().getHeader("User-Agent"));
        String ip = IpUtils.getIpAddr(ServletUtils.getRequest());
        loginUser.setIpaddr(ip);
        loginUser.setLoginLocation(AddressUtils.getRealAddressByIP(ip));
        loginUser.setBrowser(userAgent.getBrowser().getName());
        loginUser.setOs(userAgent.getOperatingSystem().getName());
    }

    /**
     * 从数据声明生成令牌
     *
     * @param claims 数据声明
     * @return 令牌
     */
    private String createToken(Map<String, Object> claims) {
        String token = Jwts.builder()
                .setClaims(claims)
                .signWith(SignatureAlgorithm.HS512, secret).compact();
        return token;
    }

    private String createToken(Map<String, Object> claims, String secret) {
        String token = Jwts.builder()
                .setClaims(claims)
                .signWith(SignatureAlgorithm.HS512, secret).compact();
        return token;
    }

    /**
     * 从令牌中获取数据声明
     *
     * @param token 令牌
     * @return 数据声明
     */
    private Claims parseToken(String token) {
        return Jwts.parser()
                .setSigningKey(secret)
                .parseClaimsJws(token)
                .getBody();

    }

    private Claims parseToken(SysClient sysClient) {
        if (sysClient.getClientSecret() != null && !Objects.equals(sysClient.getToken(), "")) {
            return Jwts.parser()
                    .setSigningKey(sysClient.getClientSecret())
                    .parseClaimsJws(sysClient.getToken().substring(Constants.TOKEN_PREFIX.length()))
                    .getBody();
        } else {
            return null;
        }
    }

    /**
     * 从令牌中获取用户名
     *
     * @param token 令牌
     * @return 用户名
     */
    public String getUsernameFromToken(String token) {
        Claims claims = parseToken(token);
        return claims.getSubject();
    }

    /**
     * 获取请求token
     *
     * @param request
     * @return token
     */
    private String getToken(HttpServletRequest request) {
        String token = request.getHeader(header);
        if (StringUtils.isNotEmpty(token) && token.startsWith(Constants.TOKEN_PREFIX)) {
            token = token.replace(Constants.TOKEN_PREFIX, "");
        }
        return token;
    }

    private String getTokenKey(String uuid) {
        return CacheConstants.LOGIN_TOKEN_KEY + uuid;
    }

    private String getUserIdKey(Long userId) {
        return CacheConstants.LOGIN_USERID_KEY + userId;
    }
}
