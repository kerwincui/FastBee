package com.fastbee.iot.service;

import com.fastbee.common.enums.ThingsModelType;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.domain.FunctionLog;

import java.util.List;

/**
 * 设备运行时数据
 *
 * @author gsb
 * @date 2023/2/1 15:08
 */
public interface IDeviceRuntimeService {

    /**
     * 根据设备编号查询设备实时运行状态
     *
     * @param serialNumber 设备编号
     * @param type         物模型类型
     * @return 设备实时数据
     */
    public List<DeviceLog> runtimeBySerialNumber(String serialNumber, ThingsModelType type,Long productId,Integer slaveId);

    /**
     * 根据设备编号查询设备服务调用日志情况
     * @param serialNumber 设备编号
     * @return 服务下发日志
     */
    public List<FunctionLog> runtimeReply(String serialNumber);

}
