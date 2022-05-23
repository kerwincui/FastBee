package com.ruoyi.iot.tdengine.service.impl;

import com.ruoyi.iot.domain.DeviceLog;
import com.ruoyi.iot.tdengine.service.ILogService;
import com.ruoyi.iot.model.MonitorModel;
import com.ruoyi.iot.tdengine.config.TDengineConfig;
import com.ruoyi.iot.tdengine.dao.TDDeviceLogMapper;
import com.ruoyi.iot.util.SnowflakeIdWorker;
import org.springframework.context.ApplicationContext;

import java.util.List;

/**
 * 类名: TdengineLogServiceImpl
 * 描述: TDengine存储日志数据实现类
 * 时间: 2022/5/22,0022 13:38
 * 开发人: admin
 */
public class TdengineLogServiceImpl implements ILogService {

    private ApplicationContext applicationContext;

    private TDDeviceLogMapper tdDeviceLogMapper;

    private TDengineConfig tDengineConfig;

    private SnowflakeIdWorker snowflakeIdWorker;

    private String dbName;

    public TdengineLogServiceImpl(TDengineConfig _tDengineConfig,TDDeviceLogMapper _tdDeviceLogMapper) {
        this.tdDeviceLogMapper = _tdDeviceLogMapper;
        this.tDengineConfig = _tDengineConfig;
        snowflakeIdWorker=new SnowflakeIdWorker(1);
        this.dbName=_tDengineConfig.getDbName();
    }

    @Override
    public int saveDeviceLog(DeviceLog deviceLog) {
        long logId = snowflakeIdWorker.nextId();
        deviceLog.setLogId(logId);
        return tdDeviceLogMapper.save(dbName,deviceLog);
    }

    @Override
    public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog) {
        return tdDeviceLogMapper.selectDeviceLogList(dbName,deviceLog);
    }

    @Override
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog) {
        return tdDeviceLogMapper.selectMonitorList(dbName,deviceLog);
    }
}
