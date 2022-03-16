package com.ruoyi.iot.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 设备用户对象 iot_device_user
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class DeviceUser extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 固件ID */
    private Long deviceId;

    /** 用户ID */
    private Long userId;

    /** 设备名称 */
    @Excel(name = "设备名称")
    private String deviceName;

    /** 用户昵称 */
    @Excel(name = "用户昵称")
    private String userName;

    /** 是否为设备所有者 */
    @Excel(name = "是否为设备所有者")
    private Integer isOwner;

    /** 租户ID */
    private Long tenantId;

    /** 租户名称 */
    private String tenantName;

    /** 手机号码 */
    private String phonenumber;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
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

    public void setDeviceId(Long deviceId)
    {
        this.deviceId = deviceId;
    }

    public Long getDeviceId() 
    {
        return deviceId;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setDeviceName(String deviceName) 
    {
        this.deviceName = deviceName;
    }

    public String getDeviceName() 
    {
        return deviceName;
    }
    public void setUserName(String userName) 
    {
        this.userName = userName;
    }

    public String getUserName() 
    {
        return userName;
    }
    public void setIsOwner(Integer isOwner)
    {
        this.isOwner = isOwner;
    }

    public Integer getIsOwner()
    {
        return isOwner;
    }
    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("deviceId", getDeviceId())
            .append("userId", getUserId())
            .append("deviceName", getDeviceName())
            .append("userName", getUserName())
            .append("isOwner", getIsOwner())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
