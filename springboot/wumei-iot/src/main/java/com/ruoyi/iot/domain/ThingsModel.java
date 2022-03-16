package com.ruoyi.iot.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 物模型对象 iot_things_model
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class ThingsModel extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 物模型ID */
    private Long modelId;

    /** 物模型名称 */
    @Excel(name = "物模型名称")
    private String modelName;

    /** 产品ID */
    @Excel(name = "产品ID")
    private Long productId;

    /** 产品名称 */
    @Excel(name = "产品名称")
    private String productName;

    /** 租户ID */
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 租户名称 */
    @Excel(name = "租户名称")
    private String tenantName;

    /** 标识符，产品下唯一 */
    @Excel(name = "标识符，产品下唯一")
    private String identifier;

    /** 模型类别（1-属性，2-功能，3-事件） */
    @Excel(name = "模型类别", readConverterExp = "1=-属性，2-功能，3-事件，4-属性和功能")
    private Integer type;

    /** 数据类型（integer、decimal、string、bool、array、enum） */
    @Excel(name = "数据类型", readConverterExp = "i=nteger、decimal、string、bool、array、enum")
    private String datatype;

    /** 数据定义 */
    @Excel(name = "数据定义")
    private String specs;

    /** 是否首页显示（0-否，1-是） */
    @Excel(name = "是否首页显示", readConverterExp = "0=-否，1-是")
    private Integer isTop;

    /** 是否实时监测（0-否，1-是） */
    @Excel(name = "是否实时监测", readConverterExp = "0=-否，1-是")
    private Integer isMonitor;

    public void setModelId(Long modelId) 
    {
        this.modelId = modelId;
    }

    public Long getModelId() 
    {
        return modelId;
    }
    public void setModelName(String modelName) 
    {
        this.modelName = modelName;
    }

    public String getModelName() 
    {
        return modelName;
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

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("modelId", getModelId())
            .append("modelName", getModelName())
            .append("productId", getProductId())
            .append("productName", getProductName())
            .append("tenantId", getTenantId())
            .append("tenantName", getTenantName())
            .append("identifier", getIdentifier())
            .append("type", getType())
            .append("datatype", getDatatype())
            .append("specs", getSpecs())
            .append("isTop", getIsTop())
            .append("isMonitor", getIsMonitor())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
