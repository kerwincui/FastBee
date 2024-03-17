package com.fastbee.iot.model.login;

import com.fastbee.iot.domain.SocialPlatform;
import me.zhyd.oauth.request.AuthRequest;

public class AuthRequestWrap {
    private AuthRequest authRequest;

    private SocialPlatform socialPlatform;

    public AuthRequest getAuthRequest() {
        return authRequest;
    }

    public void setAuthRequest(AuthRequest authRequest) {
        this.authRequest = authRequest;
    }

    public SocialPlatform getSocialPlatform() {
        return socialPlatform;
    }

    public void setSocialPlatform(SocialPlatform socialPlatform) {
        this.socialPlatform = socialPlatform;
    }
}
