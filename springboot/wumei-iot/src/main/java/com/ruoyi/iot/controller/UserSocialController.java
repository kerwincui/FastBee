package com.ruoyi.iot.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.iot.service.IUserSocialProfileService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 第三方登录平台控制Controller
 *
 * @author json
 * @date 2022-04-24
 */
@Api(tags = "用户社交账户api")
@RestController
@RequestMapping("/iot/social/")
public class UserSocialController extends BaseController {

    @Autowired
    private IUserSocialProfileService iUserSocialProfileService;


    /**
     * 绑定
     *
     * @param bindId 绑定id
     * @return
     */
    @GetMapping("/bindId/{bindId}")
    @ApiOperation("绑定api")
    @ApiImplicitParam(name = "bindId", value = "绑定bindId", required = true, dataType = "String", paramType = "path", dataTypeClass = String.class)
    public AjaxResult bindUser(@PathVariable String bindId) {
        return iUserSocialProfileService.bindUser(bindId, getUserId());
    }


    /**
     * 绑定
     *
     * @param platform 绑定类型
     * @return
     */
    @GetMapping("/bind/{platform}")
    @ApiOperation("绑定跳转api")
    @ApiImplicitParam(name = "platform", value = "绑定platform", required = true, dataType = "String", paramType = "path", dataTypeClass = String.class)
    public AjaxResult bind(@PathVariable String platform) {
        return iUserSocialProfileService.bindSocialAccount(platform);
    }

    /**
     * 解绑
     *
     * @param socialUserId 用户社交平台Id
     * @return
     */
    @GetMapping("/unbind/{socialUserId}")
    @ApiOperation("解绑api")
    @ApiImplicitParam(name = "socialUserId", value = "绑定socialId", required = true, dataType = "Long", paramType = "path", dataTypeClass = Long.class)
    public AjaxResult unbind(@PathVariable Long socialUserId) {
        return iUserSocialProfileService.unbindSocialAccount(socialUserId, getUserId());
    }
}
