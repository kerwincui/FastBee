package com.fastbee.iot.domain;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;

/**
 * 通用物模型对象 iot_things_model_template
 *
 * @author kerwincui
 * @date 2023-01-15
 */
@ApiModel(value = "ThingsModelTemplate", description = "通用物模型对象 iot_things_model_template")
public class ThingsModelTemplate extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 物模型ID */
    @ApiModelProperty("物模型ID")
    private Long templateId;

    /** 物模型名称 */
    @ApiModelProperty("物模型名称")
    @Excel(name = "物模型名称" ,prompt = "必填")
    private String templateName;

    /** 租户ID */
    @ApiModelProperty("租户ID")
    private Long tenantId;

    /** 租户名称 */
    @ApiModelProperty("租户名称")
    private String tenantName;

    /** 标识符，产品下唯一 */
    @ApiModelProperty("标识符，产品下唯一")
    @Excel(name = "标识符",prompt = "modbus不填,默认为寄存器地址")
    private String identifier;

    /** 模型类别（1-属性，2-功能，3-事件） */
    @ApiModelProperty(value = "模型类别", notes = "（1-属性，2-功能，3-事件）")
    @Excel(name = "模型类别", readConverterExp = "1=属性,2=功能,3=事件",prompt ="1=属性，2-功能，3-事件")
    private Integer type;

    /** 从机id */
    @ApiModelProperty("从机id")
    private String tempSlaveId;

    /** 寄存器地址 */
    @ApiModelProperty("寄存器地址")
    @Excel(name = "寄存器地址" , prompt = "可填写10进制或16进制,16带H,例如:0020H")
    private String regStr;

    /** 计算公式 */
    @ApiModelProperty("计算公式")
    @Excel(name = "计算公式",prompt = "选填,例如:%s*10,%s是占位符")
    private String formula;

    /** 数据定义 */
    //@Excel(name = "数据定义")
    @ApiModelProperty("数据定义")
    private String specs;

    /** 是否系统通用（0-否，1-是） */
    @ApiModelProperty("是否系统通用（0-否，1-是）")
    private Integer isSys;

    /** 控制公式 */
    @ApiModelProperty("控制公式")
    @Excel(name = "控制公式",prompt = "选填,例如:%s*10,%s是占位符")
    private String reverseFormula;

    /** 寄存器地址值 */
    @ApiModelProperty("寄存器地址值")
    private Integer regAddr;



    /** 是否图表显示（0-否，1-是） */
    @ApiModelProperty("是否图表显示（0-否，1-是）")
    @Excel(name = "是否图表显示", readConverterExp = "0=否，1=是")
    private Integer isChart;

    /** 是否历史存储（0-否，1-是） */
    @ApiModelProperty("是否历史存储（0-否，1-是）")
    @Excel(name = "是否历史存储", readConverterExp = "0=否，1=是")
    private Integer isHistory;

    /** 是否实时监测（0-否，1-是） */
    @ApiModelProperty("是否实时监测（0-否，1-是）")
    @Excel(name = "是否实时监测", readConverterExp = "0=否，1=是")
    private Integer isMonitor;

    /** 是否分享设备权限（0-否，1-是） */
    @ApiModelProperty(value = "是否分享设备权限", notes = "（0-否，1-是） ")
    @Excel(name = "是否分享设备权限", readConverterExp = "0=否,1=是")
    private Integer isSharePerm;

    /** 删除标志（0代表存在 2代表删除） */
    @ApiModelProperty("删除标志（0代表存在 2代表删除）")
    private String delFlag;

    @Excel(name = "单位")
    private String unit;

    /** 数值类型 1.数值 2.选项 */
    @ApiModelProperty("数值类型 1.数值 2.选项")
    @Excel(name = "解析类型" ,prompt = "解析类型 INT,INT16,UINT16")
    private String valueType;

    /** 数据类型（integer、decimal、string、bool、array、enum） */
    @ApiModelProperty(value = "数据类型", notes = "（integer、decimal、string、bool、array、enum）")
    @Excel(name = "数据类型", prompt = "integer、decimal、string、bool、array、enum")
    private String datatype;

    @ApiModelProperty("有效值范围")
    @Excel(name = "有效值范围")
    private String limitValue;

    /** 位定义选项 */
    @ApiModelProperty("位定义选项")
    @Excel(name = "位定义选项")
    private String bitOption;

    /** 是否只读数据(0-否，1-是) */
    @ApiModelProperty("是否只读数据(0-否，1-是)")
    @Excel(name = "是否只读", readConverterExp = "0=否,1=是",prompt = "0=否,1=是")
    private Integer isReadonly;

    @ApiModelProperty("是否是计算参数,默认否")
    @Excel(name = "是否是计算参数,默认否",readConverterExp = "0=否,1=是")
    private Integer isParams;

    @ApiModelProperty("读取寄存器个数")
    @Excel(name ="读取寄存器个数")
    private Integer quantity;

    @ApiModelProperty("解析类型")
    @Excel(name = "解析类型")
    private String parseType;


    public String getParseType() {
        return parseType;
    }

    public void setParseType(String parseType) {
        this.parseType = parseType;
    }

    private String oldTempSlaveId;

    /**
     * 功能码
     */
    private String code;

    public String getOldTempSlaveId() {
        return oldTempSlaveId;
    }

    public void setOldTempSlaveId(String oldTempSlaveId) {
        this.oldTempSlaveId = oldTempSlaveId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    private Integer modelOrder;

    public Integer getIsParams() {
        return isParams;
    }

    public void setIsParams(Integer isParams) {
        this.isParams = isParams;
    }

    public String getRegStr() {
        return regStr;
    }

    public void setRegStr(String regStr) {
        this.regStr = regStr;
    }

    public String getLimitValue() {
        return limitValue;
    }

    public void setLimitValue(String limitValue) {
        this.limitValue = limitValue;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public void setTemplateId(Long templateId)
    {
        this.templateId = templateId;
    }

    public Long getTemplateId()
    {
        return templateId;
    }
    public void setTemplateName(String templateName)
    {
        this.templateName = templateName;
    }

    public String getTemplateName()
    {
        return templateName;
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
    public void setIdentifier(String identifier)
    {
        this.identifier = identifier;
    }

    public String getIdentifier()
    {
        return identifier;
    }
    public void setType(Integer type)
    {
        this.type = type;
    }

    public Integer getType()
    {
        return type;
    }
    public void setDatatype(String datatype)
    {
        this.datatype = datatype;
    }

    public String getDatatype()
    {
        return datatype;
    }
    public void setSpecs(String specs)
    {
        this.specs = specs;
    }

    public String getSpecs()
    {
        return specs;
    }
    public void setIsSys(Integer isSys)
    {
        this.isSys = isSys;
    }

    public Integer getIsSys()
    {
        return isSys;
    }
    public void setIsReadonly(Integer isReadonly)
    {
        this.isReadonly = isReadonly;
    }

    public Integer getIsReadonly()
    {
        return isReadonly;
    }
    public void setIsChart(Integer isChart)
    {
        this.isChart = isChart;
    }

    public Integer getIsChart()
    {
        return isChart;
    }
    public void setIsHistory(Integer isHistory)
    {
        this.isHistory = isHistory;
    }

    public Integer getIsHistory()
    {
        return isHistory;
    }

    public String getTempSlaveId() {
        return tempSlaveId;
    }

    public void setTempSlaveId(String tempSlaveId) {
        this.tempSlaveId = tempSlaveId;
    }

    public void setIsMonitor(Integer isMonitor)
    {
        this.isMonitor = isMonitor;
    }

    public Integer getIsMonitor()
    {
        return isMonitor;
    }
    public void setFormula(String formula)
    {
        this.formula = formula;
    }

    public String getFormula()
    {
        return formula;
    }
    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag()
    {
        return delFlag;
    }
    public void setReverseFormula(String reverseFormula)
    {
        this.reverseFormula = reverseFormula;
    }

    public String getReverseFormula()
    {
        return reverseFormula;
    }
    public void setRegAddr(Integer regAddr)
    {
        this.regAddr = regAddr;
    }

    public Integer getRegAddr()
    {
        return regAddr;
    }
    public void setBitOption(String bitOption)
    {
        this.bitOption = bitOption;
    }

    public String getBitOption()
    {
        return bitOption;
    }

    public String getValueType() {
        return valueType;
    }

    public void setValueType(String valueType) {
        this.valueType = valueType;
    }

    public void setModelOrder(Integer modelOrder)
    {
        this.modelOrder = modelOrder;
    }

    public Integer getModelOrder()
    {
        return modelOrder;
    }

    public Integer getIsSharePerm() {
        return isSharePerm;
    }

    public void setIsSharePerm(Integer isSharePerm) {
        this.isSharePerm = isSharePerm;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("templateId", getTemplateId())
                .append("templateName", getTemplateName())
                .append("tenantId", getTenantId())
                .append("tenantName", getTenantName())
                .append("identifier", getIdentifier())
                .append("type", getType())
                .append("datatype", getDatatype())
                .append("specs", getSpecs())
                .append("isSys", getIsSys())
                .append("isReadonly", getIsReadonly())
                .append("isChart", getIsChart())
                .append("tempSlaveId", getTempSlaveId())
                .append("isMonitor", getIsMonitor())
                .append("formula", getFormula())
                .append("delFlag", getDelFlag())
                .append("reverseFormula", getReverseFormula())
                .append("createBy", getCreateBy())
                .append("regAddr", getRegAddr())
                .append("createTime", getCreateTime())
                .append("bitOption", getBitOption())
                .append("updateBy", getUpdateBy())
                .append("valueType", getValueType())
                .append("updateTime", getUpdateTime())
                .append("remark", getRemark())
                .append("modelOrder", getModelOrder())
                .toString();
    }
}
