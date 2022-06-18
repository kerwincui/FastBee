package com.ruoyi.iot.service.impl;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.iot.domain.DeviceLog;
import com.ruoyi.iot.tdengine.service.ILogService;
import com.ruoyi.iot.mapper.DeviceLogMapper;
import com.ruoyi.iot.model.MonitorModel;
import com.ruoyi.iot.service.IDeviceLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    private DeviceLogMapper deviceLogMapper;

    @Autowired
    private ILogService logService;

    /**
     * 查询设备日志
     * 
     * @param logId 设备日志主键
     * @return 设备日志
     */
    @Override
    public DeviceLog selectDeviceLogByLogId(Long logId)
    {
        return deviceLogMapper.selectDeviceLogByLogId(logId);
    }

    /**
     * 查询设备日志列表
     * 
     * @param deviceLog 设备日志
     * @return 设备日志
     */
    @Override
    public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog)
    {
        return logService.selectDeviceLogList(deviceLog);
    }

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

    /**
     * 新增设备日志
     * 
     * @param deviceLog 设备日志
     * @return 结果
     */
    @Override
    public int insertDeviceLog(DeviceLog deviceLog)
    {
        return logService.saveDeviceLog(deviceLog);
    }

    /**
     * 修改设备日志
     * 
     * @param deviceLog 设备日志
     * @return 结果
     */
    @Override
    public int updateDeviceLog(DeviceLog deviceLog)
    {
        return deviceLogMapper.updateDeviceLog(deviceLog);
    }

    /**
     * 批量删除设备日志
     * 
     * @param logIds 需要删除的设备日志主键
     * @return 结果
     */
    @Override
    public int deleteDeviceLogByLogIds(Long[] logIds)
    {
        return deviceLogMapper.deleteDeviceLogByLogIds(logIds);
    }

    /**
     * 根据设备Ids批量删除设备日志
     *
     * @param deviceNumber 需要删除数据的设备Ids
     * @return 结果
     */
    @Override
    public int deleteDeviceLogByDeviceNumber(String deviceNumber)
    {
        return deviceLogMapper.deleteDeviceLogByDeviceNumber(deviceNumber);
    }

    /**
     * 删除设备日志信息
     * 
     * @param logId 设备日志主键
     * @return 结果
     */
    @Override
    public int deleteDeviceLogByLogId(Long logId)
    {
        return deviceLogMapper.deleteDeviceLogByLogId(logId);
    }
}
