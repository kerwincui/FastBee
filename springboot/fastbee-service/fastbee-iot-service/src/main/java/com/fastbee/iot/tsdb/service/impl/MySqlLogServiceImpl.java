package com.fastbee.iot.tsdb.service.impl;

import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.domain.EventLog;
import com.fastbee.iot.mapper.EventLogMapper;
import com.fastbee.iot.model.DeviceStatistic;
import com.fastbee.iot.tsdb.model.TdLogDto;
import com.fastbee.iot.tsdb.service.ILogService;
import com.fastbee.iot.mapper.DeviceLogMapper;
import com.fastbee.iot.model.MonitorModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MySqlLogServiceImpl implements ILogService {

    private DeviceLogMapper deviceLogMapper;
    @Resource
    private EventLogMapper eventLogMapper;

    public MySqlLogServiceImpl(DeviceLogMapper _deviceLogMapper){
        this.deviceLogMapper=_deviceLogMapper;
    }

    @Override
    public int createSTable(String database) {
        return 0;
    }

    /***
     * 新增设备日志
     * @return
     */
    @Override
    public int saveDeviceLog(DeviceLog deviceLog) {
        if (deviceLog.getLogType() == 3 || deviceLog.getLogType() == 5 || deviceLog.getLogType() == 6 || deviceLog.getLogType() == 8) {
            EventLog event = new EventLog();
            event.setDeviceId(deviceLog.getDeviceId());
            event.setDeviceName(deviceLog.getDeviceName());
            event.setSerialNumber(deviceLog.getSerialNumber());
            event.setIsMonitor(0);
            event.setUserId(deviceLog.getTenantId());
            event.setUserName(deviceLog.getTenantName());
            event.setTenantId(deviceLog.getTenantId());
            event.setTenantName(deviceLog.getTenantName());
            event.setCreateTime(DateUtils.getNowDate());
            event.setCreateBy(deviceLog.getCreateBy());
            // 日志模式 1=影子模式，2=在线模式，3=其他
            event.setMode(3);
            event.setLogValue(deviceLog.getLogValue());
            event.setRemark(deviceLog.getRemark());
            event.setIdentify(deviceLog.getIdentify());
            event.setLogType(deviceLog.getLogType());
            return eventLogMapper.insertEventLog(event);
        } else {
            return deviceLogMapper.insertDeviceLog(deviceLog);
        }
    }

    @Override
    public int saveBatch(TdLogDto dto) {
        int ret = 0;
        for (DeviceLog deviceLog : dto.getList()) {
            ret += this.saveDeviceLog(deviceLog);
        }
        return ret;
    }

    /***
     * 根据设备ID删除设备日志
     * @return
     */
    @Override
    public int deleteDeviceLogByDeviceNumber(String deviceNumber) {
        return deviceLogMapper.deleteDeviceLogByDeviceNumber(deviceNumber);
    }

    /***
     * 设备属性、功能、事件和监测数据总数
     * @return
     */
    @Override
    public DeviceStatistic selectCategoryLogCount(Device device){
        return deviceLogMapper.selectCategoryLogCount(device);
    }


    /***
     * 监测数据列表
     * @return
     */
    @Override
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog) {
        return deviceLogMapper.selectMonitorList(deviceLog);
    }

    /***
     * 日志列表
     * @return
     */
    @Override
    public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog) {
        return deviceLogMapper.selectDeviceLogList(deviceLog);
    }
}
