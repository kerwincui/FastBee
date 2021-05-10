package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.IotCategory;

/**
 * 设备分类Mapper接口
 * 
 * @author kerwincui
 * @date 2021-05-07
 */
public interface IotCategoryMapper 
{
    /**
     * 查询设备分类
     * 
     * @param categoryId 设备分类ID
     * @return 设备分类
     */
    public IotCategory selectIotCategoryById(Long categoryId);

    /**
     * 查询设备分类列表
     * 
     * @param iotCategory 设备分类
     * @return 设备分类集合
     */
    public List<IotCategory> selectIotCategoryList(IotCategory iotCategory);

    /**
     * 新增设备分类
     * 
     * @param iotCategory 设备分类
     * @return 结果
     */
    public int insertIotCategory(IotCategory iotCategory);

    /**
     * 修改设备分类
     * 
     * @param iotCategory 设备分类
     * @return 结果
     */
    public int updateIotCategory(IotCategory iotCategory);

    /**
     * 删除设备分类
     * 
     * @param categoryId 设备分类ID
     * @return 结果
     */
    public int deleteIotCategoryById(Long categoryId);

    /**
     * 批量删除设备分类
     * 
     * @param categoryIds 需要删除的数据ID
     * @return 结果
     */
    public int deleteIotCategoryByIds(Long[] categoryIds);
}
