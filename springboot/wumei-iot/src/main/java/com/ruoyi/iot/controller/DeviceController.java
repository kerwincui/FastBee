package com.ruoyi.iot.controller;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.iot.domain.Device;
import com.ruoyi.iot.model.DeviceAllShortOutput;
import com.ruoyi.iot.model.DeviceRelateUserInput;
import com.ruoyi.iot.model.DeviceShortOutput;
import com.ruoyi.iot.mqtt.EmqxService;
import com.ruoyi.iot.service.IDeviceService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * 设备Controller
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@Api(tags = "设备管理")
@RestController
@RequestMapping("/iot/device")
public class DeviceController extends BaseController
{
    @Autowired
    private IDeviceService deviceService;

    @Lazy
    @Autowired
    private EmqxService emqxService;

    /**
     * 查询设备列表
     */
    @PreAuthorize("@ss.hasPermi('iot:device:list')")
    @GetMapping("/list")
    @ApiOperation("设备分页列表")
    public TableDataInfo list(Device device)
    {
        startPage();
        return getDataTable(deviceService.selectDeviceList(device));
    }

    /**
     * 查询未分配授权码设备列表
     */
    @PreAuthorize("@ss.hasPermi('iot:device:list')")
    @GetMapping("/unAuthlist")
    @ApiOperation("设备分页列表")
    public TableDataInfo unAuthlist(Device device)
    {
        startPage();
        return getDataTable(deviceService.selectUnAuthDeviceList(device));
    }

    /**
     * 查询分组可添加设备
     */
    @PreAuthorize("@ss.hasPermi('iot:device:list')")
    @GetMapping("/listByGroup")
    @ApiOperation("查询分组可添加设备分页列表")
    public TableDataInfo listByGroup(Device device)
    {
        startPage();
        return getDataTable(deviceService.selectDeviceListByGroup(device));
    }

    /**
     * 查询设备简短列表，主页列表数据
     */
    @PreAuthorize("@ss.hasPermi('iot:device:list')")
    @GetMapping("/shortList")
    @ApiOperation("设备分页简短列表")
    public TableDataInfo shortList(Device device)
    {
        startPage();
        return getDataTable(deviceService.selectDeviceShortList(device));
    }

    /**
     * 查询所有设备简短列表
     */
    @PreAuthorize("@ss.hasPermi('iot:device:list')")
    @GetMapping("/all")
    @ApiOperation("查询所有设备简短列表")
    public TableDataInfo allShortList()
    {
        return getDataTable(deviceService.selectAllDeviceShortList());
    }

    /**
     * 导出设备列表
     */
    @PreAuthorize("@ss.hasPermi('iot:device:export')")
    @Log(title = "设备", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出设备")
    public void export(HttpServletResponse response, Device device)
    {
        List<Device> list = deviceService.selectDeviceList(device);
        ExcelUtil<Device> util = new ExcelUtil<Device>(Device.class);
        util.exportExcel(response, list, "设备数据");
    }

    /**
     * 获取设备详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:device:query')")
    @GetMapping(value = "/{deviceId}")
    @ApiOperation("获取设备详情")
    public AjaxResult getInfo(@PathVariable("deviceId") Long deviceId)
    {
        return AjaxResult.success(deviceService.selectDeviceByDeviceId(deviceId));
    }

    /**
     * 设备数据同步
     */
    @PreAuthorize("@ss.hasPermi('iot:device:query')")
    @GetMapping(value = "/synchronization/{serialNumber}")
    @ApiOperation("设备数据同步")
    public AjaxResult deviceSynchronization(@PathVariable("serialNumber") String serialNumber)
    {
        return AjaxResult.success(emqxService.deviceSynchronization(serialNumber));
    }

    /**
     * 根据设备编号详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:device:query')")
    @GetMapping(value = "/getDeviceBySerialNumber/{serialNumber}")
    @ApiOperation("根据设备编号获取设备详情")
    public AjaxResult getInfoBySerialNumber(@PathVariable("serialNumber") String serialNumber)
    {
        return AjaxResult.success(deviceService.selectDeviceBySerialNumber(serialNumber));
    }

    /**
     * 获取设备统计信息
     */
    @PreAuthorize("@ss.hasPermi('iot:device:query')")
    @GetMapping(value = "/statistic")
    @ApiOperation("获取设备统计信息")
    public AjaxResult getDeviceStatistic()
    {
        return AjaxResult.success(deviceService.selectDeviceStatistic());
    }

    /**
     * 获取设备详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:device:query')")
    @GetMapping(value = "/runningStatus/{deviceId}")
    @ApiOperation("获取设备详情和运行状态")
    public AjaxResult getRunningStatusInfo(@PathVariable("deviceId") Long deviceId)
    {
        return AjaxResult.success(deviceService.selectDeviceRunningStatusByDeviceId(deviceId));
    }

    /**
     * 新增设备
     */
    @PreAuthorize("@ss.hasPermi('iot:device:add')")
    @Log(title = "添加设备", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("添加设备")
    public AjaxResult add(@RequestBody Device device)
    {
        return AjaxResult.success(deviceService.insertDevice(device));
    }

    /**
     * 设备关联用户
     */
    @PreAuthorize("@ss.hasPermi('iot:device:add')")
    @Log(title = "设备关联用户", businessType = BusinessType.UPDATE)
    @PostMapping("/relateUser")
    @ApiOperation("设备关联用户")
    public AjaxResult relateUser(@RequestBody DeviceRelateUserInput deviceRelateUserInput)
    {
        if(deviceRelateUserInput.getUserId()==0 || deviceRelateUserInput.getUserId()==null){
            return AjaxResult.error("用户ID不能为空");
        }
        if(deviceRelateUserInput.getDeviceNumberAndProductIds()==null || deviceRelateUserInput.getDeviceNumberAndProductIds().size()==0){
            return AjaxResult.error("设备编号和产品ID不能为空");
        }
        return deviceService.deviceRelateUser(deviceRelateUserInput);
    }

    /**
     * 修改设备
     */
    @PreAuthorize("@ss.hasPermi('iot:device:edit')")
    @Log(title = "修改设备", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改设备")
    public AjaxResult edit(@RequestBody Device device)
    {
        return deviceService.updateDevice(device);
    }

    /**
     * 重置设备状态
     */
    @PreAuthorize("@ss.hasPermi('iot:device:edit')")
    @Log(title = "重置设备状态", businessType = BusinessType.UPDATE)
    @PutMapping("/reset/{serialNumber}")
    @ApiOperation("重置设备状态")
    public AjaxResult resetDeviceStatus(@PathVariable String serialNumber)
    {
        Device device=new Device();
        device.setSerialNumber(serialNumber);
        return toAjax(deviceService.resetDeviceStatus(device.getSerialNumber()));
    }

    /**
     * 删除设备
     */
    @PreAuthorize("@ss.hasPermi('iot:device:remove')")
    @Log(title = "删除设备", businessType = BusinessType.DELETE)
	@DeleteMapping("/{deviceIds}")
    @ApiOperation("批量删除设备")
    public AjaxResult remove(@PathVariable Long[] deviceIds) throws SchedulerException {
        return toAjax(deviceService.deleteDeviceByDeviceId(deviceIds[0]));
    }

    /**
     * 生成设备编号
     */
    @PreAuthorize("@ss.hasPermi('iot:device:edit')")
    @GetMapping("/generator")
    @ApiOperation("生成设备编号")
    public AjaxResult generatorDeviceNum(){
        return AjaxResult.success("操作成功",deviceService.generationDeviceNum());
    }
}
