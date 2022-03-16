package com.ruoyi.iot.service;

import java.util.List;
import com.ruoyi.iot.domain.Alert;

/**
 * 设备告警Service接口
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
public interface IAlertService 
{
    /**
     * 查询设备告警
     * 
     * @param alertId 设备告警主键
     * @return 设备告警
     */
    public Alert selectAlertByAlertId(Long alertId);

    /**
     * 查询设备告警列表
     * 
     * @param alert 设备告警
     * @return 设备告警集合
     */
    public List<Alert> selectAlertList(Alert alert);

    /**
     * 新增设备告警
     * 
     * @param alert 设备告警
     * @return 结果
     */
    public int insertAlert(Alert alert);

    /**
     * 修改设备告警
     * 
     * @param alert 设备告警
     * @return 结果
     */
    public int updateAlert(Alert alert);

    /**
     * 批量删除设备告警
     * 
     * @param alertIds 需要删除的设备告警主键集合
     * @return 结果
     */
    public int deleteAlertByAlertIds(Long[] alertIds);

    /**
     * 删除设备告警信息
     * 
     * @param alertId 设备告警主键
     * @return 结果
     */
    public int deleteAlertByAlertId(Long alertId);
}
