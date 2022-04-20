package com.ruoyi.iot.controller;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.BindLoginBody;
import com.ruoyi.common.core.domain.model.BindRegisterBody;
import com.ruoyi.iot.service.ISocialLoginService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import me.zhyd.oauth.model.AuthCallback;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 第三方登录接口Controller
 *
 * @author json
 * @date 2022-04-12
 */
@Api(tags = "第三方登录接口")
@RestController
@RequestMapping("/auth")
public class SocialLoginController {

    @Autowired
    private ISocialLoginService iSocialLoginService;


    @GetMapping("/render/{source}")
    @ApiOperation("跳转api")
    @ApiImplicitParam(name = "source", value = "登录类型", required = true, dataType = "String", paramType = "path", dataTypeClass = String.class)
    public void renderAuth(HttpServletResponse httpServletResponse, HttpServletRequest httpServletRequest, @PathVariable String source) throws IOException {
        // 生成授权页面
        httpServletResponse.sendRedirect(iSocialLoginService.renderAuth(source, httpServletRequest));
    }

    @GetMapping("/callback/{source}")
    @ApiOperation("回调api")
    @ApiImplicitParam(name = "source", value = "平台来源", required = true, dataType = "String", paramType = "path", dataTypeClass = String.class)
    public void login(@PathVariable("source") String source, AuthCallback authCallback, HttpServletResponse httpServletResponse, HttpServletRequest httpServletRequest) throws IOException {
        //回调接口
        httpServletResponse.sendRedirect(iSocialLoginService.callback(source, authCallback, httpServletRequest));
    }

    @GetMapping("/checkBindId/{bindId}")
    @ApiOperation("检查bindId")
    @ApiImplicitParam(name = "bindId", value = "绑定ID", required = true, dataType = "String", paramType = "path", dataTypeClass = String.class)
    public AjaxResult checkBindId(HttpServletResponse httpServletResponse, @PathVariable String bindId) {
        return iSocialLoginService.checkBindId(bindId);
    }

    @GetMapping("/getErrorMsg/{errorId}")
    @ApiOperation("获取errorMsg")
    @ApiImplicitParam(name = "errorId", value = "错误提示ID", required = true, dataType = "String", paramType = "path", dataTypeClass = String.class)
    public AjaxResult getErrorMsg(HttpServletResponse httpServletResponse, @PathVariable String errorId) {
        return iSocialLoginService.getErrorMsg(errorId);
    }

    /**
     * 已经绑定账户，跳转登录接口
     *
     * @param loginId
     * @return
     */
    @GetMapping("/login/{loginId}")
    @ApiOperation("跳转登录api")
    @ApiImplicitParam(name = "loginId", value = "登录Id", required = true, dataType = "String", paramType = "path", dataTypeClass = String.class)
    public AjaxResult socialLogin(@PathVariable String loginId) {
        // 生成授权页面
        return iSocialLoginService.socialLogin(loginId);
    }

    /**
     * 登录方法
     *
     * @param bindLoginBody 绑定登录信息
     * @return 结果
     */
    @PostMapping("/bind/login")
    public AjaxResult bindLogin(@RequestBody BindLoginBody bindLoginBody) {
        return iSocialLoginService.bindLogin(bindLoginBody);
    }

    /**
     * 注册绑定接口
     *
     * @param bindRegisterBody 注册信息
     * @return
     */
    @PostMapping("/bind/register")
    public AjaxResult bindRegister(@RequestBody BindRegisterBody bindRegisterBody) {
        return iSocialLoginService.bindRegister(bindRegisterBody);
    }


}



