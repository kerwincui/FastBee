package com.ruoyi.iot.oauth.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginController {
    @Autowired
    private TokenStore tokenStore;

    @RequestMapping("/oauth/login")
    public String login() {
        return "oauth/login";
    }

    @RequestMapping("/oauth/index")
    public String index() {
        return "oauth/index";
    }

    @GetMapping("/oauth/logout")
    @ResponseBody
    public String logout(@RequestHeader String Authorization) {
        if (!Authorization.isEmpty()){
            String token=Authorization.split(" ")[1];
            OAuth2AccessToken auth2AccessToken = tokenStore.readAccessToken(token);
            tokenStore.removeAccessToken(auth2AccessToken);
            return "SUCCESS";
        }else{
            return "FAIL";
        }
       
    }
}