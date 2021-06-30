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

import com.ruoyi.system.domain.vo.IotDeviceListDto;
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
@Api(value="设备",tags="设备")
@RestController
@RequestMapping("/system/device")
public class IotDeviceController extends BaseController
{
    @Autowired
    private IIotDeviceService iotDeviceService;

    /**
     * 查询设备列表
     */
    @ApiOperation(value = "设备列表", notes = "设备列表")
    @PreAuthorize("@ss.hasPermi('system:device:list')")
    @GetMapping("/list")
    public TableDataInfo list(IotDevice iotDevice)
    {
        startPage();
        List<IotDeviceListDto> list = iotDeviceService.selectIotDeviceList(iotDevice);
        return getDataTable(list);
    }

    /**
     * 导出设备列表
     */
    @ApiOperation(value = "导出设备列表", notes = "导出设备列表")
    @PreAuthorize("@ss.hasPermi('system:device:export')")
    @Log(title = "设备", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(IotDevice iotDevice)
    {
        List<IotDeviceListDto> list = iotDeviceService.selectIotDeviceList(iotDevice);
        ExcelUtil<IotDeviceListDto> util = new ExcelUtil<IotDeviceListDto>(IotDeviceListDto.class);
        return util.exportExcel(list, "device");
    }

    /**
     * 获取设备详细信息
     */
    @ApiOperation(value = "获取设备详情", notes = "获取设备详情")
    @PreAuthorize("@ss.hasPermi('system:device:query')")
    @GetMapping(value = "/{deviceId}")
    public AjaxResult getInfo(@PathVariable("deviceId") Long deviceId)
    {
        return AjaxResult.success(iotDeviceService.selectIotDeviceById(deviceId));
    }

    /**
     * 根据设备编号获取设备详细信息
     */
    @ApiOperation(value = "根据设备编号获取设备详情", notes = "根据设备编号获取设备详情")
    @PreAuthorize("@ss.hasPermi('system:device:query')")
    @GetMapping(value = "/getByNum/{deviceNum}")
    public AjaxResult getInfoByNum(@PathVariable("deviceNum") String deviceNum)
    {
        return AjaxResult.success(iotDeviceService.selectIotDeviceByNum(deviceNum));
    }

    /**
     * 新增设备
     */
    @ApiOperation(value = "新增设备", notes = "新增设备")
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
    @ApiOperation(value = "修改设备", notes = "修改设备")
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
    @ApiOperation(value = "删除设备", notes = "删除设备")
    @PreAuthorize("@ss.hasPermi('system:device:remove')")
    @Log(title = "设备", businessType = BusinessType.DELETE)
	@DeleteMapping("/{deviceIds}")
    public AjaxResult remove(@PathVariable Long[] deviceIds)
    {
        return toAjax(iotDeviceService.deleteIotDeviceByIds(deviceIds));
    }
}
