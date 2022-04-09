package com.ruoyi.news.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 新闻分类对象 news_and_classify
 * 
 * @author kerwincui
 * @date 2022-04-08
 */
public class NewsAndClassify extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 新闻ID */
    @Excel(name = "新闻ID")
    private Long newId;

    /** 分类ID */
    @Excel(name = "分类ID")
    private Long classifyId;

    public void setNewId(Long newId)
    {
        this.newId = newId;
    }

    public Long getNewId()
    {
        return newId;
    }
    public void setClassifyId(Long classifyId)
    {
        this.classifyId = classifyId;
    }

    public Long getClassifyId()
    {
        return classifyId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("newId", getNewId())
            .append("classifyId", getClassifyId())
            .toString();
    }
}
