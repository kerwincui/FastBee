package com.fastbee.iot.service;

import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.model.HistoryModel;
import com.fastbee.iot.model.MonitorModel;

import java.util.List;
import java.util.Map;

/**
 * 设备日志Service接口
 *
 * @author kerwincui
 * @date 2022-01-13
 */
public interface IDeviceLogService
{

    /**
     * 查询设备监测数据
     *
     * @param deviceLog 设备日志
     * @return 设备日志集合
     */
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog);

}
