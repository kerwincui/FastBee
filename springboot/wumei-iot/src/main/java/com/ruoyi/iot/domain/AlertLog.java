package com.ruoyi.iot.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 设备告警对象 iot_alert_log
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
public class AlertLog extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 告警ID */
    private Long alertLogId;

    /** 告警名称 */
    @Excel(name = "告警名称")
    private String alertName;

    /** 告警级别（1=提醒通知，2=轻微问题，3=严重警告，4=场景联动） */
    @Excel(name = "告警级别", readConverterExp = "1==提醒通知，2=轻微问题，3=严重警告，4=场景联动")
    private Long alertLevel;

    /** 处理状态(0=不需要处理,1=未处理,2=已处理) */
    @Excel(name = "处理状态(0=不需要处理,1=未处理,2=已处理)")
    private Long status;

    /** 产品ID */
    @Excel(name = "产品ID")
    private Long productId;

    /** 产品名称 */
    @Excel(name = "产品名称")
    private String productName;

    /** 设备ID */
    @Excel(name = "设备ID")
    private Long deviceId;

    /** 设备名称 */
    @Excel(name = "设备名称")
    private String deviceName;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 用户昵称 */
    @Excel(name = "用户昵称")
    private String userName;

    /** 租户ID */
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 租户名称 */
    @Excel(name = "租户名称")
    private String tenantName;

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Long getTenantId() {
        return tenantId;
    }

    public void setTenantId(Long tenantId) {
        this.tenantId = tenantId;
    }

    public String getTenantName() {
        return tenantName;
    }

    public void setTenantName(String tenantName) {
        this.tenantName = tenantName;
    }

    public void setAlertLogId(Long alertLogId)
    {
        this.alertLogId = alertLogId;
    }

    public Long getAlertLogId() 
    {
        return alertLogId;
    }
    public void setAlertName(String alertLogName)
    {
        this.alertName = alertLogName;
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
    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
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
    public void setDeviceId(Long deviceId) 
    {
        this.deviceId = deviceId;
    }

    public Long getDeviceId() 
    {
        return deviceId;
    }
    public void setDeviceName(String deviceName) 
    {
        this.deviceName = deviceName;
    }

    public String getDeviceName() 
    {
        return deviceName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("alertLogId", getAlertLogId())
            .append("alertName", getAlertName())
            .append("alertLevel", getAlertLevel())
            .append("status", getStatus())
            .append("productId", getProductId())
            .append("productName", getProductName())
            .append("deviceId", getDeviceId())
            .append("deviceName", getDeviceName())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
