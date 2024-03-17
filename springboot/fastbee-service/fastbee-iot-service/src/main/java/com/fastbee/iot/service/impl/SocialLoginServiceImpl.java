package com.fastbee.iot.service.impl;

import com.fastbee.common.constant.Constants;
import com.fastbee.common.constant.HttpStatus;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.core.domain.model.BindLoginBody;
import com.fastbee.common.core.domain.model.BindRegisterBody;
import com.fastbee.common.core.domain.model.LoginUser;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.SecurityUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.common.utils.sign.Md5Utils;
import com.fastbee.framework.web.service.SysLoginService;
import com.fastbee.framework.web.service.SysRegisterService;
import com.fastbee.framework.web.service.TokenService;
import com.fastbee.iot.domain.SocialPlatform;
import com.fastbee.iot.domain.SocialUser;
import com.fastbee.iot.model.RegisterUserInput;
import com.fastbee.iot.model.login.AuthRequestWrap;
import com.fastbee.iot.model.login.BindIdValue;
import com.fastbee.iot.model.login.LoginIdValue;
import com.fastbee.iot.service.IAuthRequestFactory;
import com.fastbee.iot.service.ISocialLoginService;
import com.fastbee.iot.service.ISocialUserService;
import com.fastbee.iot.service.IToolService;
import com.fastbee.system.service.ISysConfigService;
import com.fastbee.system.service.ISysUserService;
import me.zhyd.oauth.exception.AuthException;
import me.zhyd.oauth.model.AuthCallback;
import me.zhyd.oauth.model.AuthResponse;
import me.zhyd.oauth.model.AuthUser;
import me.zhyd.oauth.utils.AuthStateUtils;
import me.zhyd.oauth.utils.RandomUtil;
import org.apache.commons.collections4.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.concurrent.TimeUnit;

import static com.fastbee.common.constant.HttpStatus.NO_MESSAGE_ALERT;
import static com.fastbee.common.core.domain.AjaxResult.error;

/**
 * 第三方登录Service业务层处理
 *
 * @author json
 * @date 2022-04-12
 */
@Service
public class SocialLoginServiceImpl implements ISocialLoginService {

    public static final Integer BIND_EXPIRE_TIME = 60 * 60;
    public static final Integer LOGIN_SOCIAL_EXPIRE_TIME = 60;
    public static final String ONLINE_STATUS = "0"; //1 offline
    public static final String DEL_FLAG = "0"; //1 offline
    public static final Integer WX_BIND_EXPIRE_TIME = 5;

    //redis key: uuid+source
    public static final String BIND_REDIS_KEY = "login:bind:user:";
    //redis key : userId+random 32
    public static final String LOGIN_SOCIAL_REDIS_KEY = "login:social:user:";
    //redis key : msg+ code+currentTime
    public static final String LOGIN_ERROR_MSG_REDIS_KEY = "login:error:msg:";
    //redis key : userId+random 32
    public static final String WX_BIND_REDIS_KEY = "wx:bind:user:";

    public static final String HTTPS = "https://";

    private static final Logger log = LoggerFactory.getLogger(SocialLoginServiceImpl.class);

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private ISysConfigService iSysConfigService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private SysRegisterService sysRegisterService;

    @Autowired
    private SysLoginService sysLoginService;

    @Autowired
    private ISysUserService iSysUserService;

    @Autowired
    private IAuthRequestFactory iAuthRequestFactory;

    @Autowired
    private ISocialUserService iSocialUserService;

    @Resource
    private IToolService toolService;


    @Override
    public String renderAuth(String source, HttpServletRequest httpServletRequest) {
        AuthRequestWrap authRequestWrap = null;
        try {
            authRequestWrap = iAuthRequestFactory.getAuthRequest(source);
            checkSocialPlatform(authRequestWrap.getSocialPlatform());
            return authRequestWrap.getAuthRequest().authorize(AuthStateUtils.createState());
        } catch (AuthException authException) {
            //返回错误信息
            log.error("", authException);
            if (authRequestWrap != null) {
                String errorId = genErrorId(authException.getMessage());
                return authRequestWrap.getSocialPlatform().getErrorMsgUri() + errorId;
            } else {
                return httpServletRequest.getProtocol() + httpServletRequest.getServerName() + httpServletRequest.getServerPort();
            }
        } catch (Exception exception) {
            //这类错误 直接不返回，重定向到主页
            log.error("", exception);
            return HTTPS + httpServletRequest.getServerName();
        }

    }

