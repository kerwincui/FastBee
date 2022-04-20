package com.ruoyi.iot.service.impl;

import com.ruoyi.common.enums.SocialPlatformType;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.iot.domain.SocialPlatform;
import com.ruoyi.iot.model.login.AuthRequestWrap;
import com.ruoyi.iot.service.IAuthRequestFactory;
import com.ruoyi.iot.service.ISocialPlatformService;
import me.zhyd.oauth.config.AuthConfig;
import me.zhyd.oauth.request.AuthQqRequest;
import me.zhyd.oauth.request.AuthRequest;
import me.zhyd.oauth.request.AuthWeChatMpRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Locale;

@Service
public class AuthRequestFactoryImpl implements IAuthRequestFactory {

    private static final Logger log = LoggerFactory.getLogger(AuthRequestFactoryImpl.class);

    @Autowired
    private ISocialPlatformService iSocialPlatformService;

    @Autowired
    private AuthStateRedisCache authStateRedisCache;

    /**
     * 获得对于AUthRequest
     *
     * @param source 登录方式
     * @return 对应AuthRequest
     */
    @Override
    public AuthRequestWrap getAuthRequest(String source) {
        AuthRequestWrap authRequestWrap = new AuthRequestWrap();
        AuthRequest authRequest;
        try {
            SocialPlatformType socialPlatformType = SocialPlatformType.valueOf(source.toUpperCase(Locale.ROOT));
            SocialPlatform socialPlatform = iSocialPlatformService.selectSocialPlatformByPlatform(source);
            authRequestWrap.setSocialPlatform(socialPlatform);
            AuthConfig authConfig = AuthConfig.builder()
                    .clientId(socialPlatform.getClientId())
                    .clientSecret(socialPlatform.getSecretKey())
                    .redirectUri(socialPlatform.getRedirectUri())
                    .build();
            switch (socialPlatformType) {
                case QQ: {
                    authRequest = new AuthQqRequest(authConfig, authStateRedisCache);
                    break;
                }
                case Wechat: {
                    authRequest = new AuthWeChatMpRequest(authConfig, authStateRedisCache);
                    break;
                }
                default: {
                    throw new ServiceException("source: " + source + ",暂不支持");
                }
            }
            authRequestWrap.setAuthRequest(authRequest);
            return authRequestWrap;
        } catch (Exception e) {
            throw new ServiceException(e.getMessage());
        }
    }
}
