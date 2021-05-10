package com.ruoyi.system.controller;

import java.util.List;
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
@RestController
@RequestMapping("/system/status")
public class IotDeviceStatusController extends BaseController
{
    @Autowired
    private IIotDeviceStatusService iotDeviceStatusService;

    /**
     * 查询设备状态列表
     */
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
    @PreAuthorize("@ss.hasPermi('system:status:query')")
    @GetMapping(value = "/{deviceStatusId}")
    public AjaxResult getInfo(@PathVariable("deviceStatusId") Long deviceStatusId)
    {
        return AjaxResult.success(iotDeviceStatusService.selectIotDeviceStatusById(deviceStatusId));
    }

    /**
     * 获取最新设备状态详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:status:query')")
    @GetMapping(value = "/new/{deviceId}")
    public AjaxResult getNewInfo(@PathVariable("deviceId") Long deviceId)
    {
        return AjaxResult.success(iotDeviceStatusService.selectIotDeviceStatusByDeviceId(deviceId));
    }

    /**
     * 新增设备状态
     */
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
    @PreAuthorize("@ss.hasPermi('system:status:edit')")
    @Log(title = "设备状态", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody IotDeviceStatus iotDeviceStatus)
    {
        return toAjax(iotDeviceStatusService.updateIotDeviceStatus(iotDeviceStatus));
    }

    /**
     * 删除设备状态
     */
    @PreAuthorize("@ss.hasPermi('system:status:remove')")
    @Log(title = "设备状态", businessType = BusinessType.DELETE)
	@DeleteMapping("/{deviceStatusIds}")
    public AjaxResult remove(@PathVariable Long[] deviceStatusIds)
    {
        return toAjax(iotDeviceStatusService.deleteIotDeviceStatusByIds(deviceStatusIds));
    }
}
