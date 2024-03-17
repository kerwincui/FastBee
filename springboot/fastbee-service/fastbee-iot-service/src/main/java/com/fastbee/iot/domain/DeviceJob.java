package com.fastbee.iot.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.annotation.Excel.ColumnType;
import com.fastbee.common.constant.ScheduleConstants;
import com.fastbee.common.core.domain.BaseEntity;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.quartz.util.CronUtils;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.Date;

/**
 * 设备定时任务
 * 
 * @author kerwincui
 */
@ApiModel(value = "DeviceJob", description = "设备定时任务 iot_device_job")
public class DeviceJob extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 任务ID */
    @ApiModelProperty("任务ID")
    @Excel(name = "任务序号", cellType = ColumnType.NUMERIC)
    private Long jobId;

    /** 任务名称 */
    @ApiModelProperty("任务名称")
    @Excel(name = "任务名称")
    private String jobName;

    /** 设备编号 */
    @ApiModelProperty("设备编号")
    @Excel(name = "设备编号")
    private String serialNumber;

    /** 设备id */
    @ApiModelProperty("设备id")
    private Long deviceId;

    /** 设备名称 */
    @ApiModelProperty("设备名称")
    private String deviceName;

    /** 执行动作 */
    @ApiModelProperty("执行动作")
    private String actions;

    /** 告警触发器 */
    @ApiModelProperty("告警触发器")
    private String alertTrigger;

    /** 任务组名 */
    @ApiModelProperty("任务组名")
    @Excel(name = "任务组名")
    private String jobGroup;

    /** cron执行表达式 */
    @ApiModelProperty("cron执行表达式")
    @Excel(name = "执行表达式 ")
    private String cronExpression;

    /** cron计划策略 */
    @ApiModelProperty(value = "cron执行表达式", notes = "0=默认,1=立即触发执行,2=触发一次执行,3=不触发立即执行")
    @Excel(name = "计划策略 ", readConverterExp = "0=默认,1=立即触发执行,2=触发一次执行,3=不触发立即执行")
    private String misfirePolicy = ScheduleConstants.MISFIRE_DEFAULT;

    /** 是否并发执行（0允许 1禁止） */
    @ApiModelProperty(value = "是否并发执行", notes = "0=允许,1=禁止")
    @Excel(name = "并发执行", readConverterExp = "0=允许,1=禁止")
    private String concurrent;

    /** 任务状态（0正常 1暂停） */
    @ApiModelProperty("任务状态（0正常 1暂停）")
    @Excel(name = "任务状态", readConverterExp = "0=正常,1=暂停")
    private String status;

    /** 是否详细corn表达式 */
    @ApiModelProperty("是否详细corn表达式")
    private Integer isAdvance;

    /** 定时类型（1=设备定时，2=设备告警，3=场景联动） */
    @ApiModelProperty(value = "定时类型", notes = "（1=设备定时，2=设备告警，3=场景联动）")
    @Excel(name = "定时类型", readConverterExp = "1==设备定时，2=设备告警，3=场景联动")
    private Integer jobType;

    /** 产品ID */
    @ApiModelProperty("产品ID")
    @Excel(name = "产品ID")
    private Long productId;

    /** 产品名称 */
    @ApiModelProperty("产品名称")
    @Excel(name = "产品名称")
    private String productName;

    /** 场景联动ID */
    @ApiModelProperty("场景联动ID")
    @Excel(name = "场景联动ID")
    private Long sceneId;

    /** 告警ID */
    @ApiModelProperty("告警ID")
    @Excel(name = "告警ID")
    private Long alertId;

    public String getAlertTrigger() {
        return alertTrigger;
    }

    public void setAlertTrigger(String alertTrigger) {
        this.alertTrigger = alertTrigger;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public Integer getIsAdvance() {
        return isAdvance;
    }

    public void setIsAdvance(Integer isAdvance) {
        this.isAdvance = isAdvance;
    }

    public Integer getJobType() {
        return jobType;
    }

    public void setJobType(Integer jobType) {
        this.jobType = jobType;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Long getSceneId() {
        return sceneId;
    }

    public void setSceneId(Long sceneId) {
        this.sceneId = sceneId;
    }

    public Long getAlertId() {
        return alertId;
    }

    public void setAlertId(Long alertId) {
        this.alertId = alertId;
    }

    public Long getJobId()
    {
        return jobId;
    }

    public void setJobId(Long jobId)
    {
        this.jobId = jobId;
    }

    @NotBlank(message = "任务名称不能为空")
    @Size(min = 0, max = 64, message = "任务名称不能超过64个字符")
    public String getJobName()
    {
        return jobName;
    }

    public void setJobName(String jobName)
    {
        this.jobName = jobName;
    }

    public String getJobGroup()
    {
        return jobGroup;
    }

    public void setJobGroup(String jobGroup)
    {
        this.jobGroup = jobGroup;
    }

    public Long getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(Long deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getActions() {
        return actions;
    }

    public void setActions(String actions) {
        this.actions = actions;
    }

    @NotBlank(message = "Cron执行表达式不能为空")
    @Size(min = 0, max = 255, message = "Cron执行表达式不能超过255个字符")
    public String getCronExpression()
    {
        return cronExpression;
    }

    public void setCronExpression(String cronExpression)
    {
        this.cronExpression = cronExpression;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public Date getNextValidTime()
    {
        if (StringUtils.isNotEmpty(cronExpression))
        {
            return CronUtils.getNextExecution(cronExpression);
        }
        return null;
    }

    public String getMisfirePolicy()
    {
        return misfirePolicy;
    }

    public void setMisfirePolicy(String misfirePolicy)
    {
        this.misfirePolicy = misfirePolicy;
    }

    public String getConcurrent()
    {
        return concurrent;
    }

    public void setConcurrent(String concurrent)
    {
        this.concurrent = concurrent;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("jobId", getJobId())
            .append("jobName", getJobName())
            .append("jobGroup", getJobGroup())
            .append("cronExpression", getCronExpression())
            .append("nextValidTime", getNextValidTime())
            .append("misfirePolicy", getMisfirePolicy())
            .append("concurrent", getConcurrent())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
