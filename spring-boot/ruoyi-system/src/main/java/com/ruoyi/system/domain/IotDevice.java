package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 设备对象 iot_device
 * 
 * @author kerwincui
 * @date 2021-05-06
 */
public class IotDevice extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 序号 */
    private Long deviceId;

    /** 编号 */
    @Excel(name = "编号")
    private String deviceNum;

    /** 分类 */
    @Excel(name = "分类")
    private Long categoryId;

    /** 名称 */
    @Excel(name = "名称")
    private String deviceName;

    /** 固件版本 */
    @Excel(name = "固件版本")
    private String firmwareVersion;

    /** 用户 */
    @Excel(name = "用户")
    private String ownerId;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    public void setDeviceId(Long deviceId) 
    {
        this.deviceId = deviceId;
    }

    public Long getDeviceId() 
    {
        return deviceId;
    }
    public void setDeviceNum(String deviceNum) 
    {
        this.deviceNum = deviceNum;
    }

    public String getDeviceNum() 
    {
        return deviceNum;
    }
    public void setCategoryId(Long categoryId) 
    {
        this.categoryId = categoryId;
    }

    public Long getCategoryId() 
    {
        return categoryId;
    }
    public void setDeviceName(String deviceName) 
    {
        this.deviceName = deviceName;
    }

    public String getDeviceName() 
    {
        return deviceName;
    }
    public void setFirmwareVersion(String firmwareVersion) 
    {
        this.firmwareVersion = firmwareVersion;
    }

    public String getFirmwareVersion() 
    {
        return firmwareVersion;
    }
    public void setOwnerId(String ownerId) 
    {
        this.ownerId = ownerId;
    }

    public String getOwnerId() 
    {
        return ownerId;
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
            .append("deviceNum", getDeviceNum())
            .append("categoryId", getCategoryId())
            .append("deviceName", getDeviceName())
            .append("firmwareVersion", getFirmwareVersion())
            .append("ownerId", getOwnerId())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
