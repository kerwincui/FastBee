package com.ruoyi.iot.tdengine.service;

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

    int saveDeviceLog(DeviceLog deviceLog);

    /** 设备属性、功能、事件总数 **/
    DeviceStatistic selectCategoryLogCount();

    /** 查询物模型日志列表 **/
    List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog);

    /** 查询监测数据列表 **/
    List<MonitorModel> selectMonitorList(DeviceLog deviceLog);
}
