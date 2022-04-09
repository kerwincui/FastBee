package com.ruoyi.news.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

import java.util.List;

/**
 * 新闻对象 news
 * 
 * @author kerwincui
 * @date 2022-04-07
 */
public class News extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 新闻ID */
    private Long newsId;

    /** 新闻标题 */
    @Excel(name = "新闻标题")
    private String newsName;

    /** 新闻内容 */
    @Excel(name = "新闻内容")
    private String newsContent;

    /** 新闻封面 */
    @Excel(name = "新闻封面")
    private String newsCover;

    /** 是否置顶 */
    @Excel(name = "是否置顶")
    private String newsIsTop;

    /** 是否banner */
    @Excel(name = "是否banner")
    private String newsIsBanner;

    /** 分类ID */
    @Excel(name = "分类ID")
    private List<Long> classifyId;

    /** 分类ID */
    @Excel(name = "分类ID")
    private Long classifyIds;

    /** 分类名称 */
    @Excel(name = "分类名称")
    private String classifyName;

    /** 新闻状态（0正常 1停用） */
    @Excel(name = "新闻状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    public void setNewsId(Long newsId) 
    {
        this.newsId = newsId;
    }

    public Long getNewsId() 
    {
        return newsId;
    }
    public void setNewsName(String newsName) 
    {
        this.newsName = newsName;
    }

    public String getNewsName() 
    {
        return newsName;
    }
    public void setNewsContent(String newsContent) 
    {
        this.newsContent = newsContent;
    }

    public String getNewsContent() 
    {
        return newsContent;
    }
    public void setNewsCover(String newsCover) 
    {
        this.newsCover = newsCover;
    }

    public String getNewsCover() 
    {
        return newsCover;
    }
    public void setNewsIsTop(String newsIsTop) 
    {
        this.newsIsTop = newsIsTop;
    }

    public String getNewsIsTop() 
    {
        return newsIsTop;
    }
    public void setNewsIsBanner(String newsIsBanner) 
    {
        this.newsIsBanner = newsIsBanner;
    }

    public String getNewsIsBanner() 
    {
        return newsIsBanner;
    }

    public List<Long> getClassifyId() {
        return classifyId;
    }

    public Long getClassifyIds() {
        return classifyIds;
    }

    public void setClassifyIds(Long classifyIds) {
        this.classifyIds = classifyIds;
    }

    public void setClassifyId(List<Long> classifyId) {
        this.classifyId = classifyId;
    }

    public void setClassifyName(String classifyName)
    {
        this.classifyName = classifyName;
    }

    public String getClassifyName() 
    {
        return classifyName;
    }
    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
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
            .append("newsId", getNewsId())
            .append("newsName", getNewsName())
            .append("newsContent", getNewsContent())
            .append("newsCover", getNewsCover())
            .append("newsIsTop", getNewsIsTop())
            .append("newsIsBanner", getNewsIsBanner())
            .append("classifyId", getClassifyId())
            .append("classifyName", getClassifyName())
            .append("status", getStatus())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
