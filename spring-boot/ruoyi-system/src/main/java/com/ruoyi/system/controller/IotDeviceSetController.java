/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
package com.ruoyi.system.controller;

import java.util.List;

import com.alibaba.fastjson.JSON;
import com.ruoyi.system.domain.IotDeviceStatus;
import com.ruoyi.system.mqtt.config.MqttPushClient;
import com.ruoyi.system.service.IIotDeviceStatusService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.IotDeviceSet;
import com.ruoyi.system.service.IIotDeviceSetService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 设备配置Controller
 * 
 * @author kerwincui
 * @date 2021-05-06
 */
@Api(value="设备配置",tags="设备配置")
@RestController
@RequestMapping("/system/set")
public class IotDeviceSetController extends BaseController
{
    @Autowired
    private IIotDeviceSetService iotDeviceSetService;
    @Autowired
    private IIotDeviceStatusService iotDeviceStatusService;

    @Autowired
    private MqttPushClient mqttPushClient;

    /**
     * 查询设备配置列表
     */
    @ApiOperation(value = "查询设备配置列表", notes = "查询设备配置列表")
    @PreAuthorize("@ss.hasPermi('system:set:list')")
    @GetMapping("/list")
    public TableDataInfo list(IotDeviceSet iotDeviceSet)
    {
        startPage();
        List<IotDeviceSet> list = iotDeviceSetService.selectIotDeviceSetList(iotDeviceSet);
        return getDataTable(list);
    }

    /**
     * 导出设备配置列表
     */
    @ApiOperation(value = "导出设备配置列表", notes = "导出设备配置列表")
    @PreAuthorize("@ss.hasPermi('system:set:export')")
    @Log(title = "设备配置", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(IotDeviceSet iotDeviceSet)
    {
        List<IotDeviceSet> list = iotDeviceSetService.selectIotDeviceSetList(iotDeviceSet);
        ExcelUtil<IotDeviceSet> util = new ExcelUtil<IotDeviceSet>(IotDeviceSet.class);
        return util.exportExcel(list, "set");
    }

    /**
     * 获取设备配置详细信息
     */
    @ApiOperation(value = "获取设备配置详情", notes = "获取设备配置详情")
    @PreAuthorize("@ss.hasPermi('system:set:query')")
    @GetMapping(value = "/{deviceSetId}")
    public AjaxResult getInfo(@PathVariable("deviceSetId") Long deviceSetId)
    {
        return AjaxResult.success(iotDeviceSetService.selectIotDeviceSetById(deviceSetId));
    }

    /**
     * 获取最新设备配置详细信息
     */
    @ApiOperation(value = "获取最新设备配置详情", notes = "获取最新设备配置详情")
    @PreAuthorize("@ss.hasPermi('system:set:query')")
    @GetMapping(value = "/new/{deviceId}")
    public AjaxResult getNewInfo(@PathVariable("deviceId") Long deviceId)
    {
        return AjaxResult.success(iotDeviceSetService.selectIotDeviceSetByDeviceId(deviceId));
    }

    /**
     * 新增设备配置
     */
    @ApiOperation(value = "新增设备配置", notes = "新增设备配置")
    @PreAuthorize("@ss.hasPermi('system:set:add')")
    @Log(title = "设备配置", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody IotDeviceSet iotDeviceSet)
    {
        return toAjax(iotDeviceSetService.insertIotDeviceSet(iotDeviceSet));
    }

    /**
     * 修改设备配置
     */
    @ApiOperation(value = "修改设备配置", notes = "修改设备配置")
    @PreAuthorize("@ss.hasPermi('system:set:edit')")
    @Log(title = "设备配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody IotDeviceSet iotDeviceSet)
    {
        IotDeviceStatus status=iotDeviceStatusService.selectIotDeviceStatusByDeviceId(iotDeviceSet.getDeviceId());
        if(status.getIsOnline()!=1){return AjaxResult.error("设备已离线，不能更新配置。");}
        // 存储
        iotDeviceSetService.updateIotDeviceSet(iotDeviceSet);

        //
        IotDeviceSet set=iotDeviceSetService.selectIotDeviceSetByDeviceId(iotDeviceSet.getDeviceId());
        if(iotDeviceSet.getIsRadar()!=null){
            set.setIsRadar(iotDeviceSet.getIsRadar());
        }
        if(iotDeviceSet.getIsAlarm()!=null){
            set.setIsAlarm(iotDeviceSet.getIsAlarm());
        }
        if(iotDeviceSet.getRadarInterval()!=null){
            set.setRadarInterval(iotDeviceSet.getRadarInterval());
        }
        if(iotDeviceSet.getIsRfControl()!=null){
            set.setIsRfControl(iotDeviceSet.getIsRfControl());
        }
        if(iotDeviceSet.getRfOneFunc()!=null){
            set.setRfOneFunc(iotDeviceSet.getRfOneFunc());
        }
        if(iotDeviceSet.getRfTwoFunc()!=null){
            set.setRfTwoFunc(iotDeviceSet.getRfTwoFunc());
        }
        if(iotDeviceSet.getRfThreeFunc()!=null){
            set.setRfThreeFunc(iotDeviceSet.getRfThreeFunc());
        }
        if(iotDeviceSet.getRfFourFunc()!=null){
            set.setRfFourFunc(iotDeviceSet.getRfFourFunc());
        }
        if(iotDeviceSet.getIsRfLearn()!=null){
            set.setIsRfLearn(iotDeviceSet.getIsRfLearn());
        }
        if(iotDeviceSet.getIsRfClear()!=null){
            set.setIsRfClear(iotDeviceSet.getIsRfClear());
        }
        if(iotDeviceSet.getIsAp()!=null){
            set.setIsAp(iotDeviceSet.getIsAp());
        }
        if(iotDeviceSet.getIsReset()!=null){
            set.setIsReset(iotDeviceSet.getIsReset());
        }
        String content = JSON.toJSONString(set);
        boolean isSuccess=mqttPushClient.publish(0,true,"setting/set/"+set.getDeviceNum(),content);
        if(isSuccess){return AjaxResult.success("mqtt 发布成功");}
        return AjaxResult.error("mqtt 发布失败。");
    }

    @ApiOperation(value = "mqtt获取设备配置", notes = "mqtt获取设备配置")
    @GetMapping(value = "/getSetting/{deviceNum}")
    public AjaxResult getSetting(@PathVariable("deviceNum") String deviceNum){
        boolean isSuccess=mqttPushClient.publish(0,true,"setting/get/"+deviceNum,"wumei.live");
        if(isSuccess){return AjaxResult.success("mqtt 发布成功");}
        return AjaxResult.error("mqtt 发布失败。");
    }

    /**
     * 删除设备配置
     */
    @ApiOperation(value = "删除设备配置", notes = "删除设备配置")
    @PreAuthorize("@ss.hasPermi('system:set:remove')")
    @Log(title = "设备配置", businessType = BusinessType.DELETE)
	@DeleteMapping("/{deviceSetIds}")
    public AjaxResult remove(@PathVariable Long[] deviceSetIds)
    {
        return toAjax(iotDeviceSetService.deleteIotDeviceSetByIds(deviceSetIds));
    }
}
