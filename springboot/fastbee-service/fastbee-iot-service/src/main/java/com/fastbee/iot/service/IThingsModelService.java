package com.fastbee.iot.service;

import com.fastbee.common.core.iot.response.IdentityAndName;
import com.fastbee.iot.domain.ThingsModel;
import com.fastbee.iot.model.ImportThingsModelInput;
import com.fastbee.iot.model.ThingsModelPerm;
import com.fastbee.iot.model.ThingsModels.PropertyDto;
import com.fastbee.iot.model.ThingsModels.ThingsItems;

import java.util.List;
import java.util.Map;

/**
 * 物模型Service接口
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public interface IThingsModelService 
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
     * 查询物模型对应设备分享用户权限列表
     *
     * @param productId 产品ID
     */
    public List<ThingsModelPerm> selectThingsModelPermList(Long productId);

    /**
     * 查询物模型列表-轮询使用
     *
     * @param thingsModel 物模型
     * @return 物模型集合
     */
    public Map<Integer, List<IdentityAndName>> selectThingsModelListCache(ThingsModel thingsModel);

    /**
     * 新增物模型
     * 
     * @param thingsModel 物模型
     * @return 结果
     */
    public int insertThingsModel(ThingsModel thingsModel);

    /**
     * 从模板导入物模型
     * @param input
     * @return
     */
    public int importByTemplateIds(ImportThingsModelInput input);

    /**
     * 修改物模型
     * 
     * @param thingsModel 物模型
     * @return 结果
     */
    public int updateThingsModel(ThingsModel thingsModel);

    /**
     * 批量删除物模型
     * 
     * @param modelIds 需要删除的物模型主键集合
     * @return 结果
     */
    public int deleteThingsModelByModelIds(Long[] modelIds);

    /**
     * 删除物模型信息
     * 
     * @param modelId 物模型主键
     * @return 结果
     */
    public int deleteThingsModelByModelId(Long modelId);

    /**
     * 根据产品ID获取JSON物模型
     * @param productId
     * @return
     */
    public String getCacheThingsModelByProductId(Long productId);


    /**
     * 获取单个物模型获取
     * @param productId
     * @param identify
     * @return
     */
    public PropertyDto getSingleThingModels(Long productId, String identify);


    /**
     * 批量查询产品的缓存物模型
     * @param productIds
     * @return
     */
    public Map<String, String> getBatchCacheThingsModelByProductIds(Long[] productIds);

    /**
     * 导入采集点数据
     * @param lists 数据列表
     * @param tempSlaveId 从机编码
     * @return 结果
     */
    public String importData(List<ThingsModel> lists,Integer tempSlaveId);

    /**
     * 根据模板id查询从机采集点列表
     *
     * @return 变量模板从机采集点集合
     */
    public List<ThingsModel> selectAllByTemplateId(Long templateId);

    /**
     * 根据产品id删除 产品物模型以及物模型缓存
     * @param productId
     */
    public void deleteProductThingsModelAndCacheByProductId(Long productId);

    /**
     * 同步采集点模板
     * @param productIds
     */
    public void synchronizeVarTempToProduct(List<Long> productIds,Long templateId);


}
