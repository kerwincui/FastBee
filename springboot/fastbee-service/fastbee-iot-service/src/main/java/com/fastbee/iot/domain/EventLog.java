package com.fastbee.iot.domain;

import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * @author gsb
 * @date 2023/3/28 16:25
 */
@ApiModel(value = "EventLog", description = "事件日志对象 iot_event_log")
public class EventLog extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /** 设备日志ID */
    @ApiModelProperty("设备日志ID")
    private Long logId;

    /** 标识符 */
    @ApiModelProperty("标识符")
    @Excel(name = "标识符")
    private String identity;

    /** 物模型名称 */
    @ApiModelProperty("物模型名称")
    @Excel(name = "物模型名称")
    private String modelName;

    /** 类型（3=事件上报，5=设备上线，6=设备离线） */
    @ApiModelProperty(value = "类型", notes = "3==事件上报，5=设备上线，6=设备离线")
    @Excel(name = "类型", readConverterExp = "3==事件上报，5=设备上线，6=设备离线")
    private Integer logType;

    /** 日志值 */
    @ApiModelProperty("日志值")
    @Excel(name = "日志值")
    private String logValue;

    /** 设备ID */
    @ApiModelProperty("设备ID")
    @Excel(name = "设备ID")
    private Long deviceId;

    /** 设备名称 */
    @ApiModelProperty("设备名称")
    @Excel(name = "设备名称")
    private String deviceName;

    /** 设备编号 */
    @ApiModelProperty("设备编号")
    @Excel(name = "设备编号")
    private String serialNumber;

    /** 是否监测数据（1=是，0=否） */
    @ApiModelProperty(value = "是否监测数据", notes = "（1=是，0=否）")
    @Excel(name = "是否监测数据", readConverterExp = "1==是，0=否")
    private Integer isMonitor;

    /** 模式(1=影子模式，2=在线模式，3=其他) */
    @ApiModelProperty(value = "模式", notes = "(1=影子模式，2=在线模式，3=其他)")
    @Excel(name = "模式(1=影子模式，2=在线模式，3=其他)")
    private Integer mode;

    /** 用户ID */
    @ApiModelProperty("用户ID")
    @Excel(name = "用户ID")
    private Long userId;

    /** 用户昵称 */
    @ApiModelProperty("用户昵称")
    @Excel(name = "用户昵称")
    private String userName;

    /** 租户ID */
    @ApiModelProperty("租户ID")
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 租户名称 */
    @ApiModelProperty("租户名称")
    @Excel(name = "租户名称")
    private String tenantName;

    public void setLogId(Long logId)
    {
        this.logId = logId;
    }

    public Long getLogId()
    {
        return logId;
    }
    public void setIdentity(String identity)
    {
        this.identity = identity;
    }

    public String getIdentity()
    {
        return identity;
    }
    public void setModelName(String modelName)
    {
        this.modelName = modelName;
    }

    public String getModelName()
    {
        return modelName;
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
    public void setSerialNumber(String serialNumber)
    {
        this.serialNumber = serialNumber;
    }

    public String getSerialNumber()
    {
        return serialNumber;
    }
    public void setIsMonitor(Integer isMonitor)
    {
        this.isMonitor = isMonitor;
    }

    public Integer getIsMonitor()
    {
        return isMonitor;
    }
    public void setMode(Integer mode)
    {
        this.mode = mode;
    }

    public Integer getMode()
    {
        return mode;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getUserName()
    {
        return userName;
    }
    public void setTenantId(Long tenantId)
    {
        this.tenantId = tenantId;
    }

    public Long getTenantId()
    {
        return tenantId;
    }
    public void setTenantName(String tenantName)
    {
        this.tenantName = tenantName;
    }

    public String getTenantName()
    {
        return tenantName;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("logId", getLogId())
                .append("identity", getIdentity())
                .append("modelName", getModelName())
                .append("logType", getLogType())
                .append("logValue", getLogValue())
                .append("deviceId", getDeviceId())
                .append("deviceName", getDeviceName())
                .append("serialNumber", getSerialNumber())
                .append("isMonitor", getIsMonitor())
                .append("mode", getMode())
                .append("userId", getUserId())
                .append("userName", getUserName())
                .append("tenantId", getTenantId())
                .append("tenantName", getTenantName())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("remark", getRemark())
                .toString();
    }
}
