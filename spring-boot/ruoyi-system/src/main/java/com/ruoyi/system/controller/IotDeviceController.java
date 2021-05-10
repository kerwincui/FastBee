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
import com.ruoyi.system.domain.IotDevice;
import com.ruoyi.system.service.IIotDeviceService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 设备Controller
 * 
 * @author kerwincui
 * @date 2021-05-06
 */
@RestController
@RequestMapping("/system/device")
public class IotDeviceController extends BaseController
{
    @Autowired
    private IIotDeviceService iotDeviceService;

    /**
     * 查询设备列表
     */
    @PreAuthorize("@ss.hasPermi('system:device:list')")
    @GetMapping("/list")
    public TableDataInfo list(IotDevice iotDevice)
    {
        startPage();
        List<IotDevice> list = iotDeviceService.selectIotDeviceList(iotDevice);
        return getDataTable(list);
    }

    /**
     * 导出设备列表
     */
    @PreAuthorize("@ss.hasPermi('system:device:export')")
    @Log(title = "设备", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(IotDevice iotDevice)
    {
        List<IotDevice> list = iotDeviceService.selectIotDeviceList(iotDevice);
        ExcelUtil<IotDevice> util = new ExcelUtil<IotDevice>(IotDevice.class);
        return util.exportExcel(list, "device");
    }

    /**
     * 获取设备详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:device:query')")
    @GetMapping(value = "/{deviceId}")
    public AjaxResult getInfo(@PathVariable("deviceId") Long deviceId)
    {
        return AjaxResult.success(iotDeviceService.selectIotDeviceById(deviceId));
    }

    /**
     * 新增设备
     */
    @PreAuthorize("@ss.hasPermi('system:device:add')")
    @Log(title = "设备", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody IotDevice iotDevice)
    {
        return toAjax(iotDeviceService.insertIotDevice(iotDevice));
    }

    /**
     * 修改设备
     */
    @PreAuthorize("@ss.hasPermi('system:device:edit')")
    @Log(title = "设备", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody IotDevice iotDevice)
    {
        return toAjax(iotDeviceService.updateIotDevice(iotDevice));
    }

    /**
     * 删除设备
     */
    @PreAuthorize("@ss.hasPermi('system:device:remove')")
    @Log(title = "设备", businessType = BusinessType.DELETE)
	@DeleteMapping("/{deviceIds}")
    public AjaxResult remove(@PathVariable Long[] deviceIds)
    {
        return toAjax(iotDeviceService.deleteIotDeviceByIds(deviceIds));
    }
}
