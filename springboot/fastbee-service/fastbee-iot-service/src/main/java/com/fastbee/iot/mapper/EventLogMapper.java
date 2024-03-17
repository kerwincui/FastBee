package com.fastbee.iot.mapper;

import java.util.List;
import com.fastbee.iot.domain.EventLog;
import org.springframework.stereotype.Repository;

/**
 * 事件日志Mapper接口
 * 
 * @author kerwincui
 * @date 2023-03-28
 */
@Repository
public interface EventLogMapper 
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
     * 删除事件日志
     * 
     * @param logId 事件日志主键
     * @return 结果
     */
    public int deleteEventLogByLogId(Long logId);

    /**
     * 根据设备编号删除事件日志
     *
     * @param serialNumber 设备编号
     * @return 结果
     */
    public int deleteEventLogBySerialNumber(String serialNumber);

    /**
     * 批量删除事件日志
     * 
     * @param logIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteEventLogByLogIds(Long[] logIds);
}
