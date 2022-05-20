package com.ruoyi.iot.log.service;

import com.ruoyi.iot.domain.DeviceLog;

import com.ruoyi.iot.model.MonitorModel;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @package iot.iot.log
 * 类名: LogService
 * 描述: TODO
 * 时间: 2022/5/19,0019 18:04
 * 开发人: admin
 */
public interface ILogService {

    int saveDeviceLog(DeviceLog deviceLog);

    int deleteDeviceLogById(Long logId);

    int deleteDeviceLogByDeviceId(Long deviceId);

    List<DeviceLog> selectLogList(Long deviceId, String serialNumber, Long isMonitor, Long logType, Date beginDate, Date endDate);

    void save(String topic, String message);

    List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog);

    List<MonitorModel> selectMonitorList(DeviceLog deviceLog);
}
