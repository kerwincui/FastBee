package com.fastbee.iot.service;

import com.fastbee.iot.domain.EventLog;

import java.util.List;

/**
 * 事件日志Service接口
 * 
 * @author kerwincui
 * @date 2023-03-28
 */
public interface IEventLogService 
{
    /**
     * 查询事件日志
     * 
     * @param logId 事件日志主键
     * @return 事件日志
     */
    public EventLog selectEventLogByLogId(Long logId);

    /**
     * 查询事件日志列表
     * 
     * @param eventLog 事件日志
     * @return 事件日志集合
     */
    public List<EventLog> selectEventLogList(EventLog eventLog);

    /**
     * 新增事件日志
     * 
     * @param eventLog 事件日志
     * @return 结果
     */
    public int insertEventLog(EventLog eventLog);

    /**
     * 批量存储事件日志
     * @param list
     */
    public void insertBatch(List<EventLog> list);

    /**
     * 修改事件日志
     * 
     * @param eventLog 事件日志
     * @return 结果
     */
    public int updateEventLog(EventLog eventLog);

    /**
     * 批量删除事件日志
     * 
     * @param logIds 需要删除的事件日志主键集合
     * @return 结果
     */
    public int deleteEventLogByLogIds(Long[] logIds);

    /**
     * 删除事件日志信息
     * 
     * @param logId 事件日志主键
     * @return 结果
     */
    public int deleteEventLogByLogId(Long logId);

    /**
     * 通过设备ID删除设备事件日志
     *
     * @param serialNumber 设备编号
     * @return 结果
     */
    public int deleteEventLogByDeviceNumber(String serialNumber);
}
