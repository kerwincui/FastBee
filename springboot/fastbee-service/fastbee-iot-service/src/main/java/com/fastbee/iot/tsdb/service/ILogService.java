package com.fastbee.iot.tsdb.service;

import com.fastbee.iot.domain.Device;
import com.fastbee.iot.domain.DeviceLog;

import com.fastbee.iot.model.DeviceStatistic;
import com.fastbee.iot.model.MonitorModel;
import com.fastbee.iot.tsdb.model.TdLogDto;

import java.util.List;

/**
 * @package iot.iot.log
 * 类名: LogService
 * 描述: 设备日志记录接口
 * 时间: 2022/5/19,0019 18:04
 * 开发人: admin
 */
public interface ILogService {

    int  createSTable(String database);

    /** 保存设备日志 **/
    int saveDeviceLog(DeviceLog deviceLog);

    /**
     * 批量保存日志
     */
    int saveBatch(TdLogDto dto);

    /** 根据设备编号删除设备日志 **/
    int deleteDeviceLogByDeviceNumber(String deviceNumber);

    /** 设备属性、功能、事件总数 **/
    DeviceStatistic selectCategoryLogCount(Device device);

    /** 查询监测数据列表 **/
    List<MonitorModel> selectMonitorList(DeviceLog deviceLog);

    /** 查询物模型日志列表 **/
    List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog);


}
