package com.fastbee.data.controller;

import com.fastbee.common.core.controller.BaseController;
import com.fastbee.common.utils.MessageUtils;
import org.springframework.web.bind.annotation.*;

/**
 * 设备告警Controller
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
@RestController
@RequestMapping("/oauth/resource")
public class AuthResourceController extends BaseController
{
    /**
     * 查询设备告警列表
     */
    @GetMapping("/product")
    public String findAll() {
        return MessageUtils.message("auth.resource.product.query.success");
    }


}