    @Override
    public String callback(String source, AuthCallback authCallback, HttpServletRequest httpServletRequest) {
        AuthRequestWrap authRequestWrap = null;
        try {
            authRequestWrap = iAuthRequestFactory.getAuthRequest(source);
            checkSocialPlatform(authRequestWrap.getSocialPlatform());
            AuthResponse<AuthUser> authResponse = authRequestWrap.getAuthRequest().login(authCallback);
            String bindId = null;
            String loginId = null;
            if (authResponse.ok()) {

                SocialUser socialUser = findSocialUser(authResponse.getData().getUuid(), authResponse.getData().getSource());
                // 同一开放平台下(unionid唯一)如果有其他应用已经微信登录绑定了账号，则直接绑定该账号登录
                Long bindSysUserId = null;
                String unionId = (String) authResponse.getData().getRawUserInfo().get("unionid");
                if ((socialUser == null || socialUser.getSysUserId() == null) && StringUtils.isNotEmpty(unionId)) {
                    bindSysUserId = iSocialUserService.selectSysUserIdByUnionId(unionId);
                }
                createOrUpdateSocialUser(socialUser, authResponse.getData(), source, bindSysUserId);
                if (bindSysUserId != null) {
                    socialUser = new SocialUser();
                    socialUser.setSysUserId(bindSysUserId);
                }
                if (socialUser == null) {
                    //第一次登录
                    bindId = genBindId(authResponse.getData());
                } else if (socialUser.getSysUserId() == null || socialUser.getSysUserId() <= 0) {
                    //初次绑定
                    bindId = genBindId(authResponse.getData());
                } else {
                    //查看是否已经绑定
                    SysUser sysUser = iSysUserService.selectUserById(socialUser.getSysUserId());
                    if (sysUser == null) {
                        bindId = genBindId(authResponse.getData());
                    } else {
                        //直接登录跳转
                        loginId = genLoginId(sysUser);
                    }
                }
                if (StringUtils.isNotEmpty(bindId)) {
                    return authRequestWrap.getSocialPlatform().getBindUri() + bindId;
                } else {
                    return authRequestWrap.getSocialPlatform().getRedirectLoginUri() + loginId;
                }
            } else {
                log.error("登录授权异常,code:{}, msg:{}", authResponse.getCode(), authResponse.getMsg());
                String errorId = genErrorId(authResponse.getMsg());
                return authRequestWrap.getSocialPlatform().getErrorMsgUri() + errorId;
            }
        } catch (AuthException authException) {
            //返回错误信息
            log.error("", authException);
            if (authRequestWrap != null) {
                String errorId = genErrorId(authException.getMessage());
                return authRequestWrap.getSocialPlatform().getErrorMsgUri() + errorId;
            } else {
                return httpServletRequest.getServerName() + httpServletRequest.getServerPort();
            }
        } catch (Exception exception) {
            log.error("", exception);
            return HTTPS + httpServletRequest.getServerName();
        }

    }

    @Override
    public AjaxResult checkBindId(String bindId) {
        AjaxResult ajax = AjaxResult.success();
        ajax.put("bindAccount", false);
        if (StringUtils.isEmpty(bindId)) {
            return ajax;
        }
        BindIdValue bindValue = redisCache.getCacheObject(BIND_REDIS_KEY + bindId);
        if (bindValue == null) {
            return ajax;
        }
        ajax.put("bindAccount", true);
        return AjaxResult.success(bindId);
    }

    @Override
    public AjaxResult getErrorMsg(String errorId) {
        String errorMsg = redisCache.getCacheObject(LOGIN_ERROR_MSG_REDIS_KEY + errorId);
        if (StringUtils.isEmpty(errorMsg)) {
            return error(NO_MESSAGE_ALERT, "");
        } else {
            return error(errorMsg);
        }
    }

    @Override
    public AjaxResult socialLogin(String loginId) {
        AjaxResult ajax = AjaxResult.success();
        String loginKey = LOGIN_SOCIAL_REDIS_KEY + loginId;
        LoginIdValue loginIdValue = redisCache.getCacheObject(loginKey);
        if (loginIdValue != null) {
            //login
            String token = sysLoginService.redirectLogin(loginIdValue.getUsername(), loginIdValue.getPassword());
            ajax.put(Constants.TOKEN, token);
        } else {
            log.info("loginId:{} ", loginId);
            return error(NO_MESSAGE_ALERT, "数据错误");
        }
        return ajax;
    }

