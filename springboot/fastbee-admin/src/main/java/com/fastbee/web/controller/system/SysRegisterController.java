package com.fastbee.web.controller.system;

import com.fastbee.common.utils.MessageUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.fastbee.common.core.controller.BaseController;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.domain.model.RegisterBody;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.framework.web.service.SysRegisterService;
import com.fastbee.system.service.ISysConfigService;

import javax.annotation.Resource;

/**
 * 注册验证
 * 
 * @author ruoyi
 */
@Api(tags = "注册账号")
@RestController
public class SysRegisterController extends BaseController
{
    @Resource
    private SysRegisterService registerService;

    @Resource
    private ISysConfigService configService;

    @ApiOperation("注册账号")
    @PostMapping("/register")
    public AjaxResult register(@RequestBody RegisterBody user)
    {
        if (!("true".equals(configService.selectConfigByKey("sys.account.registerUser"))))
        {
            return error(MessageUtils.message("sysRegister.fail.not.enable.register"));
        }
        String msg = registerService.register(user);
        return StringUtils.isEmpty(msg) ? success() : error(msg);
    }
}
