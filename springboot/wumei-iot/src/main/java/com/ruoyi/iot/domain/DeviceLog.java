package com.ruoyi.iot.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 设备日志对象 iot_device_log
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
public class DeviceLog extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 设备日志ID */
    private Long logId;

    /** 类型（1=属性上报，2=事件上报，3=调用功能，4=设备升级，5=设备上线，6=设备离线） */
    @Excel(name = "类型", readConverterExp = "1==属性上报，2=事件上报，3=调用功能，4=设备升级，5=设备上线，6=设备离线")
    private Integer logType;

    /** 日志值 */
    @Excel(name = "日志值")
    private String logValue;

    /** 设备ID */
    @Excel(name = "设备ID")
    private Long deviceId;

    /** 设备名称 */
    @Excel(name = "设备名称")
    private String deviceName;

    /** 设备编号 */
    @Excel(name = "设备编号")
    private String serialNumber;

    /** 标识符 */
    @Excel(name = "标识符")
    private String identity;

    /** 是否监测数据（1=是，0=否） */
    @Excel(name = "是否监测数据", readConverterExp = "1==是，0=否")
    private Integer isMonitor;

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public void setLogId(Long logId)
    {
        this.logId = logId;
    }

    public Long getLogId() 
    {
        return logId;
    }

    public void setLogType(Integer logType) 
    {
        this.logType = logType;
    }

    public Integer getLogType() 
    {
        return logType;
    }
    public void setLogValue(String logValue) 
    {
        this.logValue = logValue;
    }

    public String getLogValue() 
    {
        return logValue;
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
    public void setIdentity(String identity) 
    {
        this.identity = identity;
    }

    public String getIdentity() 
    {
        return identity;
    }
    public void setIsMonitor(Integer isMonitor) 
    {
        this.isMonitor = isMonitor;
    }

    public Integer getIsMonitor() 
    {
        return isMonitor;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("logId", getLogId())
            .append("logType", getLogType())
            .append("logValue", getLogValue())
            .append("deviceId", getDeviceId())
            .append("deviceName", getDeviceName())
            .append("identity", getIdentity())
            .append("createBy", getCreateBy())
            .append("isMonitor", getIsMonitor())
            .append("createTime", getCreateTime())
            .append("remark", getRemark())
            .toString();
    }
}