    @Override
    public AjaxResult bindLogin(BindLoginBody bindLoginBody) {
        BindIdValue bindValue = redisCache.getCacheObject(BIND_REDIS_KEY + bindLoginBody.getBindId());
        SocialUser socialUser = findSocialUser(bindValue.getUuid(), bindValue.getSource());
        AjaxResult checkAjax = checkSocialUser(socialUser, bindLoginBody.getBindId());
        if (checkAjax != null) {
            return checkAjax;
        }
        AjaxResult ajax = AjaxResult.success();
        // 检查账号是否已经绑定微信
        SysUser sysUser = iSysUserService.selectUserByUserName(bindLoginBody.getUsername());
        if (sysUser == null) {
            // 单独返回code用户不存在,给前端处理
            return AjaxResult.error(HttpStatus.USER_NO_EXIST, "用户不存在");
        }
        // 自定义一下密码错误的提示
        if(!SecurityUtils.matchesPassword(bindLoginBody.getPassword(), sysUser.getPassword())){
            throw new ServiceException("密码错误");
        }
        List<SocialUser> socialUserList = iSocialUserService.selectBySysUserId(sysUser.getUserId());
        if (CollectionUtils.isNotEmpty(socialUserList)) {
            throw new ServiceException("该账号已经绑定其他微信，请先解绑后重试！");
        }
        // 生成令牌
        String token = sysLoginService.login(bindLoginBody.getUsername(), bindLoginBody.getPassword(), bindLoginBody.getCode(),
                bindLoginBody.getUuid());
        LoginUser loginUser = tokenService.getLoginUserByToken(token);
        //绑定和更新
        SocialUser updateSocialUser = new SocialUser();
        updateSocialUser.setSysUserId(loginUser.getUserId());
        updateSocialUser.setStatus("1");
        updateSocialUser.setSocialUserId(socialUser.getSocialUserId());
        iSocialUserService.updateSocialUser(updateSocialUser);
        ajax.put(Constants.TOKEN, token);
        redisCache.deleteObject(BIND_REDIS_KEY + bindLoginBody.getBindId());
        return ajax;
    }

    @Override
    public AjaxResult bindRegister(BindRegisterBody bindRegisterBody) {
        if (!("true".equals(iSysConfigService.selectConfigByKey("sys.account.registerUser")))) {
            return error("当前系统没有开启注册功能！");
        }
        BindIdValue bindValue = redisCache.getCacheObject(BIND_REDIS_KEY + bindRegisterBody.getBindId());
        SocialUser socialUser = findSocialUser(bindValue.getUuid(), bindValue.getSource());
        AjaxResult checkAjax = checkSocialUser(socialUser, bindRegisterBody.getBindId());
        if (checkAjax != null) {
            return checkAjax;
        }

        AjaxResult ajax = AjaxResult.success();
        RegisterUserInput registerUserInput = new RegisterUserInput();
        BeanUtils.copyProperties(bindRegisterBody, registerUserInput);
        String msg = toolService.register(registerUserInput);
        if (StringUtils.isNotEmpty(msg)) {
            return error(msg);
        }
        SysUser sysUser = iSysUserService.selectUserByUserName(bindRegisterBody.getUsername());
        //绑定和更新
        SocialUser updateSocialUser = new SocialUser();
        updateSocialUser.setSysUserId(sysUser.getUserId());
        updateSocialUser.setStatus("1");
        updateSocialUser.setSocialUserId(socialUser.getSocialUserId());
        iSocialUserService.updateSocialUser(updateSocialUser);
        redisCache.deleteObject(BIND_REDIS_KEY + bindRegisterBody.getBindId());
        // 生成令牌
        String token = sysLoginService.redirectLogin(sysUser.getUserName(), sysUser.getPassword());
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }

    private void checkSocialPlatform(SocialPlatform socialPlatform) {
        if (socialPlatform != null && (!socialPlatform.getStatus().equals(ONLINE_STATUS) || !socialPlatform.getDelFlag().equals(DEL_FLAG))) {
            throw new AuthException("当前第三方登录平台被禁用");
        }
    }

    @Override
    public SocialUser findSocialUser(String uuid, String source) {
        SocialUser socialUser = new SocialUser();
        socialUser.setSource(source);
        socialUser.setUuid(uuid);
        List<SocialUser> socialUserList = iSocialUserService.selectSocialUserList(socialUser);
        return socialUserList == null || socialUserList.isEmpty() ? null : socialUserList.get(0);

    }

