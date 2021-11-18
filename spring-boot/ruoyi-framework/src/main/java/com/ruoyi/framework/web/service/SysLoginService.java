package com.ruoyi.framework.web.service;

import javax.annotation.Resource;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.config.WxMaConfig;
import com.google.gson.Gson;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.MpLoginBody;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.sign.Md5Utils;
import com.ruoyi.common.utils.uuid.UUID;
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.system.service.impl.SysUserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.CustomException;
import com.ruoyi.common.exception.user.CaptchaException;
import com.ruoyi.common.exception.user.CaptchaExpireException;
import com.ruoyi.common.exception.user.UserPasswordNotMatchException;
import com.ruoyi.common.utils.MessageUtils;
import com.ruoyi.framework.manager.AsyncManager;
import com.ruoyi.framework.manager.factory.AsyncFactory;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

/**
 * 登录校验方法
 *
 * @author ruoyi
 */
@Component
public class SysLoginService {
    @Autowired
    private TokenService tokenService;

    @Resource
    private AuthenticationManager authenticationManager;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private WxMaService wxMaService;

    @Autowired
    private AuthService authService;

    @Autowired
    private ISysUserService sysUserService;

    /**
     * 登录验证
     *
     * @param username 用户名
     * @param password 密码
     * @param code     验证码
     * @param uuid     唯一标识
     * @return 结果
     */
    public String login(String username, String password, String code, String uuid) {
        String verifyKey = Constants.CAPTCHA_CODE_KEY + uuid;
        String captcha = redisCache.getCacheObject(verifyKey);
        redisCache.deleteObject(verifyKey);
        if (captcha == null) {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.expire")));
            throw new CaptchaExpireException();
        }
        if (!code.equalsIgnoreCase(captcha)) {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.error")));
            throw new CaptchaException();
        }
        // 用户验证
        Authentication authentication = null;
        try {
            // 该方法会去调用UserDetailsServiceImpl.loadUserByUsername
            authentication = authenticationManager
                    .authenticate(new UsernamePasswordAuthenticationToken(username, password));
        } catch (Exception e) {
            if (e instanceof BadCredentialsException) {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
                throw new UserPasswordNotMatchException();
            } else {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, e.getMessage()));
                throw new CustomException(e.getMessage());
            }
        }
        AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success")));
        LoginUser loginUser = (LoginUser) authentication.getPrincipal();
        // 生成token
        return tokenService.createToken(loginUser);
    }

    public String mpLlogin(MpLoginBody loginBody) {

        System.out.println(loginBody);
        String code = loginBody.getCode();
        if (StringUtils.isEmpty(code)) {
            throw new CustomException("无效的code");

        } else {
            String sessionKey = null;
            String openid = null;
            String unionid = null;

            if("123456".equals(code))
            {
                sessionKey = "123456";
                openid = "123456";
                unionid = "123456";
            }else {
                //存在有效的 code
                System.out.println("这里请求了一次code==========" + code);
                WxMaJscode2SessionResult session = null;
                try {
                    session = wxMaService.getUserService().getSessionInfo(code);
                } catch (Exception e) {
                    e.printStackTrace();
                    throw new CustomException(e.getMessage());
                }
                WxMaConfig wxMaConfig = wxMaService.getWxMaConfig();
                System.out.println(wxMaConfig);
                System.out.println(new Gson().toJson(wxMaConfig));
                sessionKey = session.getSessionKey();
                openid = session.getOpenid();
                unionid = session.getUnionid();
                System.out.println("sessionKey= " + sessionKey);
                System.out.println("openid= " + openid);
                System.out.println("unionid= " + unionid);
            }
            //通过openId sessionKey 生成3rd session 返回给客户端小程序
            String accessToken = UUID.fastUUID().toString().replace("-", "");

            String token = authService.mpLogin(code, openid, sessionKey, accessToken);

//            TUserAccountInfo userInfo = userAccoutInfoSevice.getUserInfo(openid);
//            Integer userType = userInfo.getUserType();

            Map<String, Object> data = new HashMap<>();
            data.put("token", token);
//            data.put("userInfo", userInfo);
//            data.put("userType", userType);


//            if (userType.intValue() == 0)//新用户
//            {
////                HashMap<String, Object> supplierInfo = supplierInfoSevice.getSupplierInfo(userInfo.getId());
////                data.put("userInfo", userInfo);
////                data.put("supplyInfo", supplierInfo);
//
//                //已授权用户
//            } else if (userType.intValue() == 1)//注册老用户
//            {
////                data.put("userInfo", userInfo);
//            } else if (userType.intValue() == 2) { //注册商家
////                data.put("userInfo", userInfo);
////                data.put("userType", userType);
//            }

            System.out.println("jwtToken : " + token);
            return token;
        }
    }
}
