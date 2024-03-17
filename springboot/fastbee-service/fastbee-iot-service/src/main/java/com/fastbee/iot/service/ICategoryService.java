package com.fastbee.iot.service;

import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.iot.domain.Category;
import com.fastbee.iot.model.IdAndName;

import java.util.List;

/**
 * 产品分类Service接口
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public interface ICategoryService 
{
    /**
     * 查询产品分类
     * 
     * @param categoryId 产品分类主键
     * @return 产品分类
     */
    public Category selectCategoryByCategoryId(Long categoryId);

    /**
     * 查询产品分类列表
     * 
     * @param category 产品分类
     * @return 产品分类集合
     */
    public List<Category> selectCategoryList(Category category);

    /**
     * 查询产品简短分类列表
     *
     * @return 产品分类集合
     */
    public List<IdAndName> selectCategoryShortList();

    /**
     * 新增产品分类
     * 
     * @param category 产品分类
     * @return 结果
     */
    public int insertCategory(Category category);

    /**
     * 修改产品分类
     * 
     * @param category 产品分类
     * @return 结果
     */
    public int updateCategory(Category category);

    /**
     * 批量删除产品分类
     * 
     * @param categoryIds 需要删除的产品分类主键集合
     * @return 结果
     */
    public AjaxResult deleteCategoryByCategoryIds(Long[] categoryIds);

    /**
     * 删除产品分类信息
     * 
     * @param categoryId 产品分类主键
     * @return 结果
     */
    public int deleteCategoryByCategoryId(Long categoryId);

}
