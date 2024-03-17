package com.fastbee.iot.service.impl;

import java.util.List;
import com.fastbee.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fastbee.iot.mapper.EventLogMapper;
import com.fastbee.iot.domain.EventLog;
import com.fastbee.iot.service.IEventLogService;

/**
 * 事件日志Service业务层处理
 * 
 * @author kerwincui
 * @date 2023-03-28
 */
@Service
public class EventLogServiceImpl implements IEventLogService 
{
    @Autowired
    private EventLogMapper eventLogMapper;

    /**
     * 查询事件日志
     * 
     * @param logId 事件日志主键
     * @return 事件日志
     */
    @Override
    public EventLog selectEventLogByLogId(Long logId)
    {
        return eventLogMapper.selectEventLogByLogId(logId);
    }

    /**
     * 查询事件日志列表
     * 
     * @param eventLog 事件日志
     * @return 事件日志
     */
    @Override
    public List<EventLog> selectEventLogList(EventLog eventLog)
    {
        return eventLogMapper.selectEventLogList(eventLog);
    }

    /**
     * 新增事件日志
     * 
     * @param eventLog 事件日志
     * @return 结果
     */
    @Override
    public int insertEventLog(EventLog eventLog)
    {
        eventLog.setCreateTime(DateUtils.getNowDate());
        return eventLogMapper.insertEventLog(eventLog);
    }

    /**
     * 批量存储事件日志
     * @param list
     */
    @Override
    public void insertBatch(List<EventLog> list){
        eventLogMapper.insertBatch(list);
    }

    /**
     * 修改事件日志
     * 
     * @param eventLog 事件日志
     * @return 结果
     */
    @Override
    public int updateEventLog(EventLog eventLog)
    {
        return eventLogMapper.updateEventLog(eventLog);
    }

    /**
     * 批量删除事件日志
     * 
     * @param logIds 需要删除的事件日志主键
     * @return 结果
     */
    @Override
    public int deleteEventLogByLogIds(Long[] logIds)
    {
        return eventLogMapper.deleteEventLogByLogIds(logIds);
    }

    /**
     * 删除事件日志信息
     * 
     * @param logId 事件日志主键
     * @return 结果
     */
    @Override
    public int deleteEventLogByLogId(Long logId)
    {
        return eventLogMapper.deleteEventLogByLogId(logId);
    }

    /**
     * 通过设备ID删除设备事件日志
     *
     * @param serialNumber 设备编号
     * @return 结果
     */
    @Override
    public int deleteEventLogByDeviceNumber(String serialNumber)
    {
        return eventLogMapper.deleteEventLogBySerialNumber(serialNumber);
    }
}
