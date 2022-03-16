package com.ruoyi.iot.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 设备告警对象 iot_alert
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
public class Alert extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 告警ID */
    private Long alertId;

    /** 告警名称 */
    @Excel(name = "告警名称")
    private String alertName;

    /** 告警级别（1=提醒通知，2=轻微问题，3=严重警告） */
    @Excel(name = "告警级别", readConverterExp = "1==提醒通知，2=轻微问题，3=严重警告")
    private Long alertLevel;

    /** 产品ID */
    @Excel(name = "产品ID")
    private Long productId;

    /** 产品名称 */
    @Excel(name = "产品名称")
    private String productName;

    /** 触发器 */
    @Excel(name = "触发器")
    private String triggers;

    /** 执行动作 */
    @Excel(name = "执行动作")
    private String actions;

    /** 告警状态 （1-启动，2-停止）**/
    private Integer status;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public void setAlertId(Long alertId)
    {
        this.alertId = alertId;
    }

    public Long getAlertId() 
    {
        return alertId;
    }
    public void setAlertName(String alertName) 
    {
        this.alertName = alertName;
    }

    public String getAlertName() 
    {
        return alertName;
    }
    public void setAlertLevel(Long alertLevel) 
    {
        this.alertLevel = alertLevel;
    }

    public Long getAlertLevel() 
    {
        return alertLevel;
    }
    public void setProductId(Long productId) 
    {
        this.productId = productId;
    }

    public Long getProductId() 
    {
        return productId;
    }
    public void setProductName(String productName) 
    {
        this.productName = productName;
    }

    public String getProductName() 
    {
        return productName;
    }
    public void setTriggers(String triggers) 
    {
        this.triggers = triggers;
    }

    public String getTriggers() 
    {
        return triggers;
    }
    public void setActions(String actions) 
    {
        this.actions = actions;
    }

    public String getActions() 
    {
        return actions;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("alertId", getAlertId())
            .append("alertName", getAlertName())
            .append("alertLevel", getAlertLevel())
            .append("productId", getProductId())
            .append("productName", getProductName())
            .append("triggers", getTriggers())
            .append("actions", getActions())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
