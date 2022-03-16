package com.ruoyi.iot.service;

import java.util.List;
import com.ruoyi.iot.domain.ThingsModel;
import com.ruoyi.iot.model.ImportThingsModelInput;

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
     * 查询物模型列表
     * 
     * @param thingsModel 物模型
     * @return 物模型集合
     */
    public List<ThingsModel> selectThingsModelList(ThingsModel thingsModel);

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
}
