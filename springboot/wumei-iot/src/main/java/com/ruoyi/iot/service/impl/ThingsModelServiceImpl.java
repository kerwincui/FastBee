package com.ruoyi.iot.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.iot.domain.Product;
import com.ruoyi.iot.domain.ThingsModelTemplate;
import com.ruoyi.iot.mapper.ProductMapper;
import com.ruoyi.iot.mapper.ThingsModelTemplateMapper;
import com.ruoyi.iot.model.ImportThingsModelInput;
import com.ruoyi.iot.model.ThingsModels.EventDto;
import com.ruoyi.iot.model.ThingsModels.FunctionDto;
import com.ruoyi.iot.model.ThingsModels.PropertyDto;
import com.ruoyi.iot.model.ThingsModels.ThingsModelsDto;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.iot.mapper.ThingsModelMapper;
import com.ruoyi.iot.domain.ThingsModel;
import com.ruoyi.iot.service.IThingsModelService;

import static com.ruoyi.common.utils.SecurityUtils.getLoginUser;

/**
 * 物模型Service业务层处理
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@Service
public class ThingsModelServiceImpl implements IThingsModelService 
{
    private String tslPreKey ="things_model:tsl";

    @Autowired
    private ThingsModelMapper thingsModelMapper;

    @Autowired
    private ThingsModelTemplateMapper thingsModelTemplateMapper;

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private RedisCache redisCache;

    /**
     * 查询物模型
     * 
     * @param modelId 物模型主键
     * @return 物模型
     */
    @Override
    public ThingsModel selectThingsModelByModelId(Long modelId)
    {
        return thingsModelMapper.selectThingsModelByModelId(modelId);
    }

    /**
     * 查询物模型列表
     * 
     * @param thingsModel 物模型
     * @return 物模型
     */
    @Override
    public List<ThingsModel> selectThingsModelList(ThingsModel thingsModel)
    {
        return thingsModelMapper.selectThingsModelList(thingsModel);
    }

    /**
     * 新增物模型
     * 
     * @param thingsModel 物模型
     * @return 结果
     */
    @Override
    public int insertThingsModel(ThingsModel thingsModel)
    {
        // 物模型标识符不能重复 TODO 重复查询待优化
        ThingsModel input=new ThingsModel();
        input.setProductId(thingsModel.getProductId());
        List<ThingsModel> list=thingsModelMapper.selectThingsModelList(input);
        Boolean isRepeat=list.stream().anyMatch(x->x.getIdentifier().equals(thingsModel.getIdentifier()));
        if(!isRepeat) {
            SysUser user = getLoginUser().getUser();
            thingsModel.setTenantId(user.getUserId());
            thingsModel.setTenantName(user.getUserName());
            thingsModel.setCreateTime(DateUtils.getNowDate());
            int result = thingsModelMapper.insertThingsModel(thingsModel);
            // 更新redis缓存
            setCacheThingsModelByProductId(thingsModel.getProductId());
            return result;
        }
        return 2;
    }

    /**
     * 导入通用物模型
     * @param input
     * @return
     */
    @Override
    public int importByTemplateIds(ImportThingsModelInput input){
        // 物模型标识符不能重复 TODO 重复查询待优化
        ThingsModel inputParameter=new ThingsModel();
        inputParameter.setProductId(input.getProductId());
        List<ThingsModel> dbList=thingsModelMapper.selectThingsModelList(inputParameter);

        SysUser user = getLoginUser().getUser();
        // 根据ID集合获取通用物模型列表
        List<ThingsModelTemplate> templateList=thingsModelTemplateMapper.selectThingsModelTemplateByTemplateIds(input.getTemplateIds());
        //转换为产品物模型，并批量插入
        List<ThingsModel> list=new ArrayList<>();
        int repeatCount=0;
        for(ThingsModelTemplate template : templateList){
            ThingsModel thingsModel= new ThingsModel();
            BeanUtils.copyProperties(template,thingsModel);
            thingsModel.setTenantId(user.getUserId());
            thingsModel.setTenantName(user.getUserName());
            thingsModel.setCreateTime(DateUtils.getNowDate());
            thingsModel.setProductId(input.getProductId());
            thingsModel.setProductName(input.getProductName());
            thingsModel.setModelId(template.getTemplateId());
            thingsModel.setModelName(template.getTemplateName());
            Boolean isRepeat=dbList.stream().anyMatch(x->x.getIdentifier().equals(thingsModel.getIdentifier()));
            if(isRepeat){
                repeatCount=repeatCount+1;
            }else{
                list.add(thingsModel);
            }
        }
        if(list.size()>0) {
            thingsModelMapper.insertBatchThingsModel(list);
            //更新redis缓存
            setCacheThingsModelByProductId(input.getProductId());
        }
        return repeatCount;
    }

    /**
     * 修改物模型
     * 
     * @param thingsModel 物模型
     * @return 结果
     */
    @Override
    public int updateThingsModel(ThingsModel thingsModel)
    {
        // 物模型标识符不能重复 TODO 重复查询待优化
        ThingsModel input=new ThingsModel();
        input.setProductId(thingsModel.getProductId());
        List<ThingsModel> list=thingsModelMapper.selectThingsModelList(input);
        Boolean isRepeat=list.stream().anyMatch(x->x.getIdentifier().equals(thingsModel.getIdentifier()) && x.getModelId().longValue()!=thingsModel.getModelId());
        if(!isRepeat) {
            thingsModel.setUpdateTime(DateUtils.getNowDate());
            int result = thingsModelMapper.updateThingsModel(thingsModel);
            // 更新redis缓存
            setCacheThingsModelByProductId(thingsModel.getProductId());
            return result;
        }
        return 2;
    }

    /**
     * 批量删除物模型
     * 
     * @param modelIds 需要删除的物模型主键
     * @return 结果
     */
    @Override
    public int deleteThingsModelByModelIds(Long[] modelIds)
    {
        ThingsModel thingsModel=thingsModelMapper.selectThingsModelByModelId(modelIds[0]);
        int result=thingsModelMapper.deleteThingsModelByModelIds(modelIds);
        // 更新redis缓存
        setCacheThingsModelByProductId(thingsModel.getProductId());

        return result;
    }

    /**
     * 删除物模型信息
     * 
     * @param modelId 物模型主键
     * @return 结果
     */
    @Override
    public int deleteThingsModelByModelId(Long modelId)
    {
        ThingsModel thingsModel=thingsModelMapper.selectThingsModelByModelId(modelId);
        int result=thingsModelMapper.deleteThingsModelByModelId(modelId);
        // 更新redis缓存
        setCacheThingsModelByProductId(thingsModel.getProductId());
        return result;
    }

    /**
     * 根据产品ID获取JSON物模型
     * @param productId
     * @return
     */
    @Override
    public String getCacheThingsModelByProductId(Long productId){
        // redis获取物模型
        String thingsModelJson = redisCache.getCacheObject(tslPreKey +productId);
        if (thingsModelJson != null){
            return thingsModelJson;
        }
        return setCacheThingsModelByProductId(productId);
    }

    /**
     * 根据产品ID更新JSON物模型
     * @param productId
     * @return
     */
    private String setCacheThingsModelByProductId(Long productId){
        // 数据库查询物模型集合
        ThingsModel model=new ThingsModel();
        model.setProductId(productId);
        List<ThingsModel> thingsModels=thingsModelMapper.selectThingsModelList(model);
        // 转换为物模型
        ThingsModelsDto thingsModelsDto=new ThingsModelsDto();
        for(int i=0;i<thingsModels.size();i++){
            if(thingsModels.get(i).getType()==1){
                // 属性
                PropertyDto propertyDto=new PropertyDto();
                propertyDto.setId(thingsModels.get(i).getIdentifier());
                propertyDto.setName(thingsModels.get(i).getModelName());
                propertyDto.setIsMonitor(thingsModels.get(i).getIsMonitor());
                propertyDto.setIsTop(thingsModels.get(i).getIsTop());
                propertyDto.setDatatype(JSONObject.parseObject(thingsModels.get(i).getSpecs()));
                thingsModelsDto.getProperties().add(propertyDto);
            }else if(thingsModels.get(i).getType()==2){
                // 功能
                FunctionDto functionDto=new FunctionDto();
                functionDto.setId(thingsModels.get(i).getIdentifier());
                functionDto.setName(thingsModels.get(i).getModelName());
                functionDto.setIsTop(thingsModels.get(i).getIsTop());
                functionDto.setDatatype(JSONObject.parseObject(thingsModels.get(i).getSpecs()));
                thingsModelsDto.getFunctions().add(functionDto);
            }else if(thingsModels.get(i).getType()==3){
                // 事件
                EventDto eventDto=new EventDto();
                eventDto.setId(thingsModels.get(i).getIdentifier());
                eventDto.setName(thingsModels.get(i).getModelName());
                eventDto.setDatatype(JSONObject.parseObject(thingsModels.get(i).getSpecs()));
                thingsModelsDto.getEvents().add(eventDto);
            }
        }
        JSONObject tslObject= (JSONObject) JSONObject.toJSON(thingsModelsDto);
        redisCache.setCacheObject(tslPreKey +productId,tslObject.toJSONString());
        Product product=new Product();
        product.setProductId(productId);
        product.setThingsModelsJson(tslObject.toJSONString());
        productMapper.updateThingsModelJson(product);
        return tslObject.toJSONString();
    }
}
