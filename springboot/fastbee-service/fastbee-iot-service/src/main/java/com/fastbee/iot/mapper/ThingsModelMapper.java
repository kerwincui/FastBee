package com.fastbee.iot.mapper;

import com.fastbee.common.core.iot.response.IdentityAndName;
import com.fastbee.iot.domain.ThingsModel;
import com.fastbee.iot.model.ThingsModelPerm;
import com.fastbee.iot.model.ThingsModels.ThingsItems;
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
     * 查询单个物模型
     * @param model 物模型
     * @return 单个物模型
     */
    public ThingsModel selectSingleThingsModel(ThingsModel model);

    /**
     * 查询物模型列表
     * 
     * @param thingsModel 物模型
     * @return 物模型集合
     */
    public List<ThingsModel> selectThingsModelList(ThingsModel thingsModel);

    /**
     * 查询物模型对应分享设备权限列表
     *
     * @param productId 产品ID
     * @return 物模型集合
     */
    public List<ThingsModelPerm> selectThingsModelPermList(Long productId);

    /**
     * 查询物模型列表-轮询
     *
     * @param thingsModel 物模型
     * @return 物模型集合
     */
    public List<IdentityAndName> selectThingsModelListCache(ThingsModel thingsModel);

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

    /**
     * 根据产品id删除对应的物模型id
     * @param productId
     * @return
     */
    public int deleteThingsModelByProductId(Long productId);

    /**
     * 查询物模型是否历史存储
     * @param items
     * @return
     */
    public List<IdentityAndName> selectThingsModelIsMonitor(ThingsItems items);

    /**
     * 根据模板id查询从机采集点列表
     *
     * @return 变量模板从机采集点集合
     */
    public List<ThingsModel> selectAllByTemplateId(Long templateId);
}
