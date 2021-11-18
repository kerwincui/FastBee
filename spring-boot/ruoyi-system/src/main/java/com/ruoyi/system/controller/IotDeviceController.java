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

import java.math.BigDecimal;
import java.util.List;

import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.exception.CustomException;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.vo.DeviceControlCMD;
import com.ruoyi.system.domain.vo.IotDeviceListDto;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.token.TokenService;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.IotDevice;
import com.ruoyi.system.service.IIotDeviceService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

import javax.validation.constraints.Size;

/**
 * 设备Controller
 *
 * @author kerwincui
 * @date 2021-05-06
 */
@Api(value = "设备", tags = "设备")
@RestController
@RequestMapping("/system/device")
public class IotDeviceController extends BaseController {
    @Autowired
    private IIotDeviceService iotDeviceService;

    /**
     * 查询设备列表
     */
    @ApiOperation(value = "设备列表", notes = "设备列表")
    @PreAuthorize("@ss.hasPermi('system:device:list')")
    @GetMapping("/list")
    public TableDataInfo list(IotDevice iotDevice) {
        startPage();
        LoginUser user = (LoginUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        iotDevice.setOwnerId(user.getUser().getUserId().toString());
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
    public AjaxResult export(IotDevice iotDevice) {
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
    public AjaxResult getInfo(@PathVariable("deviceId") Long deviceId) {
        return AjaxResult.success(iotDeviceService.selectIotDeviceById(deviceId));
    }

    /**
     * 根据设备编号获取设备详细信息
     */
    @ApiOperation(value = "根据设备编号获取设备详情", notes = "根据设备编号获取设备详情")
    @PreAuthorize("@ss.hasPermi('system:device:query')")
    @GetMapping(value = "/getByNum/{deviceNum}")
    public AjaxResult getInfoByNum(@PathVariable("deviceNum") String deviceNum) {
        return AjaxResult.success(iotDeviceService.selectIotDeviceByNum(deviceNum));
    }

    /**
     * 新增设备
     */
    @ApiOperation(value = "新增设备", notes = "新增设备")
    @PreAuthorize("@ss.hasPermi('system:device:add')")
    @Log(title = "设备", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody IotDevice iotDevice) {
        LoginUser user = (LoginUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        iotDevice.setOwnerId(user.getUser().getUserId().toString());
        iotDevice.setStatus("未绑定");
        IotDevice device = iotDeviceService.selectIotDeviceByNum(iotDevice.getDeviceNum());
        if (device != null) {
            return AjaxResult.error("设备编号已存在，请重新填写");
        }
        return toAjax(iotDeviceService.insertIotDevice(iotDevice));
    }

    /**
     * 修改设备
     */
    @ApiOperation(value = "修改设备", notes = "修改设备")
    @PreAuthorize("@ss.hasPermi('system:device:edit')")
    @Log(title = "设备", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody IotDevice iotDevice) {
        return toAjax(iotDeviceService.updateIotDevice(iotDevice));
    }

    /**
     * 删除设备
     */
    @ApiOperation(value = "删除设备", notes = "删除设备")
    @PreAuthorize("@ss.hasPermi('system:device:remove')")
    @Log(title = "设备", businessType = BusinessType.DELETE)
    @DeleteMapping("/{deviceIds}")
    public AjaxResult remove(@PathVariable Long[] deviceIds) {
        return toAjax(iotDeviceService.deleteIotDeviceByIds(deviceIds));
    }


    @ApiOperation(value = "绑定设备", notes = "绑定设备")
    @Log(title = "设备", businessType = BusinessType.UPDATE)
    @PostMapping("/bindDevice")
    public AjaxResult bindDevice(@RequestBody IotDevice iotDevice) {
        LoginUser user = (LoginUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId = user.getUser().getUserId();
        String username = user.getUsername();
        String deviceNum = iotDevice.getDeviceNum();
        String deviceName = iotDevice.getDeviceName();
        Long categoryId = iotDevice.getCategoryId();
        String remark = iotDevice.getRemark();
        return AjaxResult.success(iotDeviceService.bindDevice(userId,username,deviceNum,deviceName,categoryId, remark));
    }

    @ApiOperation(value = "控制设备", notes = "控制设备")
    @PreAuthorize("@ss.hasPermi('system:device:control')")
    @Log(title = "设备", businessType = BusinessType.UPDATE)
    @PostMapping("/control")
    public AjaxResult control(@RequestBody DeviceControlCMD deviceControlCMD) {
        String deviceNum = deviceControlCMD.getDeviceNum();
        String cmd = deviceControlCMD.getCmd();
        if(StringUtils.isBlank(deviceNum)) {
            throw new CustomException("设备编号不能为空");
        }
        if(StringUtils.isBlank(cmd)) {
            throw new CustomException("控制指令不能为空");
        }
        return toAjax(iotDeviceService.controlDeviceByNum(deviceNum,cmd));
    }



    @ApiOperation(value = "小程序设备列表", notes = "小程序设备列表")
    @PreAuthorize("@ss.hasPermi('system:device:list')")
    @GetMapping("/listDevice")
    public TableDataInfo listDevice(IotDevice iotDevice) {
        startPage();
        LoginUser user = (LoginUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        iotDevice.setOwnerId(user.getUser().getUserId().toString());
        List<IotDeviceListDto> list = iotDeviceService.selectMpIotDeviceList(iotDevice);
        return getDataTable(list);
    }

    @ApiOperation(value = "修改设备名称和备注", notes = "修改设备名称和备注")
    @Log(title = "设备", businessType = BusinessType.UPDATE)
    @PostMapping("/updateDeviceInfo")
    public AjaxResult updateDeviceInfo(@RequestBody IotDevice iotDevice) {
        Long deviceId = iotDevice.getDeviceId();
        String deviceName = iotDevice.getDeviceName();
        String remark = iotDevice.getRemark();
        LoginUser user = (LoginUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId = user.getUser().getUserId();
         String nickName = user.getUser().getNickName();
        return AjaxResult.success(iotDeviceService.updateDeviceInfo( userId,  nickName,  deviceId,  deviceName,  remark));
    }

    @ApiOperation(value = "根据用户设备编号获取设备详情", notes = "根据设备编号获取设备详情")
    @GetMapping(value = "/getByUserAndNum/{deviceNum}")
    public AjaxResult getInfoByUserAndNum(@PathVariable("deviceNum") String deviceNum) {
        LoginUser user = (LoginUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId = user.getUser().getUserId();
        return AjaxResult.success(iotDeviceService.selectIotDeviceByUserAndNum(userId,deviceNum));
    }

    @ApiOperation(value = "解除绑定设备", notes = "解除绑定设备")
    @Log(title = "设备", businessType = BusinessType.UPDATE)
    @PostMapping("/unBindDevice")
    public AjaxResult unBindDevice(@RequestBody IotDevice iotDevice) {
        LoginUser user = (LoginUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId = user.getUser().getUserId();
        String username = user.getUsername();
        Long deviceId = iotDevice.getDeviceId();
        return AjaxResult.success(iotDeviceService.unBindDevice(userId,username,deviceId));
    }

    @ApiOperation(value = "根据设备编号查询设备信息", notes = "根据设备编号查询设备信息")
    @Log(title = "设备", businessType = BusinessType.UPDATE)
    @GetMapping("/getDeviceInfoByDeviceNum")
    public AjaxResult getDeviceInfoByDeviceNum(@RequestParam String deviceNum ) {
        LoginUser user = (LoginUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId = user.getUser().getUserId();
        String username = user.getUsername();
        return AjaxResult.success(iotDeviceService.getDeviceInfoByDeviceNum(userId,username,deviceNum));
    }

    @ApiOperation(value = "根据设备编号查询设备信息", notes = "根据设备编号查询设备信息")
    @Log(title = "设备", businessType = BusinessType.UPDATE)
    @GetMapping("/getDeviceInfoByDeviceId")
    public AjaxResult getDeviceInfoByDeviceId(@RequestParam Long deviceId ) {
        LoginUser user = (LoginUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Long userId = user.getUser().getUserId();
        String username = user.getUsername();
        return AjaxResult.success(iotDeviceService.getDeviceInfoByDeviceId(userId,username,deviceId));
    }

}
