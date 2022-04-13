package com.ruoyi.iot.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 新闻资讯对象 news
 * 
 * @author kerwincui
 * @date 2022-04-09
 */
public class News extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 新闻ID */
    private Long newsId;

    /** 标题 */
    @Excel(name = "标题")
    private String title;

    /** 内容 */
    @Excel(name = "内容")
    private String content;

    /** 图片 */
    @Excel(name = "图片")
    private String imgUrl;

    /** 置顶 */
    @Excel(name = "置顶")
    private Integer isTop;

    /** 广告 */
    @Excel(name = "广告")
    private Integer isBanner;

    /** 分类ID */
    @Excel(name = "分类ID")
    private Long categoryId;

    /** 分类名称 */
    @Excel(name = "分类名称")
    private String categoryName;

    /** 发布 */
    @Excel(name = "发布")
    private Integer status;

    /** 作者 */
    @Excel(name = "作者")
    private String author;

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
    public void setTitle(String title) 
    {
        this.title = title;
    }

    public String getTitle() 
    {
        return title;
    }
    public void setContent(String content) 
    {
        this.content = content;
    }

    public String getContent() 
    {
        return content;
    }
    public void setImgUrl(String imgUrl) 
    {
        this.imgUrl = imgUrl;
    }

    public String getImgUrl() 
    {
        return imgUrl;
    }
    public void setIsTop(Integer isTop) 
    {
        this.isTop = isTop;
    }

    public Integer getIsTop() 
    {
        return isTop;
    }
    public void setIsBanner(Integer isBanner) 
    {
        this.isBanner = isBanner;
    }

    public Integer getIsBanner() 
    {
        return isBanner;
    }
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
    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }
    public void setAuthor(String author) 
    {
        this.author = author;
    }

    public String getAuthor() 
    {
        return author;
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
            .append("title", getTitle())
            .append("content", getContent())
            .append("imgUrl", getImgUrl())
            .append("isTop", getIsTop())
            .append("isBanner", getIsBanner())
            .append("categoryId", getCategoryId())
            .append("categoryName", getCategoryName())
            .append("status", getStatus())
            .append("author", getAuthor())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
