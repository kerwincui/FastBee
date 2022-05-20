package com.ruoyi.iot.log.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.ruoyi.iot.model.MonitorModel;
import com.ruoyi.iot.tdengine.config.TDengineConfig;
import com.ruoyi.iot.domain.DeviceLog;
import com.ruoyi.iot.log.service.ILogService;
import com.ruoyi.iot.mapper.DeviceLogMapper;
import com.ruoyi.iot.tdengine.mapper.TDDeviceLogMapper;
import com.ruoyi.iot.util.SnowflakeIdWorker;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 类名: DeviceLogServiceImpl
 * 描述: TODO
 * 时间: 2022/5/19,0019 18:09
 * 开发人: admin
 */
@Service
public class LogServiceImpl implements ILogService {

    @Autowired
    private ApplicationContext applicationContext;

    @Autowired
    private DeviceLogMapper deviceLogMapper;

    private TDDeviceLogMapper tdDeviceLogMapper;

    @Autowired
    private TDengineConfig dengineConfig;

    private SnowflakeIdWorker snowflakeIdWorker;

    private String dbName;

    @PostConstruct
    private void initDeviceLogMapper() {
        if (dengineConfig != null) {
            dbName = dengineConfig.getDbName();
            snowflakeIdWorker = new SnowflakeIdWorker(1);
            this.tdDeviceLogMapper = dengineConfig.getTDengineLogMapper();
        }
    }

    @Override
    public int saveDeviceLog(DeviceLog deviceLog) {
        if (tdDeviceLogMapper != null) {
            {
                String dbName = dengineConfig.getDbName();
                long logId = snowflakeIdWorker.nextId();
                deviceLog.setLogId(logId);
                return tdDeviceLogMapper.save(dbName, deviceLog);
            }
        } else if (deviceLogMapper != null) {
            deviceLog.setCreateTime(new Date());
            return deviceLogMapper.insertDeviceLog(deviceLog);
        } else {
            return -1;
        }
    }

    @Override
    public int deleteDeviceLogById(Long logId) {
        if (logId == null) return 0;
        if (tdDeviceLogMapper != null) {
            {
                String dbName = dengineConfig.getDbName();
                DeviceLog deviceLog = new DeviceLog();
                deviceLog.setLogId(logId);
                return tdDeviceLogMapper.delete(dbName, deviceLog);
            }
        } else if (deviceLogMapper != null) {
            return deviceLogMapper.deleteDeviceLogByLogId(logId);
        } else {
            return -1;
        }
    }

    @Override
    public int deleteDeviceLogByDeviceId(Long deviceId) {
        if (deviceId == null) return 0;
        if (tdDeviceLogMapper != null) {
            {
                String dbName = dengineConfig.getDbName();
                DeviceLog deviceLog = new DeviceLog();
                deviceLog.setDeviceId(deviceId);
                return tdDeviceLogMapper.delete(dbName, deviceLog);
            }
        } else if (deviceLogMapper != null) {
            Long[] ids = new Long[1];
            ids[0] = deviceId;
            return deviceLogMapper.deleteDeviceLogByDeviceIds(ids);
        } else {
            return -1;
        }
    }

    @Override
    public List<DeviceLog> selectLogList(Long deviceId, String serialNumber, Long isMonitor, Long logType, Date beginDate, Date endDate) {
        return null;
    }

//    @Override
//    public List<DeviceLog> selectLogList(Long deviceId, String serialNumber, Long isMonitor, Long logType, Date beginDate, Date endDate) {
//        List<DeviceLog> list = new ArrayList<>();
//        if (tdDeviceLogMapper != null) {
//            {
//                String dbName = dengineConfig.getDbName();
//                list = tdDeviceLogMapper.selectLogList(dbName, deviceId, serialNumber, isMonitor, logType, beginDate, endDate);
//
//                return list;
//            }
//        } else if (deviceLogMapper != null) {
//            list = deviceLogMapper.selectLogList(deviceId, serialNumber, isMonitor, logType, beginDate, endDate);
//        }
//        return list;
//    }

    @Override
    @Async
    public void save(String topic, String message) {
        System.out.println("topic:" + topic);
        System.out.println("message:" + message);
        String[] topicItem = topic.split("/");
        String subTopic = topicItem[0];
        String deviceNum = topicItem[1];
        JSONObject jsonObject = JSONObject.parseObject(message);
        for (String key : jsonObject.keySet()) {
            DeviceLog deviceLog = new DeviceLog();
            deviceLog.setLogId(new Date().getTime());
            deviceLog.setSerialNumber(deviceNum);
            deviceLog.setDeviceName(subTopic);
            deviceLog.setDeviceId(Long.parseLong(deviceNum));
            deviceLog.setDeviceName("灌溉机:" + deviceNum);
            deviceLog.setTs(new Date());
            deviceLog.setIsMonitor(1);
            deviceLog.setLogType(1);
            deviceLog.setIdentity(key);
            deviceLog.setLogValue(jsonObject.getString(key));
            deviceLog.setRemark(message);
            tdDeviceLogMapper.save(dbName, deviceLog);
        }


    }

    @Override
    public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog) {
        List<DeviceLog> list = new ArrayList<>();
        if (tdDeviceLogMapper != null) {
            {
                String dbName = dengineConfig.getDbName();
                list = tdDeviceLogMapper.selectDeviceLogList(dbName, deviceLog);

                return list;
            }
        } else if (deviceLogMapper != null) {
            list = deviceLogMapper.selectDeviceLogList(deviceLog);
        }
        return list;
    }

    @Override
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog) {
        List<MonitorModel> list = new ArrayList<>();
        if (tdDeviceLogMapper != null) {
            {
                String dbName = dengineConfig.getDbName();
                list = tdDeviceLogMapper.selectMonitorList(dbName, deviceLog);

                return list;
            }
        } else if (deviceLogMapper != null) {
            list = deviceLogMapper.selectMonitorList(deviceLog);
        }
        return list;
    }

//    @Override
//    public List<DeviceLog> selectLogListPage(Integer pageSize, Integer pageNum,Long deviceId,String serialNumber,Long isMonitor,Long logType, Date beginDate, Date endDate) {
//        if (tdDeviceLogMapper != null) {
//            {
//                String dbName = dengineConfig.getDbName();
//                List<DeviceLog> list=  tdDeviceLogMapper.selectLogListByPage(dbName,pageSize,pageNum,deviceNum,beginDate,endDate);
//
//                return
//            }
//        } else if (deviceLogMapper != null) {
//            return deviceLogMapper.deleteDeviceLogByLogId(logId);
//        } else {
//            return -1;
//        }
//    }
}
