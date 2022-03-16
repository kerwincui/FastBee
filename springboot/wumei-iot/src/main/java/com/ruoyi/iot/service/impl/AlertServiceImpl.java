package com.ruoyi.iot.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.iot.mapper.AlertMapper;
import com.ruoyi.iot.domain.Alert;
import com.ruoyi.iot.service.IAlertService;

/**
 * 设备告警Service业务层处理
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
@Service
public class AlertServiceImpl implements IAlertService 
{
    @Autowired
    private AlertMapper alertMapper;

    /**
     * 查询设备告警
     * 
     * @param alertId 设备告警主键
     * @return 设备告警
     */
    @Override
    public Alert selectAlertByAlertId(Long alertId)
    {
        return alertMapper.selectAlertByAlertId(alertId);
    }

    /**
     * 查询设备告警列表
     * 
     * @param alert 设备告警
     * @return 设备告警
     */
    @Override
    public List<Alert> selectAlertList(Alert alert)
    {
        return alertMapper.selectAlertList(alert);
    }

    /**
     * 新增设备告警
     * 
     * @param alert 设备告警
     * @return 结果
     */
    @Override
    public int insertAlert(Alert alert)
    {
        alert.setCreateTime(DateUtils.getNowDate());
        return alertMapper.insertAlert(alert);
    }

    /**
     * 修改设备告警
     * 
     * @param alert 设备告警
     * @return 结果
     */
    @Override
    public int updateAlert(Alert alert)
    {
        alert.setUpdateTime(DateUtils.getNowDate());
        return alertMapper.updateAlert(alert);
    }

    /**
     * 批量删除设备告警
     * 
     * @param alertIds 需要删除的设备告警主键
     * @return 结果
     */
    @Override
    public int deleteAlertByAlertIds(Long[] alertIds)
    {
        return alertMapper.deleteAlertByAlertIds(alertIds);
    }

    /**
     * 删除设备告警信息
     * 
     * @param alertId 设备告警主键
     * @return 结果
     */
    @Override
    public int deleteAlertByAlertId(Long alertId)
    {
        return alertMapper.deleteAlertByAlertId(alertId);
    }
}
