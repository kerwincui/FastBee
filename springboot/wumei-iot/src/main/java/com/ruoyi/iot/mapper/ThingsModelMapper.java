package com.ruoyi.iot.mapper;

import com.ruoyi.iot.domain.ThingsModel;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 物模型Mapper接口
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@Repository
public interface ThingsModelMapper 
{
    /**
     * 查询物模型
     * 
     * @param modelId 物模型主键
     * @return 物模型
     */
    public ThingsModel selectThingsModelByModelId(Long modelId);

    /**
     * 查询物模型列表
     * 
     * @param thingsModel 物模型
     * @return 物模型集合
     */
    public List<ThingsModel> selectThingsModelList(ThingsModel thingsModel);

    /**
     * 根据产品ID数组获取物模型列表
     * @param modelIds
     * @return
     */
    public List<ThingsModel> selectThingsModelListByProductIds(Long[] modelIds);

    /**
     * 新增物模型
     * 
     * @param thingsModel 物模型
     * @return 结果
     */
    public int insertThingsModel(ThingsModel thingsModel);

    /**
     * 批量新增物模型
     * @param thingsModels
     * @return
     */
    public int insertBatchThingsModel(List<ThingsModel> thingsModels);

    /**
     * 修改物模型
     * 
     * @param thingsModel 物模型
     * @return 结果
     */
    public int updateThingsModel(ThingsModel thingsModel);

    /**
     * 删除物模型
     * 
     * @param modelId 物模型主键
     * @return 结果
     */
    public int deleteThingsModelByModelId(Long modelId);

    /**
     * 批量删除物模型
     * 
     * @param modelIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteThingsModelByModelIds(Long[] modelIds);
}
