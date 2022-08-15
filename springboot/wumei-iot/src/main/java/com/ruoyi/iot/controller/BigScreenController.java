package com.ruoyi.iot.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.iot.model.bigscreen.vo.BigScreenMapReqVo;
import com.ruoyi.iot.service.IBigScreenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


/**
 * 设备告警Controller
 * 
 * @author long
 * @date 2022-01-13
 */
@RestController
@RequestMapping("/iot/big/screen")
public class BigScreenController extends BaseController
{
    private final IBigScreenService bigScreenService;

    @Autowired
    public BigScreenController(IBigScreenService bigScreenService) {
        this.bigScreenService = bigScreenService;
    }

    /**
     * 大屏首页 地图
     */
    @PostMapping("/map")
    public AjaxResult index(@RequestBody BigScreenMapReqVo reqVo)
    {
        return AjaxResult.success(bigScreenService.map(reqVo));
    }

}
