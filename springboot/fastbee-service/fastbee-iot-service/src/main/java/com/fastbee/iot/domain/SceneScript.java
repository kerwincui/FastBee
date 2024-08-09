package com.fastbee.iot.domain;

import com.fastbee.common.annotation.Excel;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;

import java.util.Date;

/**
 * 场景脚本对象 iot_scene_script
 * 
 * @author kerwincui
 * @date 2023-12-27
 */
@ApiModel(value = "SceneScript", description = "场景脚本")
public class SceneScript
{
    private static final long serialVersionUID = 1L;

    /** 场景脚本ID */
    private String scriptId;

    /** 脚本ID */
    @Excel(name = "场景ID")
    private Long sceneId;

    /** 触发源（1=设备触发，2=定时触发，3=产品触发，4=执行告警） */
    @Excel(name = "触发源", readConverterExp = "1=设备触发，2=定时触发，3=产品触发，4=执行告警")
    private Integer source;

    /** 脚本用途(1=数据流，2=触发器，3=执行动作) */
    private Integer scriptPurpose;

    /** 物模型标识符 */
    private String id;

    /** 物模型名称 */
    @Excel(name = "物模型名称")
    private String name;

    /** 物模型值 */
    @Excel(name = "物模型值")
    private String value;

    /** 操作符 */
    @Excel(name = "操作符")
    private String operator;

    /** 物模型类别（1=属性，2=功能，3=事件，4=设备升级，5=设备上线，6=设备下线） */
    @Excel(name = "物模型类别", readConverterExp = "1==属性，2=功能，3=事件，4=设备升级，5=设备上线，6=设备下线")
    private Integer type;

    /** 设备数量 */
    @Excel(name = "设备数量")
    private Integer deviceCount;

    /** 任务ID */
    @Excel(name = "任务ID")
    private Long jobId;

    /** cron执行表达式 */
    @Excel(name = "cron执行表达式")
    private String cronExpression;

    /** 是否详细corn表达式（1=是，0=否） */
    @Excel(name = "是否详细corn表达式", readConverterExp = "1==是，0=否")
    private Integer isAdvance;

    /** 父物模id */
    @Excel(name = "父物模id")
    private String parentId;

    /** 父物模名称 */
    @Excel(name = "父物模名称")
    private String parentName;

    /** 数组索引 */
    @Excel(name = "数组索引")
    private String arrayIndex;

    /** 数组索引名称（前端展示使用） */
    @Excel(name = "数组索引名称", readConverterExp = "前=端展示使用")
    private String arrayIndexName;

    /** 产品ID*/
    private Long productId;

    /** 产品名称*/
    private String productName;

    /** 设备编号，仅用于传递*/
    private String[] deviceNums;

    /** 创建者 */
    private String createBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public String getScriptId() {
        return scriptId;
    }

    public void setScriptId(String scriptId) {
        this.scriptId = scriptId;
    }

    public Long getSceneId() {
        return sceneId;
    }

    public void setSceneId(Long sceneId) {
        this.sceneId = sceneId;
    }

    public Integer getSource() {
        return source;
    }

    public void setSource(Integer source) {
        this.source = source;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getDeviceCount() {
        return deviceCount;
    }

    public void setDeviceCount(Integer deviceCount) {
        this.deviceCount = deviceCount;
    }

    public Long getJobId() {
        return jobId;
    }

    public void setJobId(Long jobId) {
        this.jobId = jobId;
    }

    public String getCronExpression() {
        return cronExpression;
    }

    public void setCronExpression(String cronExpression) {
        this.cronExpression = cronExpression;
    }

    public Integer getIsAdvance() {
        return isAdvance;
    }

    public void setIsAdvance(Integer isAdvance) {
        this.isAdvance = isAdvance;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getArrayIndex() {
        return arrayIndex;
    }

    public void setArrayIndex(String arrayIndex) {
        this.arrayIndex = arrayIndex;
    }

    public String getArrayIndexName() {
        return arrayIndexName;
    }

    public void setArrayIndexName(String arrayIndexName) {
        this.arrayIndexName = arrayIndexName;
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

    public String[] getDeviceNums() {
        return deviceNums;
    }

    public void setDeviceNums(String[] deviceNums) {
        this.deviceNums = deviceNums;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getScriptPurpose() {
        return scriptPurpose;
    }

    public void setScriptPurpose(Integer scriptPurpose) {
        this.scriptPurpose = scriptPurpose;
    }


}
