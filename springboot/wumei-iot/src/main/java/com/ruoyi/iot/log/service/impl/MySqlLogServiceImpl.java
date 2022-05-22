package com.ruoyi.iot.log.service.impl;

import com.ruoyi.iot.domain.DeviceLog;
import com.ruoyi.iot.log.service.ILogService;
import com.ruoyi.iot.mapper.DeviceLogMapper;
import com.ruoyi.iot.model.MonitorModel;
import org.springframework.stereotype.Service;

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

    @Override
    public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog) {
        return deviceLogMapper.selectDeviceLogList(deviceLog);
    }

    @Override
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog) {
        return deviceLogMapper.selectMonitorList(deviceLog);
    }
}
