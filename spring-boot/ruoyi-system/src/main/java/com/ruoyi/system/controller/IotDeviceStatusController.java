package com.ruoyi.system.controller;

import java.util.List;

import com.alibaba.fastjson.JSON;
import com.ruoyi.system.mqtt.config.MqttPushClient;
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
import com.ruoyi.system.domain.IotDeviceStatus;
import com.ruoyi.system.service.IIotDeviceStatusService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 设备状态Controller
 * 
 * @author kerwincui
 * @date 2021-05-06
 */
@Api(value="设备状态",tags="设备状态")
@RestController
@RequestMapping("/system/status")
public class IotDeviceStatusController extends BaseController
{
    @Autowired
    private IIotDeviceStatusService iotDeviceStatusService;

    @Autowired
    private MqttPushClient mqttPushClient;

    /**
     * 查询设备状态列表
     */
    @ApiOperation(value = "查询设备状态列表", notes = "查询设备状态列表")
    @PreAuthorize("@ss.hasPermi('system:status:list')")
    @GetMapping("/list")
    public TableDataInfo list(IotDeviceStatus iotDeviceStatus)
    {
        startPage();
        List<IotDeviceStatus> list = iotDeviceStatusService.selectIotDeviceStatusList(iotDeviceStatus);
        return getDataTable(list);
    }

    /**
     * 导出设备状态列表
     */
    @ApiOperation(value = "导出设备状态列表", notes = "导出设备状态列表")
    @PreAuthorize("@ss.hasPermi('system:status:export')")
    @Log(title = "设备状态", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(IotDeviceStatus iotDeviceStatus)
    {
        List<IotDeviceStatus> list = iotDeviceStatusService.selectIotDeviceStatusList(iotDeviceStatus);
        ExcelUtil<IotDeviceStatus> util = new ExcelUtil<IotDeviceStatus>(IotDeviceStatus.class);
        return util.exportExcel(list, "status");
    }

    /**
     * 获取设备状态详细信息
     */
    @ApiOperation(value = "获取设备状态详情", notes = "获取设备状态详情")
    @PreAuthorize("@ss.hasPermi('system:status:query')")
    @GetMapping(value = "/{deviceStatusId}")
    public AjaxResult getInfo(@PathVariable("deviceStatusId") Long deviceStatusId)
    {
        return AjaxResult.success(iotDeviceStatusService.selectIotDeviceStatusById(deviceStatusId));
    }

    /**
     * 根据设备编号获取设备状态
     */
    @ApiOperation(value = "根据设备编号获取最新设备状态", notes = "根据设备编号获取最新设备状态")
    @PreAuthorize("@ss.hasPermi('system:status:query')")
    @GetMapping(value = "/newByNum/{deviceNum}")
    public AjaxResult getNewStatus(@PathVariable("deviceNum") String deviceNum)
    {
        return AjaxResult.success(iotDeviceStatusService.selectIotDeviceStatusByDeviceNum(deviceNum));
    }

    /**
     * 获取最新设备状态详细信息
     */
    @ApiOperation(value = "获取最新设备状态详情", notes = "获取最新设备状态详情")
    @PreAuthorize("@ss.hasPermi('system:status:query')")
    @GetMapping(value = "/new/{deviceId}")
    public AjaxResult getNewInfo(@PathVariable("deviceId") Long deviceId)
    {
        return AjaxResult.success(iotDeviceStatusService.selectIotDeviceStatusByDeviceId(deviceId));
    }

    /**
     * 新增设备状态
     */
    @ApiOperation(value = "新增设备状态", notes = "新增设备状态")
    @PreAuthorize("@ss.hasPermi('system:status:add')")
    @Log(title = "设备状态", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody IotDeviceStatus iotDeviceStatus)
    {
        return toAjax(iotDeviceStatusService.insertIotDeviceStatus(iotDeviceStatus));
    }

    /**
     * 修改设备状态
     */
    @ApiOperation(value = "修改设备状态", notes = "修改设备状态")
    @PreAuthorize("@ss.hasPermi('system:status:edit')")
    @Log(title = "设备状态", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody IotDeviceStatus iotDeviceStatus)
    {
        // 存储
        iotDeviceStatusService.updateIotDeviceStatus(iotDeviceStatus);
        // mqtt发布
        String content = JSON.toJSONString(iotDeviceStatus);
        boolean isSuccess=mqttPushClient.publish(1,true,"status/set/"+iotDeviceStatus.getDeviceNum(),content);
        if(isSuccess){return AjaxResult.success("mqtt 发布成功");}
        return AjaxResult.error("mqtt 发布失败。");
    }

    @ApiOperation(value = "mqtt获取设备状态", notes = "mqtt获取设备状态")
    @GetMapping(value = "/getStatus/{deviceNum}")
    public AjaxResult getStatus(@PathVariable("deviceNum") String deviceNum){
        boolean isSuccess=mqttPushClient.publish(0,true,"status/get/"+deviceNum,"wumei.live");
        if(isSuccess){return AjaxResult.success("mqtt 发布成功");}
        return AjaxResult.error("mqtt 发布失败。");
    }

    /**
     * 删除设备状态
     */
    @ApiOperation(value = "删除设备状态", notes = "删除设备状态")
    @PreAuthorize("@ss.hasPermi('system:status:remove')")
    @Log(title = "设备状态", businessType = BusinessType.DELETE)
	@DeleteMapping("/{deviceStatusIds}")
    public AjaxResult remove(@PathVariable Long[] deviceStatusIds)
    {
        return toAjax(iotDeviceStatusService.deleteIotDeviceStatusByIds(deviceStatusIds));
    }
}
