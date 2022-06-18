package com.ruoyi.iot.tdengine.dao;

import com.ruoyi.iot.domain.Device;
import com.ruoyi.iot.domain.DeviceLog;
import com.ruoyi.iot.model.DeviceStatistic;
import com.ruoyi.iot.model.MonitorModel;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * @package com.ruoyi.mysql.mysql.tdengine
 * 类名: DatabaseMapper
 * 时间: 2022/5/16,0016 1:27
 * 开发人: wxy
 */
@Repository
public interface TDDeviceLogDAO {

    /***
     * 创建数据库
     */
    int  createDB( String database);

    /***
     * 创建超级表
     */
    int  createSTable(String database);


    /***
     * 新增设备日志
     */
    int  save(@Param("database") String database,@Param("device") DeviceLog deviceLog);

    /***
     * 设备属性数据总数
     */
    Long selectPropertyLogCount(@Param("database") String database,@Param("device")  Device device);

    /***
     * 设备功能数据总数
     */
    Long selectFunctionLogCount(@Param("database") String database,@Param("device")  Device device);

    /***
     * 设备事件数据总数
     */
    Long selectEventLogCount(@Param("database") String database,@Param("device")  Device device);

    /***
     * 设备监测数据总数
     */
    Long selectMonitorLogCount(@Param("database") String database,@Param("device")  Device device);

    /***
     * 监测数据列表
     */
    List<MonitorModel> selectMonitorList(@Param("database")  String database, @Param("device") DeviceLog deviceLog);

    /***
     * 日志列表
     */
    List<DeviceLog> selectDeviceLogList(@Param("database")  String database,@Param("device") DeviceLog deviceLog);

    /***
     * 根据设备ID删除设备日志
     */
    int deleteDeviceLogByDeviceNumber(@Param("database")String dbName,@Param("serialNumber") String serialNumber);

}
