package com.ruoyi.iot.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;

/**
 * 产品分类对象 iot_category
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class Category extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 产品分类ID */
    private Long categoryId;

    /** 产品分类名称 */
    @Excel(name = "产品分类名称")
    private String categoryName;

    /** 租户ID */
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 租户名称 */
    @Excel(name = "租户名称")
    private String tenantName;

    /** 是否系统通用（0-否，1-是） */
    @Excel(name = "是否系统通用", readConverterExp = "0=-否，1-是")
    private Integer isSys;

    /** 显示顺序 */
    @Excel(name = "显示顺序")
    private Integer orderNum;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    public void setCategoryId(Long categoryId) 
    {
        this.categoryId = categoryId;
    }

    public Long getCategoryId() 
    {
        return categoryId;
    }
    public void setCategoryName(String categoryName) 
    {
        this.categoryName = categoryName;
    }

    public String getCategoryName() 
    {
        return categoryName;
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
    public void setIsSys(Integer isSys) 
    {
        this.isSys = isSys;
    }
    public Integer getIsSys() 
    {
        return isSys;
    }

    public void setOrderNum(Integer orderNum)
    {
        this.orderNum = orderNum;
    }
    public Integer getOrderNum()
    {
        return orderNum;
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
            .append("categoryId", getCategoryId())
            .append("categoryName", getCategoryName())
            .append("tenantId", getTenantId())
            .append("tenantName", getTenantName())
            .append("isSys", getIsSys())
            .append("orderNum", getOrderNum())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