    public void createOrUpdateSocialUser(SocialUser socialUser, AuthUser authUser, String source, Long bindSysUserId) {
        if (socialUser != null) {
            //更新数据
            SocialUser updateSocialUser = new SocialUser();
            updateSocialUser.setSocialUserId(socialUser.getSocialUserId());
            replaceSocialUser(updateSocialUser, authUser);
            updateSocialUser.setUpdateBy("System");
            updateSocialUser.setUpdateTime(DateUtils.getNowDate());
            updateSocialUser.setSourceClient(source);
            if (socialUser.getSysUserId() == null && bindSysUserId != null) {
                updateSocialUser.setSysUserId(bindSysUserId);
                updateSocialUser.setStatus("1");
            }
            iSocialUserService.updateSocialUser(updateSocialUser);
        } else {
            //创建
            SocialUser saveSocialUser = new SocialUser();
            replaceSocialUser(saveSocialUser, authUser);
            saveSocialUser.setDelFlag("0");
            saveSocialUser.setCreateBy("System");
            saveSocialUser.setCreateTime(DateUtils.getNowDate());
            saveSocialUser.setSourceClient(source);
            if (bindSysUserId != null) {
                saveSocialUser.setSysUserId(bindSysUserId);
                saveSocialUser.setStatus("1");
            } else {
                saveSocialUser.setStatus("0");
            }
            iSocialUserService.insertSocialUser(saveSocialUser);
        }
    }

    private void replaceSocialUser(SocialUser socialUser, AuthUser authUser) {

        socialUser.setUuid(authUser.getUuid());
        socialUser.setSource(authUser.getSource());
        socialUser.setAccessToken(authUser.getToken().getAccessToken());
        //nullable
        socialUser.setExpireIn((long) authUser.getToken().getExpireIn());
        socialUser.setRefreshToken(authUser.getToken().getRefreshToken());
        socialUser.setOpenId(authUser.getToken().getOpenId());
        socialUser.setUid(authUser.getToken().getUid());
        socialUser.setAccessCode(authUser.getToken().getAccessCode());
        socialUser.setUnionId(authUser.getToken().getUnionId());
        socialUser.setCode(authUser.getToken().getCode());
        socialUser.setAvatar(authUser.getAvatar());
        socialUser.setUsername(authUser.getUsername());
        socialUser.setNickname(authUser.getNickname());
    }

    public String genBindId(AuthUser authUser) {
        String bindId = Md5Utils.hash(authUser.getUuid() + authUser.getSource());
        String key = BIND_REDIS_KEY + bindId;
        BindIdValue bindIdValue = new BindIdValue();
        bindIdValue.setSource(authUser.getSource());
        bindIdValue.setUuid(authUser.getUuid());
        redisCache.setCacheObject(key, bindIdValue, BIND_EXPIRE_TIME, TimeUnit.SECONDS);
        return bindId;
    }

    private String genLoginId(SysUser sysUser) {
        String loginId = Md5Utils.hash(sysUser.getUserId() + RandomUtil.randomString(32));
        String key = LOGIN_SOCIAL_REDIS_KEY + loginId;
        LoginIdValue loginIdValue = new LoginIdValue();
        loginIdValue.setPassword(sysUser.getPassword());
        loginIdValue.setUsername(sysUser.getUserName());
        redisCache.setCacheObject(key, loginIdValue, LOGIN_SOCIAL_EXPIRE_TIME, TimeUnit.SECONDS);
        return loginId;
    }

    public String genErrorId(String msg) {
        String errorId = Md5Utils.hash(msg + RandomUtil.randomString(32));
        String key = LOGIN_ERROR_MSG_REDIS_KEY + errorId;
        redisCache.setCacheObject(key, msg, LOGIN_SOCIAL_EXPIRE_TIME, TimeUnit.SECONDS);
        return errorId;
    }

    public String genWxBindId(Long userId) {
        String wxBindId = Md5Utils.hash(userId + RandomUtil.randomString(32));
        String key = WX_BIND_REDIS_KEY + wxBindId;
        redisCache.setCacheObject(key, userId, WX_BIND_EXPIRE_TIME, TimeUnit.MINUTES);
        return wxBindId;
    }

    @Override
    public AjaxResult checkSocialUser(SocialUser socialUser, String bindId) {
        if (socialUser == null) {
            log.info("bindId不存在, bindId: {}", bindId);
            return error("绑定账户不存在");
        } else {
            return null;
        }
    }

    private int createSocialUser(AuthUser authUser, String sourceClient, Long sysUserId) {
        //创建
        SocialUser saveSocialUser = new SocialUser();
        replaceSocialUser(saveSocialUser, authUser);
        saveSocialUser.setDelFlag("0");
        saveSocialUser.setCreateBy("System");
        saveSocialUser.setCreateTime(DateUtils.getNowDate());
        saveSocialUser.setSourceClient(sourceClient);
        saveSocialUser.setSysUserId(sysUserId);
        saveSocialUser.setStatus("1");
        return iSocialUserService.insertSocialUser(saveSocialUser);
    }

}
