package com.fastbee.iot.service.impl;

import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.model.HistoryModel;
import com.fastbee.iot.tdengine.service.ILogService;
import com.fastbee.iot.mapper.DeviceLogMapper;
import com.fastbee.iot.model.MonitorModel;
import com.fastbee.iot.service.IDeviceLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 设备日志Service业务层处理
 *
 * @author kerwincui
 * @date 2022-01-13
 */
@Service
public class DeviceLogServiceImpl implements IDeviceLogService
{

    @Autowired
    private ILogService logService;

    /**
     * 查询设备监测数据
     *
     * @param deviceLog 设备日志
     * @return 设备日志
     */
    @Override
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog)
    {
        return logService.selectMonitorList(deviceLog);
    }

}
