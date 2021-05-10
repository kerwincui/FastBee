package com.ruoyi.system.controller;

import com.alibaba.fastjson.JSON;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.IotDeviceSet;
import com.ruoyi.system.domain.IotDeviceStatus;
import com.ruoyi.system.mqtt.config.MqttPushClient;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;



/**
 * swagger 用户测试方法
 *
 */
@Api("mqtt测试")
@RestController
@RequestMapping("/test/mqtt")
public class MqttController extends BaseController
{
    @Autowired
    private MqttPushClient mqttPushClient;

    @ApiOperation(value = "更新设备状态", notes = "更新设备状态")
    @PostMapping(value = "/updateStatus")
    public AjaxResult updateStatus(@RequestBody IotDeviceStatus iotDeviceStatus){
        String content = JSON.toJSONString(iotDeviceStatus);
        boolean isSuccess=mqttPushClient.publish(1,false,"status/"+iotDeviceStatus.getDeviceNum(),content);
        if(isSuccess){return AjaxResult.success();}
        return AjaxResult.error("mqtt 发布失败。");
    }

    @ApiOperation(value = "获取设备状态", notes = "获取设备状态")
    @GetMapping(value = "/getStatus/{deviceNum}")
    public AjaxResult getStatus(@PathVariable("deviceNum") String deviceNum){
        boolean isSuccess=mqttPushClient.publish(0,false,"status/new/"+deviceNum,"");
        if(isSuccess){return AjaxResult.success();}
        return AjaxResult.error("mqtt 发布失败。");
    }

    @ApiOperation(value = "更新设备配置", notes = "更新设备配置")
    @PostMapping(value = "/updateSetting")
    public AjaxResult updateSetting(@RequestBody IotDeviceSet iotDeviceSet){
        String content = JSON.toJSONString(iotDeviceSet);
        boolean isSuccess=mqttPushClient.publish(0,false,"setting/"+iotDeviceSet.getDeviceNum(),content);
        if(isSuccess){return AjaxResult.success();}
        return AjaxResult.error("mqtt 发布失败。");
    }

    @ApiOperation(value = "获取设备配置", notes = "获取设备配置")
    @GetMapping(value = "/getSetting/{deviceNum}")
    public AjaxResult getSetting(@PathVariable("deviceNum") String deviceNum){
        boolean isSuccess=mqttPushClient.publish(0,false,"Setting/new/"+deviceNum,"");
        if(isSuccess){return AjaxResult.success();}
        return AjaxResult.error("mqtt 发布失败。");
    }
}

