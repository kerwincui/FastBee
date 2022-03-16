package com.ruoyi.iot.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 通用物模型对象 iot_things_model_template
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class ThingsModelTemplate extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 物模型ID */
    private Long templateId;

    /** 物模型名称 */
    @Excel(name = "物模型名称")
    private String templateName;

    /** 租户ID */
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 租户名称 */
    @Excel(name = "租户名称")
    private String tenantName;

    /** 标识符，产品下唯一 */
    @Excel(name = "标识符")
    private String identifier;

    /** 模型类别（1-属性，2-功能，3-事件） */
    @Excel(name = "模型类别", dictType = "iot_things_type")
    private Integer type;

    /** 数据类型（integer、decimal、string、bool、array、enum） */
    @Excel(name = "数据类型")
    private String datatype;

    /** 数据定义 */
    @Excel(name = "数据定义")
    private String specs;

    /** 是否系统通用（0-否，1-是） */
    @Excel(name = "是否系统通用", dictType = "iot_yes_no")
    private Integer isSys;

    /** 是否首页显示（0-否，1-是） */
    @Excel(name = "是否首页显示", dictType = "iot_yes_no")
    private Integer isTop;

    /** 是否实时监测（0-否，1-是） */
    @Excel(name = "是否实时监测", dictType = "iot_yes_no")
    private Integer isMonitor;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

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
    public void setIsTop(Integer isTop) 
    {
        this.isTop = isTop;
    }

    public Integer getIsTop() 
    {
        return isTop;
    }
    public void setIsMonitor(Integer isMonitor) 
    {
        this.isMonitor = isMonitor;
    }

    public Integer getIsMonitor() 
    {
        return isMonitor;
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
            .append("templateId", getTemplateId())
            .append("templateName", getTemplateName())
            .append("tenantId", getTenantId())
            .append("tenantName", getTenantName())
            .append("identifier", getIdentifier())
            .append("type", getType())
            .append("datatype", getDatatype())
            .append("specs", getSpecs())
            .append("isSys", getIsSys())
            .append("isTop", getIsTop())
            .append("isMonitor", getIsMonitor())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
