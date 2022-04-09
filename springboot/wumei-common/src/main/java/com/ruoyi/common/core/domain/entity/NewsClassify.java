package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 新闻分类对象 news_classify
 * 
 * @author kerwincui
 * @date 2022-04-07
 */
public class NewsClassify extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 分类ID */
    private Long classifyId;

    /** 分类名字 */
    @Excel(name = "分类名字")
    private String classifyName;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    /** 分类状态（0正常 1停用） */
    @Excel(name = "分类状态", readConverterExp = "0=正常,1=停用")
    private String status;

    public void setClassifyId(Long classifyId) 
    {
        this.classifyId = classifyId;
    }

    public Long getClassifyId() 
    {
        return classifyId;
    }
    public void setClassifyName(String classifyName) 
    {
        this.classifyName = classifyName;
    }

    public String getClassifyName() 
    {
        return classifyName;
    }
    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }
    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("classifyId", getClassifyId())
            .append("classifyName", getClassifyName())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .append("status", getStatus())
            .toString();
    }
}
