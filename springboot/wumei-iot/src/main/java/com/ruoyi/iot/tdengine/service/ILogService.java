package com.ruoyi.iot.tdengine.service;

import com.ruoyi.iot.domain.Device;
import com.ruoyi.iot.domain.DeviceLog;

import com.ruoyi.iot.model.DeviceStatistic;
import com.ruoyi.iot.model.MonitorModel;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @package iot.iot.log
 * 类名: LogService
 * 描述: 设备日志记录接口
 * 时间: 2022/5/19,0019 18:04
 * 开发人: admin
 */
public interface ILogService {

    /** 保存设备日志 **/
    int saveDeviceLog(DeviceLog deviceLog);

    /** 根据设备编号删除设备日志 **/
    int deleteDeviceLogByDeviceNumber(String deviceNumber);

    /** 设备属性、功能、事件总数 **/
    DeviceStatistic selectCategoryLogCount(Device device);

    /** 查询物模型日志列表 **/
    List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog);

    /** 查询监测数据列表 **/
    List<MonitorModel> selectMonitorList(DeviceLog deviceLog);
}
