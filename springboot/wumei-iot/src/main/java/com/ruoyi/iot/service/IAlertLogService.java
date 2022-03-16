package com.ruoyi.iot.service;

import com.ruoyi.iot.domain.AlertLog;

import java.util.List;

/**
 * 设备告警Service接口
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
public interface IAlertLogService 
{
    /**
     * 查询设备告警
     * 
     * @param alertLogId 设备告警主键
     * @return 设备告警
     */
    public AlertLog selectAlertLogByAlertLogId(Long alertLogId);

    /**
     * 查询设备告警列表
     * 
     * @param alertLog 设备告警
     * @return 设备告警集合
     */
    public List<AlertLog> selectAlertLogList(AlertLog alertLog);

    /**
     * 新增设备告警
     * 
     * @param alertLog 设备告警
     * @return 结果
     */
    public int insertAlertLog(AlertLog alertLog);

    /**
     * 修改设备告警
     * 
     * @param alertLog 设备告警
     * @return 结果
     */
    public int updateAlertLog(AlertLog alertLog);

    /**
     * 批量删除设备告警
     * 
     * @param alertLogIds 需要删除的设备告警主键集合
     * @return 结果
     */
    public int deleteAlertLogByAlertLogIds(Long[] alertLogIds);

    /**
     * 删除设备告警信息
     * 
     * @param alertLogId 设备告警主键
     * @return 结果
     */
    public int deleteAlertLogByAlertLogId(Long alertLogId);
}
