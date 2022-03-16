package com.ruoyi.iot.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.iot.mapper.AlertLogMapper;
import com.ruoyi.iot.domain.AlertLog;
import com.ruoyi.iot.service.IAlertLogService;

/**
 * 设备告警Service业务层处理
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
@Service
public class AlertLogServiceImpl implements IAlertLogService 
{
    @Autowired
    private AlertLogMapper alertLogMapper;

    /**
     * 查询设备告警
     * 
     * @param alertLogId 设备告警主键
     * @return 设备告警
     */
    @Override
    public AlertLog selectAlertLogByAlertLogId(Long alertLogId)
    {
        return alertLogMapper.selectAlertLogByAlertLogId(alertLogId);
    }

    /**
     * 查询设备告警列表
     * 
     * @param alertLog 设备告警
     * @return 设备告警
     */
    @Override
    public List<AlertLog> selectAlertLogList(AlertLog alertLog)
    {
        return alertLogMapper.selectAlertLogList(alertLog);
    }

    /**
     * 新增设备告警
     * 
     * @param alertLog 设备告警
     * @return 结果
     */
    @Override
    public int insertAlertLog(AlertLog alertLog)
    {
        alertLog.setCreateTime(DateUtils.getNowDate());
        return alertLogMapper.insertAlertLog(alertLog);
    }

    /**
     * 修改设备告警
     * 
     * @param alertLog 设备告警
     * @return 结果
     */
    @Override
    public int updateAlertLog(AlertLog alertLog)
    {
        alertLog.setUpdateTime(DateUtils.getNowDate());
        return alertLogMapper.updateAlertLog(alertLog);
    }

    /**
     * 批量删除设备告警
     * 
     * @param alertLogIds 需要删除的设备告警主键
     * @return 结果
     */
    @Override
    public int deleteAlertLogByAlertLogIds(Long[] alertLogIds)
    {
        return alertLogMapper.deleteAlertLogByAlertLogIds(alertLogIds);
    }

    /**
     * 删除设备告警信息
     * 
     * @param alertLogId 设备告警主键
     * @return 结果
     */
    @Override
    public int deleteAlertLogByAlertLogId(Long alertLogId)
    {
        return alertLogMapper.deleteAlertLogByAlertLogId(alertLogId);
    }
}
