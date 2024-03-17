package com.fastbee.iot.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fastbee.iot.model.ThingsModelItem.*;
import com.fastbee.iot.model.ThingsModels.ThingsModelValueItemDto;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 设备日志对象 iot_device_log
 *
 * @author kerwincui
 * @date 2022-01-13
 */
@ApiModel(value = "DeviceLog", description = "设备日志对象 iot_device_log")
public class DeviceLog extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    @Excel(name = "时间戳")
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date ts;
    /** 设备日志ID */
    @ApiModelProperty("设备日志ID")
    private Long logId;

    /** 类型（1=属性上报，2=事件上报，3=调用功能，4=设备升级，5=设备上线，6=设备离线） */
    @ApiModelProperty(value = "类型", notes = "1=属性上报，2=事件上报，3=调用功能，4=设备升级，5=设备上线，6=设备离线")
    @Excel(name = "类型", readConverterExp = "1=属性上报，2=事件上报，3=调用功能，4=设备升级，5=设备上线，6=设备离线")
    private Integer logType;

    /** 日志值 */
    @ApiModelProperty("日志值")
    @Excel(name = "日志值")
    private String logValue;

    /** 物模型名称 */
    @ApiModelProperty("物模型名称")
    @Excel(name = "物模型名称")
    private String modelName;

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

    /** 标识符 */
    @ApiModelProperty("标识符")
    @Excel(name = "标识符")
    private String identity;

    /** 是否监测数据（1=是，0=否） */
    @ApiModelProperty("是否监测数据（1=是，0=否）")
    @Excel(name = "是否监测数据", readConverterExp = "1=是，0=否")
    private Integer isMonitor;

    /** 模式 */
    @ApiModelProperty(value = "模式", notes = "1=影子模式，2=在线模式,3=其他")
    @Excel(name = "模式", readConverterExp = "1=影子模式，2=在线模式,3=其他")
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

    /** 查询用的开始时间 */
    @ApiModelProperty("查询用的开始时间")
    private String beginTime;

    /** 查询用的结束时间 */
    @ApiModelProperty("查询用的结束时间")
    private String endTime;

    /** 查询的总数 */
    @ApiModelProperty("查询的总数")
    private int total;

    /*消息ID，或消息流水号*/
    @ApiModelProperty("消息ID，或消息流水号")
    private String serNo;

    private String specs;

    private DataType dataType;

    private Integer slaveId;
    /**
     * 计算公式
     */
    private String formula;

    private Integer isParams;

    /*是否历史存储*/
    private Integer isHistory;

    public Integer getIsHistory() {
        return isHistory;
    }

    public void setIsHistory(Integer isHistory) {
        this.isHistory = isHistory;
    }

    public Integer getIsParams() {
        return isParams;
    }

    public void setIsParams(Integer isParams) {
        this.isParams = isParams;
    }

    public String getFormula() {
        return formula;
    }

    public void setFormula(String formula) {
        this.formula = formula;
    }


    public Integer getSlaveId() {
        return slaveId;
    }

    public void setSlaveId(Integer slaveId) {
        this.slaveId = slaveId;
    }

    public DataType getDataType() {
        return dataType;
    }

    public void setDataType(DataType dataType) {
        this.dataType = dataType;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getSpecs() {
        return specs;
    }

    public void setSpecs(String specs) {
        this.specs = specs;
    }

    public String getSerNo() {
        return serNo;
    }

    public void setSerNo(String serNo) {
        this.serNo = serNo;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public Integer getMode() {
        return mode;
    }

    public void setMode(Integer mode) {
        this.mode = mode;
    }

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

    public Date getTs() {
        return ts;
    }

    public void setTs(Date ts) {
        this.ts = ts;
    }

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

    @ApiModel
    public static class DataType{
        private String type;
        private String falseText;
        private String trueText;
        private Integer maxLength;
        private String arrayType;
        private String unit;
        private BigDecimal min;
        private BigDecimal max;
        private BigDecimal step;
        private List<EnumItem> enumList;

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getFalseText() {
            return falseText;
        }

        public void setFalseText(String falseText) {
            this.falseText = falseText;
        }

        public String getTrueText() {
            return trueText;
        }

        public void setTrueText(String trueText) {
            this.trueText = trueText;
        }

        public Integer getMaxLength() {
            return maxLength;
        }

        public void setMaxLength(Integer maxLength) {
            this.maxLength = maxLength;
        }

        public String getArrayType() {
            return arrayType;
        }

        public void setArrayType(String arrayType) {
            this.arrayType = arrayType;
        }

        public String getUnit() {
            return unit;
        }

        public void setUnit(String unit) {
            this.unit = unit;
        }

        public BigDecimal getMin() {
            return min;
        }

        public void setMin(BigDecimal min) {
            this.min = min;
        }

        public BigDecimal getMax() {
            return max;
        }

        public void setMax(BigDecimal max) {
            this.max = max;
        }

        public BigDecimal getStep() {
            return step;
        }

        public void setStep(BigDecimal step) {
            this.step = step;
        }

        public List<EnumItem> getEnumList() {
            return enumList;
        }

        public void setEnumList(List<EnumItem> enumList) {
            this.enumList = enumList;
        }
    }

    @ApiModel
    public static class EnumItem
    {
        private String text;
        private String value;

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public String getValue() {
            return value;
        }

        public void setValue(String value) {
            this.value = value;
        }
    }
}
