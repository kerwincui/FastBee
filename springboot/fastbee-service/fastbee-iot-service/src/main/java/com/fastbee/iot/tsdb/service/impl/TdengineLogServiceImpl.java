package com.fastbee.iot.tsdb.service.impl;

import com.baomidou.dynamic.datasource.annotation.DS;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.model.*;
import com.fastbee.iot.tsdb.service.ILogService;
import com.fastbee.iot.mapper.TDDeviceLogMapper;
import com.fastbee.iot.tsdb.model.TdLogDto;
import com.fastbee.iot.util.SnowflakeIdWorker;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 类名: TdengineLogServiceImpl
 * 描述: TDengine存储日志数据实现类
 * 时间: 2022/5/22,0022 13:38
 * 开发人: admin
 */
@Slf4j
@Primary
@ConditionalOnProperty(name = "spring.datasource.dynamic.datasource.taos.enabled", havingValue = "true")
@DS("taos")
@Service("Tdengine")
public class TdengineLogServiceImpl implements ILogService {

    @Autowired
    private TDDeviceLogMapper tDDeviceLogMapper;


    private SnowflakeIdWorker snowflakeIdWorker = new SnowflakeIdWorker(1);

    @Value("${spring.datasource.dynamic.datasource.taos.dbName}")
    private String dbName;


    @Override
    public int createSTable(String database) {
        return tDDeviceLogMapper.createSTable(database);
    }

    /***
     * 新增设备日志
     * @return
     */
    @Override
    public int saveDeviceLog(DeviceLog deviceLog) {
        long logId = snowflakeIdWorker.nextId();
        deviceLog.setLogId(logId);
        return tDDeviceLogMapper.save(dbName, deviceLog);
    }

    /**
     * 批量保存日志
     */
    @Override
    public int saveBatch(TdLogDto dto) {
        return tDDeviceLogMapper.saveBatch(dbName, dto);
    }

    /***
     * 设备属性、功能、事件和监测数据总数
     * @return
     */
    @Override
    public DeviceStatistic selectCategoryLogCount(Device device) {
        DeviceStatistic statistic = new DeviceStatistic();
        Long property = tDDeviceLogMapper.selectPropertyLogCount(dbName, device);
        Long event = tDDeviceLogMapper.selectEventLogCount(dbName, device);
        Long monitor = tDDeviceLogMapper.selectMonitorLogCount(dbName, device);
        statistic.setPropertyCount(property == null ? 0 : property);
        statistic.setEventCount(event == null ? 0 : event);
        statistic.setMonitorCount(monitor == null ? 0 : monitor);
        return statistic;
    }

    /***
     * 日志列表
     * @return
     */
    @Override
    public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog) {
        return tDDeviceLogMapper.selectDeviceLogList(dbName, deviceLog);
    }

//    @Override
//    public Page<DeviceLog> selectEventLogList(DeviceLog deviceLog) {
//        if (deviceLog.getParams().get("beginTime") != null && deviceLog.getParams().get("beginTime") != "" && deviceLog.getParams().get("endTime") != null && deviceLog.getParams().get("endTime") != "") {
//            String beginTime = deviceLog.getParams().get("beginTime").toString();
//            String endTime = deviceLog.getParams().get("endTime").toString();
//            beginTime = beginTime + " 00:00:00";
//            endTime = endTime + " 23:59:59";
//            deviceLog.setBeginTime(beginTime);
//            deviceLog.setEndTime(endTime);
//        }
//        return tDDeviceLogMapper.selectEventLogList(new Page<>(deviceLog.getPageNum(), deviceLog.getPageSize()), dbName, deviceLog);
//    }

    /***
     * 监测数据列表
     * @return
     */
    @Override
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog) {
        if (deviceLog.getIdentify() != null) {
            deviceLog.setIdentify("%" + deviceLog.getIdentify() + "%");
        }
        return tDDeviceLogMapper.selectMonitorList(dbName, deviceLog);
    }

    /***
     * 根据设备ID删除设备日志
     * @return
     */
    @Override
    public int deleteDeviceLogByDeviceNumber(String deviceNumber) {
        return tDDeviceLogMapper.deleteDeviceLogByDeviceNumber(dbName, deviceNumber);
    }

    @Override
    public List<HistoryModel> listHistory(DeviceLog deviceLog) {
        List<HistoryModel> historyModelList = tDDeviceLogMapper.listHistory(dbName, deviceLog);
        for (HistoryModel historyModel : historyModelList) {
            historyModel.setTime(DateUtils.dateRemoveMs(historyModel.getTime()));
        }
        return historyModelList;
    }

    @Override
    public List<ThingsModelLogCountVO> countThingsModelInvoke(DataCenterParam dataCenterParam) {
        return tDDeviceLogMapper.countThingsModelInvoke(dbName, dataCenterParam);
    }

}
