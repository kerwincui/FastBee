package com.ruoyi.iot.tdengine.service.impl;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.iot.domain.Device;
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

    /***
     * 新增设备日志
     * @return
     */
    @Override
    public int saveDeviceLog(DeviceLog deviceLog) {
        return deviceLogMapper.insertDeviceLog(deviceLog);
    }

    /***
     * 根据设备ID删除设备日志
     * @return
     */
    @Override
    public int deleteDeviceLogByDeviceNumber(String deviceNumber) {
        return deviceLogMapper.deleteDeviceLogByDeviceNumber(deviceNumber);
    }

    /***
     * 设备属性、功能、事件和监测数据总数
     * @return
     */
    @Override
    public DeviceStatistic selectCategoryLogCount(Device device){
        return deviceLogMapper.selectCategoryLogCount(device);
    }

    /***
     * 日志列表
     * @return
     */
    @Override
    public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog) {
        return deviceLogMapper.selectDeviceLogList(deviceLog);
    }

    /***
     * 监测数据列表
     * @return
     */
    @Override
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog) {
        return deviceLogMapper.selectMonitorList(deviceLog);
    }
}
