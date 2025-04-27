package com.fastbee.data.controller;

import com.fastbee.common.core.controller.BaseController;
import com.fastbee.common.core.page.TableDataInfo;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.model.MonitorModel;
import com.fastbee.iot.service.IDeviceLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 设备日志Controller
 *
 * @author kerwincui
 * @date 2022-01-13
 */
@Api(tags = "设备日志模块")
@RestController
@RequestMapping("/iot/deviceLog")
public class DeviceLogController extends BaseController
{
    @Autowired
    private IDeviceLogService deviceLogService;

    /**
     * 查询设备的监测数据
     */
    @ApiOperation("查询设备的监测数据")
    @PreAuthorize("@ss.hasPermi('iot:device:list')")
    @GetMapping("/monitor")
    public TableDataInfo monitorList(DeviceLog deviceLog)
    {
        List<MonitorModel> list = deviceLogService.selectMonitorList(deviceLog);
        return getDataTable(list);
    }

    /**
     * 查询设备日志列表
     */
    @ApiOperation("查询设备日志列表")
    @PreAuthorize("@ss.hasPermi('iot:device:list')")
    @GetMapping("/list")
    public TableDataInfo list(DeviceLog deviceLog)
    {
        startPage();
        List<DeviceLog> list = deviceLogService.selectDeviceLogList(deviceLog);
        return getDataTable(list);
    }

}
