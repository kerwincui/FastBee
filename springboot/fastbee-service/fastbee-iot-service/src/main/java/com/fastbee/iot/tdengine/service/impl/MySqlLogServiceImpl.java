package com.fastbee.iot.tdengine.service.impl;

import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.model.DeviceStatistic;
import com.fastbee.iot.model.HistoryModel;
import com.fastbee.iot.tdengine.service.ILogService;
import com.fastbee.iot.mapper.DeviceLogMapper;
import com.fastbee.iot.model.MonitorModel;
import com.fastbee.iot.tdengine.service.model.TdLogDto;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class MySqlLogServiceImpl implements ILogService {

    private DeviceLogMapper deviceLogMapper;

    public MySqlLogServiceImpl(DeviceLogMapper _deviceLogMapper){
        this.deviceLogMapper=_deviceLogMapper;
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

}
