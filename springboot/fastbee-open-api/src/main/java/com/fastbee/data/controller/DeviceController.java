package com.fastbee.data.controller;

import com.fastbee.common.annotation.Log;
import com.fastbee.common.constant.HttpStatus;
import com.fastbee.common.core.controller.BaseController;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.page.TableDataInfo;
import com.fastbee.common.enums.BusinessType;
import com.fastbee.common.utils.MessageUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.common.utils.poi.ExcelUtil;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.model.DeviceRelateUserInput;
import com.fastbee.iot.model.ThingsModelItem.ThingsModel;
import com.fastbee.iot.model.dto.ThingsModelDTO;
import com.fastbee.iot.service.IDeviceService;
import com.fastbee.mq.service.IMqttMessagePublish;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.collections4.CollectionUtils;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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

    // @Lazy
    @Autowired
    private IMqttMessagePublish messagePublish;

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
        return AjaxResult.success(messagePublish.deviceSynchronization(serialNumber));
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
    @GetMapping(value = "/runningStatus")
    @ApiOperation("获取设备详情和运行状态")
    public AjaxResult getRunningStatusInfo(Long deviceId, Integer slaveId)
    {
        return AjaxResult.success(deviceService.selectDeviceRunningStatusByDeviceId(deviceId,slaveId));
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
            return AjaxResult.error(MessageUtils.message("device.user.id.null"));
        }
        if(deviceRelateUserInput.getDeviceNumberAndProductIds()==null || deviceRelateUserInput.getDeviceNumberAndProductIds().size()==0){
            return AjaxResult.error(MessageUtils.message("device.product.id.null"));
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
    public AjaxResult generatorDeviceNum(Integer type){
        return AjaxResult.success("操作成功",deviceService.generationDeviceNum(type));
    }

    @PreAuthorize("@ss.hasPermi('iot:device:query')")
    @GetMapping("/gwDevCount")
    @ApiOperation("子设备数量")
    public AjaxResult getGwDevCount(String gwDevCode){
        return AjaxResult.success(deviceService.getSubDeviceCount(gwDevCode));
    }

    /**
     * 获取设备MQTT连接参数
     * @param deviceId 设备主键id
     * @return
     */
    @PreAuthorize("@ss.hasPermi('iot:device:query')")
    @GetMapping("/getMqttConnectData")
    @ApiOperation("获取设备MQTT连接参数")
    public AjaxResult getMqttConnectData(Long deviceId){
        return AjaxResult.success(deviceService.getMqttConnectData(deviceId));
    }

    /**
     * 查询变量概况
     */
    @PreAuthorize("@ss.hasPermi('iot:device:query')")
    @GetMapping("/listThingsModel")
    @ApiOperation("查询变量概况")
    public TableDataInfo listThingsModel(Integer pageNum, Integer pageSize, Long deviceId, String modelName, Integer type, Integer isMonitor, Integer isReadonly) {
        Device device = deviceService.selectDeviceByDeviceId(deviceId);
        if (Objects.isNull(device)) {
            return new TableDataInfo();
        }
        TableDataInfo rspData = new TableDataInfo();
        rspData.setCode(HttpStatus.SUCCESS);
        rspData.setMsg("查询成功");
        List<ThingsModel> thingsModelDTOList = deviceService.listThingsModel(deviceId);
        if (CollectionUtils.isEmpty(thingsModelDTOList)) {
            rspData.setRows(thingsModelDTOList);
            rspData.setTotal(thingsModelDTOList.size());
            return rspData;
        }
        List<Predicate<ThingsModel>> predicateList = new ArrayList<>();
        if (StringUtils.isNotEmpty(modelName)) {
            predicateList.add(o -> o.getName().contains(modelName));
        }
        if (null != type) {
            predicateList.add(o -> Objects.equals(o.getType(), type));
        }
        if (null != isMonitor) {
            predicateList.add(o -> Objects.equals(isMonitor, o.getIsMonitor()));
        }
        if (null != isReadonly) {
            predicateList.add(o -> Objects.equals(isReadonly, o.getIsReadonly()));
            predicateList.add(o -> !Objects.equals(3, o.getType()));
        }
        Stream<ThingsModel> stream = thingsModelDTOList.stream();
        for (Predicate<ThingsModel> predicate : predicateList) {
            stream = stream.filter(predicate);
        }
        List<ThingsModel> filterList = stream.collect(Collectors.toList());
        filterList.sort(Comparator.comparing(ThingsModel::getOrder).reversed().thenComparing(ThingsModel::getId));
        if (CollectionUtils.isNotEmpty(filterList)) {
            List resultList = com.fastbee.common.utils.collection.CollectionUtils.startPage(filterList, pageNum, pageSize);
            rspData.setRows(resultList);
        } else {
            rspData.setRows(new ArrayList<>());
        }
        rspData.setTotal(filterList.size());
        return rspData;
    }

}
