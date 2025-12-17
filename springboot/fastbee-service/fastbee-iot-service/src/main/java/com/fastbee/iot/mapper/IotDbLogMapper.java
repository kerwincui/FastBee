package com.fastbee.iot.mapper;

import com.fastbee.iot.domain.Device;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.model.MonitorModel;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IotDbLogMapper {

    void createDB(String database);
    Long countDB(String database);

    int save(DeviceLog deviceLog);

    int deleteDeviceLogByDeviceNumber(@Param("serialNumber") String deviceNumber);

    Long selectPropertyLogCount(@Param("device") Device device);

    Long selectEventLogCount(@Param("device") Device device);

    Long selectMonitorLogCount(@Param("device") Device device);

    /***
     * 监测数据列表
     */
    List<MonitorModel> selectMonitorList(@Param("device") DeviceLog deviceLog);

    /***
     * 日志列表
     */
    List<DeviceLog> selectDeviceLogList(@Param("device") DeviceLog deviceLog);
    List<DeviceLog> selectEventLogList(@Param("device") DeviceLog deviceLog);

}
