package com.fastbee.iot.oauth.api;

import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.domain.model.LoginBody;
import com.fastbee.common.utils.SecurityUtils;
import com.fastbee.framework.web.service.SysLoginService;
import com.fastbee.framework.web.service.TokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginController {


    @Autowired
    private TokenStore tokenStore;

    @Autowired
    private SysLoginService loginService;

    @Autowired
    private TokenService tokenService;

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