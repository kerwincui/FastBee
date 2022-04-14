package com.ruoyi.iot.service;

import java.util.List;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.iot.domain.NewsCategory;
import com.ruoyi.iot.model.IdAndName;

/**
 * 新闻分类Service接口
 * 
 * @author kerwincui
 * @date 2022-04-09
 */
public interface INewsCategoryService 
{
    /**
     * 查询新闻分类
     * 
     * @param categoryId 新闻分类主键
     * @return 新闻分类
     */
    public NewsCategory selectNewsCategoryByCategoryId(Long categoryId);

    /**
     * 查询新闻分类列表
     * 
     * @param newsCategory 新闻分类
     * @return 新闻分类集合
     */
    public List<NewsCategory> selectNewsCategoryList(NewsCategory newsCategory);

    /**
     * 查询新闻分类简短列表
     *
     * @return 新闻分类集合
     */
    public List<IdAndName> selectNewsCategoryShortList();

    /**
     * 新增新闻分类
     * 
     * @param newsCategory 新闻分类
     * @return 结果
     */
    public int insertNewsCategory(NewsCategory newsCategory);

    /**
     * 修改新闻分类
     * 
     * @param newsCategory 新闻分类
     * @return 结果
     */
    public int updateNewsCategory(NewsCategory newsCategory);

    /**
     * 批量删除新闻分类
     * 
     * @param categoryIds 需要删除的新闻分类主键集合
     * @return 结果
     */
    public AjaxResult deleteNewsCategoryByCategoryIds(Long[] categoryIds);

    /**
     * 删除新闻分类信息
     * 
     * @param categoryId 新闻分类主键
     * @return 结果
     */
    public int deleteNewsCategoryByCategoryId(Long categoryId);
}
