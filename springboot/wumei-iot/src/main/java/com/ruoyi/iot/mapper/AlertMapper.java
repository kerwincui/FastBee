package com.ruoyi.iot.mapper;

import java.util.List;
import com.ruoyi.iot.domain.Alert;
import org.springframework.stereotype.Repository;

/**
 * 设备告警Mapper接口
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
@Repository
public interface AlertMapper 
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
     * 删除设备告警
     * 
     * @param alertId 设备告警主键
     * @return 结果
     */
    public int deleteAlertByAlertId(Long alertId);

    /**
     * 批量删除设备告警
     * 
     * @param alertIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAlertByAlertIds(Long[] alertIds);
}
