package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.IotCategoryMapper;
import com.ruoyi.system.domain.IotCategory;
import com.ruoyi.system.service.IIotCategoryService;

/**
 * 设备分类Service业务层处理
 * 
 * @author kerwincui
 * @date 2021-05-07
 */
@Service
public class IotCategoryServiceImpl implements IIotCategoryService 
{
    @Autowired
    private IotCategoryMapper iotCategoryMapper;

    /**
     * 查询设备分类
     * 
     * @param categoryId 设备分类ID
     * @return 设备分类
     */
    @Override
    public IotCategory selectIotCategoryById(Long categoryId)
    {
        return iotCategoryMapper.selectIotCategoryById(categoryId);
    }

    /**
     * 查询设备分类列表
     * 
     * @param iotCategory 设备分类
     * @return 设备分类
     */
    @Override
    public List<IotCategory> selectIotCategoryList(IotCategory iotCategory)
    {
        return iotCategoryMapper.selectIotCategoryList(iotCategory);
    }

    /**
     * 新增设备分类
     * 
     * @param iotCategory 设备分类
     * @return 结果
     */
    @Override
    public int insertIotCategory(IotCategory iotCategory)
    {
        iotCategory.setCreateTime(DateUtils.getNowDate());
        return iotCategoryMapper.insertIotCategory(iotCategory);
    }

    /**
     * 修改设备分类
     * 
     * @param iotCategory 设备分类
     * @return 结果
     */
    @Override
    public int updateIotCategory(IotCategory iotCategory)
    {
        iotCategory.setUpdateTime(DateUtils.getNowDate());
        return iotCategoryMapper.updateIotCategory(iotCategory);
    }

    /**
     * 批量删除设备分类
     * 
     * @param categoryIds 需要删除的设备分类ID
     * @return 结果
     */
    @Override
    public int deleteIotCategoryByIds(Long[] categoryIds)
    {
        return iotCategoryMapper.deleteIotCategoryByIds(categoryIds);
    }

    /**
     * 删除设备分类信息
     * 
     * @param categoryId 设备分类ID
     * @return 结果
     */
    @Override
    public int deleteIotCategoryById(Long categoryId)
    {
        return iotCategoryMapper.deleteIotCategoryById(categoryId);
    }
}
