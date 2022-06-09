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


    int  createDB( String database);

    int  createSTable(String database);

    int  createTable(String database,String deviceId);

    int  save(@Param("database") String database,@Param("device") DeviceLog deviceLog);

    DeviceStatistic selectCategoryLogCount(@Param("database") String database, Device device);

    List<DeviceLog>  selectSTable(String database,DeviceLog deviceLog);

    int delete(String dbName, DeviceLog deviceLog);

    int deleteDeviceLogByDeviceId(String dbName,Long deviceId);

    // List<DeviceLog> selectLogListByPage(String dbName, Integer pageSize, Integer pageNum, String deviceNum, Date beginDate, Date endDate);

    List<DeviceLog> selectLogList(String dbName, Long deviceId, String serialNumber, Long isMonitor, Long logType, Date beginDate, Date endDate);

    List<MonitorModel> selectMonitorList(@Param("database")  String database, @Param("device") DeviceLog deviceLog);

    List<DeviceLog> selectDeviceLogList(@Param("database")  String database,@Param("device") DeviceLog deviceLog);
}
