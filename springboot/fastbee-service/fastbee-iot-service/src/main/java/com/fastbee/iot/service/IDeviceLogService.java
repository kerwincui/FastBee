package com.fastbee.iot.service;

import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.model.DataCenterParam;
import com.fastbee.iot.model.HistoryModel;
import com.fastbee.iot.model.MonitorModel;
import com.fastbee.iot.model.ThingsModelLogCountVO;

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

    /**
     * 查询设备日志列表
     *
     * @param deviceLog 设备日志
     * @return 设备日志集合
     */
    public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog);

    /**
     * 新增设备日志
     *
     * @param deviceLog 设备日志
     * @return 结果
     */
    public int insertDeviceLog(DeviceLog deviceLog);

    /**
     * 查询物模型历史数据
     * @param deviceLog 设备日志
     * @return java.util.List<com.fastbee.iot.model.HistoryModel>
     */
    List<HistoryModel> listHistory(DeviceLog deviceLog);

    /**
     * 统计设备物模型指令下发数量
     * @param dataCenterParam 传参
     * @return com.fastbee.common.core.domain.AjaxResult
     */
    List<ThingsModelLogCountVO> countThingsModelInvoke(DataCenterParam dataCenterParam);

}
