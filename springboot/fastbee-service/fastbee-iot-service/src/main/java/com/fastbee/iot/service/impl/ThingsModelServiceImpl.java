package com.fastbee.iot.service.impl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.core.iot.response.IdentityAndName;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.core.redis.RedisKeyBuilder;
import com.fastbee.common.enums.ThingsModelType;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.iot.domain.Product;
import com.fastbee.iot.domain.ThingsModel;
import com.fastbee.iot.domain.ThingsModelTemplate;
import com.fastbee.iot.mapper.ProductMapper;
import com.fastbee.iot.mapper.ThingsModelMapper;
import com.fastbee.iot.mapper.ThingsModelTemplateMapper;
import com.fastbee.iot.model.ImportThingsModelInput;
import com.fastbee.iot.model.ThingsModelPerm;
import com.fastbee.iot.model.ThingsModels.PropertyDto;
import com.fastbee.iot.model.varTemp.EnumClass;
import com.fastbee.iot.service.IThingsModelService;
import com.fastbee.iot.service.IThingsModelTemplateService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

import static com.fastbee.common.utils.SecurityUtils.getLoginUser;

/**
 * 物模型Service业务层处理
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Service
@Slf4j
public class ThingsModelServiceImpl implements IThingsModelService {

    @Autowired
    private ThingsModelMapper thingsModelMapper;

    @Autowired
    private ThingsModelTemplateMapper thingsModelTemplateMapper;

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private RedisCache redisCache;
    @Resource
    private IThingsModelTemplateService modelTemplateService;

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
     * 查询单个物模型
     * @param model 物模型
     * @return 单个物模型
     */
    @Override
    public ThingsModel selectSingleThingsModel(ThingsModel model){
        return thingsModelMapper.selectSingleThingsModel(model);
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
     * 查询物模型对应分享设备用户权限列表
     *
     * @param productId 产品编号
     * @return 物模型
     */
    @Override
    public List<ThingsModelPerm> selectThingsModelPermList(Long productId)
    {
        return thingsModelMapper.selectThingsModelPermList(productId);
    }

    /**
     * 查询物模型列表-轮询使用
     *
     * @param thingsModel 物模型
     * @return 物模型集合
     */
    @Override
    public Map<Integer, List<IdentityAndName>> selectThingsModelListCache(ThingsModel thingsModel){
        String cacheThingsModel = this.getCacheThingsModelByProductId(thingsModel.getProductId());
        if (StringUtils.isEmpty(cacheThingsModel)){
            List<IdentityAndName> results = thingsModelMapper.selectThingsModelListCache(thingsModel);
            return  results.stream().collect(Collectors.groupingBy(IdentityAndName::getTempSlaveId));

        }
        Map<String, Object> cacheMap = redisCache.getCacheMap(RedisKeyBuilder.buildTSLCacheKey(thingsModel.getProductId()));
        return cacheMap.values().stream().map(v -> JSON.parseObject(v.toString(), IdentityAndName.class))
                .filter(item -> StringUtils.isNotEmpty(item.getId()))
                .sorted((o1,o2) -> {
                    Integer num1 = Integer.parseInt(o1.getId());
                    Integer num2 = Integer.parseInt(o2.getId());
                    return  num1.compareTo(num2);
                })
                .collect(Collectors.groupingBy(IdentityAndName::getTempSlaveId));
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
            thingsModel.setIsReadonly(template.getIsReadonly());
            thingsModel.setIsMonitor(template.getIsMonitor());
            thingsModel.setIsChart(template.getIsChart());
            thingsModel.setIsSharePerm(template.getIsSharePerm());
            thingsModel.setIsHistory(template.getIsHistory());
            thingsModel.setModelOrder(template.getModelOrder());
            //兼容modbsu
            if (StringUtils.isNotEmpty(template.getTempSlaveId())){
                thingsModel.setTempSlaveId(Integer.parseInt(template.getTempSlaveId().split("#")[1]));
            }
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
     *
     * @param productId
     * @return
     */
    @Override
    public String getCacheThingsModelByProductId(Long productId){
        if (productId == null) {
            throw new ServiceException("产品id为空");
        }
        // redis获取物模型
        Map<String, Object> map = redisCache.getCacheMap(RedisKeyBuilder.buildTSLCacheKey(productId));
        if (!CollectionUtils.isEmpty(map)) {
            //兼容原页面物模型的数据格式
            Map<String, List<PropertyDto>> listMap = map.values().stream().map(v -> JSON.parseObject(v.toString(), PropertyDto.class))
                    .collect(Collectors.groupingBy(dto -> ThingsModelType.getName(dto.getType())));
            return JSON.toJSONString(listMap);
        }
        return setCacheThingsModelByProductId(productId);
    }


    /**
     * 获取单个物模型获取
     * @param productId
     * @param identify
     * @return
     */
    @Override
    public PropertyDto getSingleThingModels(Long productId, String identify){
        PropertyDto dto = new PropertyDto();
        String cacheKey = RedisKeyBuilder.buildTSLCacheKey(productId);
        String value = redisCache.getCacheMapValue(cacheKey, identify);
        //缓存没有则先查询数据库
        if (StringUtils.isEmpty(value)){
            ThingsModel thingsModel = new ThingsModel();
            if (identify.contains("#")){
                String[] split = identify.split("#");
                identify = split[0];
                thingsModel.setTempSlaveId(Integer.parseInt(split[1]));
            }
            thingsModel.setIdentifier(identify);
            thingsModel.setProductId(productId);
            ThingsModel selectModel = this.selectSingleThingsModel(thingsModel);
            // redis和数据库都没有则是对象或数组类型。 兼容对象类型和数组类型
            if (StringUtils.isNull(dto.getId()) && identify.contains("_")){
                String[] split = identify.split("_");
                String thingsM = redisCache.getCacheMapValue(cacheKey, split[0]);
                PropertyDto subDto = JSON.parseObject(thingsM, PropertyDto.class);
                JSONArray array = JSON.parseArray(String.valueOf(subDto.getDatatype().get("params")));
                String finalIdentify = identify;
                PropertyDto propertyDto = array.toJavaList(PropertyDto.class).stream()
                        .filter(x -> x.getId().equals(finalIdentify))
                        .findFirst().get();
                propertyDto.setType(subDto.getType());
                return propertyDto;
            }
            if (null == selectModel) {
                return dto;
            }
            BeanUtils.copyProperties(selectModel,dto);
            dto.setId(selectModel.getIdentifier());
            dto.setName(selectModel.getModelName());
            dto.setIsParams(selectModel.getIsParams());
            dto.setDatatype(JSON.parseObject(selectModel.getSpecs()));
            dto.setOrder(selectModel.getModelOrder());
            dto.setFormula(selectModel.getFormula());
            dto.setTempSlaveId(selectModel.getTempSlaveId());
            this.setCacheThingsModelByProductId(productId);
        }else {
           dto = JSON.parseObject(value, PropertyDto.class);
        }
        return dto;
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
        /*这里key 1.非modbus为 identify  2. 是modbus设备时使用 identify#设备编号*/
        Map<String, String> things = thingsModels.stream().collect(Collectors.toMap(key -> {
                    return key.getIdentifier() + (key.getTempSlaveId() == null ? "" : "#" + key.getTempSlaveId());
                },
                value -> {
                    //转换数据，减少不必要数据
                    PropertyDto dto = new PropertyDto();
                    BeanUtils.copyProperties(value,dto);
                    dto.setDatatype(JSONObject.parseObject(value.getSpecs()));
                    dto.setId(value.getIdentifier());
                    dto.setRegId(value.getIdentifier()+ (value.getTempSlaveId() == null ? "" : "#" +value.getTempSlaveId()));
                    dto.setName(value.getModelName());
                    dto.setOrder(value.getModelOrder());
                    dto.setQuantity(value.getQuantity());
                    dto.setCode(value.getCode());
                    return JSONObject.toJSONString(dto);
                }));

        /*缓存到redis*/
        String cacheKey = RedisKeyBuilder.buildTSLCacheKey(productId);
        //先删除缓存
        if ( redisCache.containsKey(cacheKey)){
            redisCache.deleteObject(cacheKey);
        }
        redisCache.hashPutAll(cacheKey, things);
        /*组装成原格式数据*/
        Map<String, List<PropertyDto>> result = things.values().stream().map(x -> JSON.parseObject(x, PropertyDto.class))
                .collect(Collectors.groupingBy(dto -> ThingsModelType.getName(dto.getType())));
        String jsonString = JSON.toJSONString(result);
        Product product = new Product();
        product.setProductId(productId);
        product.setThingsModelsJson(jsonString);
        productMapper.updateThingsModelJson(product);
        return jsonString;
    }

    /**
     * 批量查询产品的缓存物模型 --方法未使用，物模型结构暂不更改
     *
     * @param productIds
     * @return
     */
    @Override
    public Map<String, String> getBatchCacheThingsModelByProductIds(Long[] productIds) {
        // 批量查询hkey和value
        Set<String> set = new HashSet<>();
        for (int i = 0; i < productIds.length; i++) {
            set.add(RedisKeyBuilder.buildTSLCacheKey(productIds[i]));
        }
        Map<String, String> map = redisCache.getStringAllByKeys(set);
        // 如果redis键和设备不匹配，添加redis缓存
        if (map == null || map.size() != productIds.length) {
            for (int i = 0; i < productIds.length; i++) {
                String key = RedisKeyBuilder.buildTSLCacheKey(productIds[i]);
                if (map.get(key) != null) {
                    continue;
                } else {
                    map.put(key, setCacheThingsModelByProductId(productIds[i]));
                }
            }
        }
        return map;
    }

    /**
     * 导入采集点数据
     *
     * @param lists       数据列表
     * @param tempSlaveId 从机编码
     * @return 结果
     */
    public String importData(List<ThingsModel> lists, Integer tempSlaveId) {
        if (null == tempSlaveId || CollectionUtils.isEmpty(lists)) {
            throw new ServiceException("导入数据异常");
        }
        int success = 0;
        int failure = 0;
        StringBuilder succSb = new StringBuilder();
        StringBuilder failSb = new StringBuilder();

        for (ThingsModel model : lists) {
            try {
                //如果标识符为空，使用寄存器地址作为标识符
                if (null == model.getIdentifier() || "".equals(model.getIdentifier())) {
                    model.setIdentifier(model.getRegStr());
                }
                /*16进制*/
                String reg = model.getRegStr();
                if (reg.endsWith("H")) {
                    String hex = reg.replace("H", "");
                    int address = Integer.parseInt(hex, 16);
                    model.setRegAddr(address);
                }
                model.setTempSlaveId(tempSlaveId);
                //处理数据定义
                this.parseSpecs(model);
                this.insertThingsModel(model);
                success++;
                succSb.append("<br/>").append(success).append(",采集点: ").append(model.getModelName());
            } catch (Exception e) {
                log.error("导入错误：", e);
                failure++;
                failSb.append("<br/>").append(failure).append(",采集点: ").append(model.getModelName()).append("导入失败");
            }
        }
        if (failure > 0) {
            throw new ServiceException(failSb.toString());
        }
        return succSb.toString();
    }

    private void parseSpecs(ThingsModel model) {
        JSONObject specs = new JSONObject();
        String datatype = model.getDatatype();
        String limitValue = model.getLimitValue();
        if (limitValue != null && !"".equals(limitValue)) {
            String[] values = limitValue.split("/");
            switch (datatype) {
                case "integer":
                    specs.put("max", values[1]);
                    specs.put("min", values[0]);
                    specs.put("type", datatype);
                    specs.put("unit", model.getUnit());
                    specs.put("step", 0);
                    break;
                case "bool":
                    specs.put("type", datatype);
                    specs.put("trueText", values[1]);
                    specs.put("falseText", values[0]);
                    break;
                case "enum":
                    List<EnumClass> list = new ArrayList<>();
                    for (String value : values) {
                        String[] params = value.split(":");
                        EnumClass enumCls = new EnumClass();
                        enumCls.setText(params[1]);
                        enumCls.setValue(params[0]);
                        list.add(enumCls);
                    }
                    specs.put("type", datatype);
                    specs.put("enumList", list);
                    break;
            }
            model.setSpecs(specs.toJSONString());
        }
    }

    /**
     * 根据模板id查询从机采集点列表
     *
     * @return 变量模板从机采集点集合
     */
    @Override
    public List<ThingsModel> selectAllByTemplateId(Long templateId) {
        return thingsModelMapper.selectAllByTemplateId(templateId);
    }

    /**
     * 根据产品id删除 产品物模型以及物模型缓存
     * @param productId
     */
    @Override
    public void deleteProductThingsModelAndCacheByProductId(Long productId){
        thingsModelMapper.deleteThingsModelByProductId(productId);
        String cacheKey = RedisKeyBuilder.buildTSLCacheKey(productId);
        redisCache.deleteObject(cacheKey);
    }

    /**
     * 同步采集点模板
     * @param productIds 产品id列表
     * @param templateId 采集点模板id
     */
    @Override
    public void synchronizeVarTempToProduct(List<Long> productIds,Long templateId){
        assert templateId != null : "采集点模板id不能为空";
        assert !CollectionUtils.isEmpty(productIds): "同步的产品不能为空";
        //查询产品以及产品对应的物模型，并删除
        for (Long productId : productIds) {
            Product product = productMapper.selectProductByProductId(productId);
            assert product != null : "同步的产品不存在:" + productId;
            //删除产品的物模型以及物模型缓存
            this.deleteProductThingsModelAndCacheByProductId(productId);
            //获取最新的采集点模板数据，并更新到产品以及产品缓存
            List<ThingsModelTemplate> thingsModelTemplates = modelTemplateService.selectAllByTemplateId(templateId);
            Long[] ids = thingsModelTemplates.stream().map(ThingsModelTemplate::getTemplateId).toArray(Long[]::new);
            ImportThingsModelInput input = new ImportThingsModelInput();
            input.setTemplateIds(ids);
            input.setProductId(product.getProductId());
            input.setProductName(product.getProductName());
            this.importByTemplateIds(input);
            /*更新到产品缓存*/
            setCacheThingsModelByProductId(productId);
            //清除缓存轮询指令
            String cacheKey = RedisKeyBuilder.buildModbusCacheKey(productId);
            redisCache.deleteObject(cacheKey);
        }
    }

}
