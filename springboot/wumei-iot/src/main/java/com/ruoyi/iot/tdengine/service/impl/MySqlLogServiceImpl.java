package com.ruoyi.iot.tdengine.service.impl;

import com.ruoyi.iot.domain.DeviceLog;
import com.ruoyi.iot.model.DeviceStatistic;
import com.ruoyi.iot.tdengine.service.ILogService;
import com.ruoyi.iot.mapper.DeviceLogMapper;
import com.ruoyi.iot.model.MonitorModel;

import java.util.List;

/**
 * 类名: MySqlLogServiceImpl
 * 描述: MySQL存储日志实现类
 * 时间: 2022/5/22,0022 13:37
 * 开发人: admin
 */
public class MySqlLogServiceImpl implements ILogService {

    private DeviceLogMapper deviceLogMapper;

    public MySqlLogServiceImpl(DeviceLogMapper _deviceLogMapper){
        this.deviceLogMapper=_deviceLogMapper;
    }

    @Override
    public int saveDeviceLog(DeviceLog deviceLog) {
        return deviceLogMapper.insertDeviceLog(deviceLog);
    }

    /** 设备属性、功能、事件和监测数据总数 **/
    @Override
    public DeviceStatistic selectCategoryLogCount(){
        return deviceLogMapper.selectCategoryLogCount();
    }

    @Override
    public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog) {
        return deviceLogMapper.selectDeviceLogList(deviceLog);
    }

    @Override
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog) {
        return deviceLogMapper.selectMonitorList(deviceLog);
    }
}
