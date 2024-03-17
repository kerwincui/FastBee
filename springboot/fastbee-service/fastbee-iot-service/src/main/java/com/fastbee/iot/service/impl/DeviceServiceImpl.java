package com.fastbee.iot.service.impl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.constant.Constants;
import com.fastbee.common.constant.ProductAuthConstant;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.domain.entity.SysRole;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.core.redis.RedisKeyBuilder;
import com.fastbee.common.core.thingsModel.ThingsModelSimpleItem;
import com.fastbee.common.core.thingsModel.ThingsModelValuesInput;
import com.fastbee.common.enums.DataEnum;
import com.fastbee.common.enums.DeviceStatus;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.common.utils.http.HttpUtils;
import com.fastbee.common.utils.ip.IpUtils;
import com.fastbee.common.utils.json.JsonUtils;
import com.fastbee.iot.domain.*;
import com.fastbee.iot.mapper.DeviceMapper;
import com.fastbee.iot.mapper.DeviceUserMapper;
import com.fastbee.iot.mapper.EventLogMapper;
import com.fastbee.iot.model.*;
import com.fastbee.iot.model.ThingsModelItem.Datatype;
import com.fastbee.iot.model.ThingsModelItem.EnumItem;
import com.fastbee.iot.model.ThingsModelItem.ThingsModel;
import com.fastbee.iot.model.ThingsModels.PropertyDto;
import com.fastbee.iot.model.ThingsModels.ThingsModelShadow;
import com.fastbee.iot.model.ThingsModels.ThingsModelValueItem;
import com.fastbee.iot.model.ThingsModels.ValueItem;
import com.fastbee.iot.service.*;
import com.fastbee.iot.service.cache.IDeviceCache;
import com.fastbee.iot.tdengine.service.ILogService;
import com.fastbee.system.service.ISysUserService;
import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

import static com.fastbee.common.utils.SecurityUtils.getLoginUser;

/**
 * 设备Service业务层处理
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Service
public class DeviceServiceImpl implements IDeviceService {
    private static final Logger log = LoggerFactory.getLogger(DeviceServiceImpl.class);

    @Autowired
    private DeviceMapper deviceMapper;
    @Autowired
    private DeviceUserMapper deviceUserMapper;
    @Autowired
    private ThingsModelServiceImpl thingsModelService;
    @Autowired
    private IToolService toolService;
    @Autowired
    private IProductService productService;
    @Autowired
    private ISysUserService userService;
    @Autowired
    private ILogService logService;
    @Autowired
    private RedisCache redisCache;
    @Resource
    @Lazy
    private IDeviceCache deviceCache;
    @Autowired
    private EventLogMapper eventLogMapper;
    @Resource
    private IFunctionLogService functionLogService;
    @Resource
    private IEventLogService eventLogService;
    @Resource
    private IProductAuthorizeService productAuthorizeService;
    @Value("${server.broker.port}")
    private Long brokerPort;


    /**
     * 查询设备
     *
     * @param deviceId 设备主键
     * @return 设备
     */
    @Override
    public Device selectDeviceByDeviceId(Long deviceId) {
        Device device = deviceMapper.selectDeviceByDeviceId(deviceId);
        List<ThingsModelValueItem> list = getCacheDeviceStatus(device.getProductId(), device.getSerialNumber());
        if (list != null && list.size() > 0) {
            // redis中获取设备状态（物模型值）
            device.setThingsModelValue(JSONObject.toJSONString(list));
        }

        /*查询子设备*/
        if (device != null) {
            Device subBo = new Device();
            subBo.setGwDevCode(device.getSerialNumber());
            List<Device> subDeviceList = deviceMapper.selectDeviceList(subBo);
            //获取子设备的首地址
            if (!CollectionUtils.isEmpty(subDeviceList)) {
                device.setSlaveId(subDeviceList.get(0).getSlaveId());
            }
            device.setSubDeviceList(subDeviceList);
        }
        return device;
    }

    /**
     * 查询设备统计信息
     *
     * @return 设备
     */
    @Override
    public DeviceStatistic selectDeviceStatistic() {
        Device device = new Device();
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles = user.getRoles();
        for (int i = 0; i < roles.size(); i++) {
            if (roles.get(i).getRoleKey().equals("tenant")) {
                // 租户查看产品下所有设备
                device.setTenantId(user.getUserId());
            } else if (roles.get(i).getRoleKey().equals("general")) {
                // 用户查看自己设备
                device.setUserId(user.getUserId());
            }
        }
        // 获取设备、产品和告警数量
        DeviceStatistic statistic = deviceMapper.selectDeviceProductAlertCount(device);
        if (statistic == null) {
            statistic = new DeviceStatistic();
            return statistic;
        }
        // 获取属性、功能和事件
        DeviceStatistic thingsCount = logService.selectCategoryLogCount(device);
        if (thingsCount == null) {
            return statistic;
        }
        // 组合属性、功能、事件和监测数据
        statistic.setPropertyCount(thingsCount.getPropertyCount());
        statistic.setFunctionCount(thingsCount.getFunctionCount());
        statistic.setEventCount(thingsCount.getEventCount());
        statistic.setMonitorCount(thingsCount.getMonitorCount());
        return statistic;
    }

    /**
     * 根据设备编号查询设备
     *
     * @param serialNumber 设备主键
     * @return 设备
     */
    @Override
    public Device selectDeviceBySerialNumber(String serialNumber) {
        Device device = deviceMapper.selectDeviceBySerialNumber(serialNumber);
        if (device != null) {
            // redis中获取设备状态（物模型值）
            List<ThingsModelValueItem> list = getCacheDeviceStatus(device.getProductId(), device.getSerialNumber());
            if (list != null && list.size() > 0) {
                device.setThingsModelValue(JSONObject.toJSONString(list));
            }
        }
        return device;
    }

    /**
     * 根据设备编号查询简洁设备
     *
     * @param serialNumber 设备主键
     * @return 设备
     */
    @Override
    public Device selectShortDeviceBySerialNumber(String serialNumber) {
        Device device = deviceMapper.selectShortDeviceBySerialNumber(serialNumber);
        if (device != null) {
            // redis中获取设备状态（物模型值）
            List<ThingsModelValueItem> list = getCacheDeviceStatus(device.getProductId(), device.getSerialNumber());
            if (list != null && list.size() > 0) {
                device.setThingsModelValue(JSONObject.toJSONString(list));
            }
        }
        return device;
    }

    /**
     * 根据设备编号查询设备认证信息
     *
     * @param model 设备编号和产品ID
     * @return 设备
     */
    @Override
    public ProductAuthenticateModel selectProductAuthenticate(AuthenticateInputModel model) {
        return deviceMapper.selectProductAuthenticate(model);
    }



    @Override
    @Transactional(rollbackFor = Exception.class)
    public List<ThingsModelSimpleItem> reportDeviceThingsModelValue(ThingsModelValuesInput input, int type, boolean isShadow) {
        String key = RedisKeyBuilder.buildTSLVCacheKey(input.getProductId(), input.getDeviceNumber());
        Map<String, String> maps = new HashMap<String, String>();
        List<ThingsModelSimpleItem> list = new ArrayList<>();
        for (ThingsModelSimpleItem item : input.getThingsModelValueRemarkItem()) {
            String identity = item.getId();
            Integer slaveId = input.getSlaveId() == null ? item.getSlaveId() : input.getSlaveId();
            String serialNumber = slaveId == null ? input.getDeviceNumber() : input.getDeviceNumber()+"_"+ slaveId;
            if (identity.startsWith("array_")) {
                identity = identity.substring(9);
            }
            // 查询redis中物模型
            identity = identity + (slaveId != null ? "#" + slaveId : "");
            PropertyDto dto = thingsModelService.getSingleThingModels(input.getProductId(), identity);
            if (null == dto) {
                continue;
            }
            String id = item.getId();
            String value = item.getValue();


            /* ★★★★★★★★★★★★★★★★★★★★★★  处理数据 - 开始 ★★★★★★★★★★★★★★★★★★★★★★*/
            String cacheValue = redisCache.getCacheMapValue(key, identity);
            ValueItem valueItem = JSON.parseObject(cacheValue, ValueItem.class);
            if (null == valueItem) {
                valueItem = new ValueItem(id,dto.getTempSlaveId(),id);
            }
            if (id.startsWith("array_")) {
                // 查询是否有缓存，如果没有先进行缓存
                if (!redisCache.containsKey(key)) {
                    Device device = this.selectDeviceBySerialNumber(input.getDeviceNumber());
                    this.selectDeviceByDeviceId(device.getDeviceId());
                }

                int index = Integer.parseInt(id.substring(6, 8));
                if (isShadow) {
                    String[] shadows = valueItem.getShadow().split(",");
                    shadows[index] = value;
                    valueItem.setShadow(String.join(",", shadows));
                } else {
                    // 设置值，获取数组值，然后替换其中元素
                    valueItem.setTs(DateUtils.getNowDate());
                    String[] values = valueItem.getValue().split(",");
                    values[index] = value;
                    valueItem.setValue(String.join(",", values));

                    String[] shadows = valueItem.getShadow().split(",");
                    shadows[index] = value;
                    valueItem.setShadow(String.join(",", shadows));
                }
                redisCache.setCacheMapValue(key,identity,JSONObject.toJSONString(valueItem));
                //maps.put(identity, JSONObject.toJSONString(valueItem));
            } else {
                if (isShadow) {
                    valueItem.setShadow(value);
                } else {
                    valueItem.setValue(value);
                    valueItem.setShadow(value);
                    valueItem.setTs(DateUtils.getNowDate());
                }
                maps.put(identity, JSONObject.toJSONString(valueItem));
            }
            /* ★★★★★★★★★★★★★★★★★★★★★★  处理数据 - 结束 ★★★★★★★★★★★★★★★★★★★★★★*/

            /*★★★★★★★★★★★★★★★★★★★★★★  存储数据 - 开始 ★★★★★★★★★★★★★★★★★★★★★★*/
            if (null != dto.getIsHistory()) {

            }
            list.add(item);
        }
        redisCache.hashPutAll(key, maps);
        /* ★★★★★★★★★★★★★★★★★★★★★★  存储数据 - 结束 ★★★★★★★★★★★★★★★★★★★★★★*/
        return list;
    }

    /**
     * 查询设备列表
     *
     * @param device 设备
     * @return 设备
     */
    @Override
    public List<Device> selectDeviceList(Device device) {
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles = user.getRoles();
        for (int i = 0; i < roles.size(); i++) {
            if (roles.get(i).getRoleKey().equals("tenant")) {
                // 租户查看产品下所有设备
                device.setTenantId(user.getUserId());
            } else if (roles.get(i).getRoleKey().equals("general")) {
                // 用户查看自己设备
                device.setUserId(user.getUserId());
            }
        }
        return deviceMapper.selectDeviceList(device);
    }

    /**
     * 查询未分配授权码设备列表
     *
     * @param device 设备
     * @return 设备
     */
    @Override
    public List<Device> selectUnAuthDeviceList(Device device) {
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles = user.getRoles();
        for (int i = 0; i < roles.size(); i++) {
            if (roles.get(i).getRoleKey().equals("tenant")) {
                // 租户查看产品下所有设备
                device.setTenantId(user.getUserId());
            } else if (roles.get(i).getRoleKey().equals("general")) {
                // 用户查看自己设备
                device.setUserId(user.getUserId());
            }
        }
        return deviceMapper.selectUnAuthDeviceList(device);
    }

    /**
     * 查询分组可添加设备分页列表（分组用户与设备用户匹配）
     *
     * @param device 设备
     * @return 设备
     */
    @Override
    public List<Device> selectDeviceListByGroup(Device device) {
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles = user.getRoles();
        for (int i = 0; i < roles.size(); i++) {
            if (roles.get(i).getRoleKey().equals("tenant")) {
                // 租户查看产品下所有设备
                device.setTenantId(user.getUserId());
            } else if (roles.get(i).getRoleKey().equals("general")) {
                // 用户查看自己设备
                device.setUserId(user.getUserId());
            }
        }
        return deviceMapper.selectDeviceListByGroup(device);
    }

    /**
     * 查询所有设备简短列表
     *
     * @return 设备
     */
    @Override
    public List<DeviceAllShortOutput> selectAllDeviceShortList() {
        Device device = new Device();
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles = user.getRoles();
        for (SysRole role : roles) {
            if (role.getRoleKey().equals("tenant")) {
                // 租户查看产品下所有设备
                device.setTenantId(user.getUserId());
                break;
            } else if (role.getRoleKey().equals("general")) {
                // 用户查看自己设备
                device.setUserId(user.getUserId());
                break;
            }
        }
        return deviceMapper.selectAllDeviceShortList(device);
    }

    /**
     * 查询设备分页简短列表
     *
     * @param device 设备
     * @return 设备
     */
    @Override
    public List<DeviceShortOutput> selectDeviceShortList(Device device) {
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles = user.getRoles();
        for (int i = 0; i < roles.size(); i++) {
            if (roles.get(i).getRoleKey().equals("tenant")) {
                // 租户查看产品下所有设备
                device.setTenantId(user.getUserId());
                break;
            } else if (roles.get(i).getRoleKey().equals("general")) {
                // 用户查看自己设备
                device.setUserId(user.getUserId());
                break;
            }
        }
        List<DeviceShortOutput> deviceList = deviceMapper.selectDeviceShortList(device);
        return deviceList;
    }

    /**
     * 查询设备
     *
     * @param deviceId 设备主键
     * @return 设备
     */
    @Override
    public DeviceShortOutput selectDeviceRunningStatusByDeviceId(Long deviceId, Integer slaveId) {
        DeviceShortOutput device = deviceMapper.selectDeviceRunningStatusByDeviceId(deviceId);
        JSONObject thingsModelObject = JSONObject.parseObject(thingsModelService.getCacheThingsModelByProductId(device.getProductId()));
        JSONArray properties = thingsModelObject.getJSONArray("properties");
        JSONArray functions = thingsModelObject.getJSONArray("functions");
        List<ThingsModelValueItem> thingsModelValueItems = getCacheDeviceStatus(device.getProductId(), device.getSerialNumber());
        // 物模型转换赋值
        List<ThingsModel> thingsList = new ArrayList<>();
        //判断一下properties 和 functions是否为空, 否则报空指针
        if (!CollectionUtils.isEmpty(properties)) {
            thingsList.addAll(convertJsonToThingsList(properties, thingsModelValueItems, 1));
        }
        if (!CollectionUtils.isEmpty(functions)) {
            thingsList.addAll(convertJsonToThingsList(functions, thingsModelValueItems, 2));
        }
        // 排序
        thingsList = thingsList.stream()
                .filter(model -> {
                    if (null != slaveId) {
                        return model.getSlaveId().intValue() == slaveId.intValue();
                    }
                    return true;
                })
                .sorted(Comparator.comparing(ThingsModel::getOrder).reversed()).collect(Collectors.toList());
        device.setThingsModels(thingsList);
        device.setThingsModelValue("");
        return device;
    }

    /**
     * 物模型基本类型转换赋值
     *
     * @param jsonArray
     * @param thingsModelValues
     * @param type
     * @return
     */
    @Async
    public List<ThingsModel> convertJsonToThingsList(JSONArray jsonArray, List<ThingsModelValueItem> thingsModelValues, Integer type) {
        List<ThingsModel> thingsModelList = new ArrayList<>();
        for (int i = 0; i < jsonArray.size(); i++) {
            ThingsModel thingsModel = new ThingsModel();
            JSONObject thingsJson = jsonArray.getJSONObject(i);
            JSONObject datatypeJson = thingsJson.getJSONObject("datatype");
            thingsModel.setId(thingsJson.getString("id"));
            thingsModel.setName(thingsJson.getString("name"));
            thingsModel.setIsMonitor(thingsJson.getInteger("isMonitor") == null ? 0 : thingsJson.getInteger("isMonitor"));
            thingsModel.setIsReadonly(thingsJson.getInteger("isReadonly") == null ? 0 : thingsJson.getInteger("isReadonly"));
            thingsModel.setIsChart(thingsJson.getInteger("isChart") == null ? 0 : thingsJson.getInteger("isChart"));
            thingsModel.setIsSharePerm(thingsJson.getInteger("isSharePerm") == null ? 0 : thingsJson.getInteger("isSharePerm"));
            thingsModel.setIsHistory(thingsJson.getInteger("isHistory") == null ? 0 : thingsJson.getInteger("isHistory"));
            thingsModel.setOrder(thingsJson.getInteger("order") == null ? 0 : thingsJson.getInteger("order"));
            thingsModel.setType(type);
            thingsModel.setSlaveId(thingsJson.getInteger("tempSlaveId"));
            thingsModel.setRegId(thingsJson.getString("regId"));
            // 获取value
            for (ThingsModelValueItem valueItem : thingsModelValues) {
                if (valueItem.getId().equals(thingsModel.getId()) || valueItem.getId().equals(thingsModel.getRegId())) {
                    thingsModel.setValue(valueItem.getValue());
                    thingsModel.setShadow(valueItem.getShadow());
                    thingsModel.setTs(valueItem.getTs());
                    break;
                }
            }
            // json转DataType(DataType赋值)
            Datatype dataType = convertJsonToDataType(datatypeJson, thingsModelValues, type, thingsModel.getId() + "_");
            thingsModel.setDatatype(dataType);
            if (JsonUtils.isJson(thingsModel.getValue())){
                JSONObject jsonObject = JSONObject.parseObject(thingsModel.getValue());
                for (EnumItem enumItem : dataType.getEnumList()) {
                    ThingsModel model = new ThingsModel();
                    BeanUtils.copyProperties(thingsModel,model);
                    String val = jsonObject.getString(enumItem.getValue());
                    model.setValue(val);
                    model.setName(enumItem.getValue());
                    thingsModelList.add(model);
                }
            }else {
                // 物模型项添加到集合
                thingsModelList.add(thingsModel);
            }
        }
        return thingsModelList;
    }

    /**
     * 物模型DataType转换
     *
     * @param datatypeJson
     * @param thingsModelValues
     * @param type
     * @param parentIdentifier  上级标识符
     * @return
     */
    private Datatype convertJsonToDataType(JSONObject datatypeJson, List<ThingsModelValueItem> thingsModelValues, Integer type, String parentIdentifier) {
        Datatype dataType = new Datatype();
        //有些物模型数据定义为空的情况兼容
        if (datatypeJson == null) {
            return dataType;
        }
        dataType.setType(datatypeJson.getString("type"));
        if (dataType.getType().equals("decimal")) {
            dataType.setMax(datatypeJson.getBigDecimal("max"));
            dataType.setMin(datatypeJson.getBigDecimal("min"));
            dataType.setStep(datatypeJson.getBigDecimal("step"));
            dataType.setUnit(datatypeJson.getString("unit"));
        } else if (dataType.getType().equals("integer")) {
            dataType.setMax(datatypeJson.getBigDecimal("max"));
            dataType.setMin(datatypeJson.getBigDecimal("min"));
            dataType.setStep(datatypeJson.getBigDecimal("step"));
            dataType.setUnit(datatypeJson.getString("unit"));
        } else if (dataType.getType().equals("bool")) {
            dataType.setFalseText(datatypeJson.getString("falseText"));
            dataType.setTrueText(datatypeJson.getString("trueText"));
        } else if (dataType.getType().equals("string")) {
            dataType.setMaxLength(datatypeJson.getInteger("maxLength"));
        } else if (dataType.getType().equals("enum")) {
            List<EnumItem> enumItemList = JSON.parseArray(datatypeJson.getString("enumList"), EnumItem.class);
            dataType.setEnumList(enumItemList);
            dataType.setShowWay(datatypeJson.getString("showWay"));
        } else if (dataType.getType().equals("object")) {
            JSONArray jsonArray = JSON.parseArray(datatypeJson.getString("params"));
            // 物模型值过滤（parentId_开头）
            thingsModelValues = thingsModelValues.stream().filter(x -> x.getId().startsWith(parentIdentifier)).collect(Collectors.toList());
            List<ThingsModel> thingsList = convertJsonToThingsList(jsonArray, thingsModelValues, type);
            // 排序
            thingsList = thingsList.stream().sorted(Comparator.comparing(ThingsModel::getOrder).reversed()).collect(Collectors.toList());
            dataType.setParams(thingsList);
        } else if (dataType.getType().equals("array")) {
            dataType.setArrayType(datatypeJson.getString("arrayType"));
            dataType.setArrayCount(datatypeJson.getInteger("arrayCount"));
            if ("object".equals(dataType.getArrayType())) {
                // 对象数组
                JSONArray jsonArray = datatypeJson.getJSONArray("params");
                // 物模型值过滤（parentId_开头）
                thingsModelValues = thingsModelValues.stream().filter(x -> x.getId().startsWith(parentIdentifier)).collect(Collectors.toList());
                List<ThingsModel> thingsList = convertJsonToThingsList(jsonArray, thingsModelValues, type);
                // 排序
                thingsList = thingsList.stream().sorted(Comparator.comparing(ThingsModel::getOrder).reversed()).collect(Collectors.toList());
                // 数组类型物模型里面对象赋值
                List<ThingsModel>[] arrayParams = new List[dataType.getArrayCount()];
                for (int i = 0; i < dataType.getArrayCount(); i++) {
                    List<ThingsModel> thingsModels = new ArrayList<>();
                    for (int j = 0; j < thingsList.size(); j++) {
                        ThingsModel thingsModel = new ThingsModel();
                        BeanUtils.copyProperties(thingsList.get(j), thingsModel);
                        String shadow = thingsList.get(j).getShadow();
                        if (StringUtils.isNotEmpty(shadow) && !shadow.equals("")) {
                            String[] shadows = shadow.split(",");
                            if(i+1 > shadows.length){
                                // 解决产品取消发布，增加数组长度导致设备影子和值赋值失败
                                thingsModel.setShadow(" ");
                            }else{
                                thingsModel.setShadow(shadows[i]);
                            }
                        }
                        String value = thingsList.get(j).getValue();
                        if (StringUtils.isNotEmpty(value) && !value.equals("")) {
                            String[] values = value.split(",");
                            if(i+1 > values.length){
                                thingsModel.setValue(" ");
                            }else{
                                thingsModel.setValue(values[i]);
                            }
                        }
                        thingsModels.add(thingsModel);
                    }
                    arrayParams[i] = thingsModels;
                }
                dataType.setArrayParams(arrayParams);
            }
        }
        return dataType;
    }

    /**
     * 新增设备
     *
     * @param device 设备
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Device insertDevice(Device device) {
        // 设备编号唯一检查
        Device existDevice = deviceMapper.selectDeviceBySerialNumber(device.getSerialNumber());
        if (existDevice != null) {
            log.error("设备编号：" + device.getSerialNumber() + "已经存在了，新增设备失败");
            throw new ServiceException("设备编号：" + device.getSerialNumber() + " 已经存在，新增失败");
        }
        SysUser sysUser = getLoginUser().getUser();
        //添加设备
        device.setCreateTime(DateUtils.getNowDate());
        device.setUserId(sysUser.getUserId());
        device.setUserName(sysUser.getUserName());
        device.setRssi(0);

        // 设置租户
        Product product = productService.selectProductByProductId(device.getProductId());
        device.setTenantId(product.getTenantId());
        device.setTenantName(product.getTenantName());
        device.setImgUrl(product.getImgUrl());
        // 随机经纬度和地址
        SysUser user = getLoginUser().getUser();
        device.setNetworkIp(user.getLoginIp());
        //setLocation(user.getLoginIp(), device);

        deviceMapper.insertDevice(device);
        // 添加设备用户
        DeviceUser deviceUser = new DeviceUser();
        deviceUser.setUserId(sysUser.getUserId());
        deviceUser.setUserName(sysUser.getUserName());
        deviceUser.setPhonenumber(sysUser.getPhonenumber());
        deviceUser.setDeviceId(device.getDeviceId());
        deviceUser.setDeviceName(device.getDeviceName());
        deviceUser.setTenantId(product.getTenantId());
        deviceUser.setTenantName(product.getTenantName());
        deviceUser.setIsOwner(1);
        deviceUser.setCreateTime(DateUtils.getNowDate());
        int result = deviceUserMapper.insertDeviceUser(deviceUser);

        // redis缓存设备默认状态（物模型值）
        cacheDeviceStatus(device.getProductId(), device.getSerialNumber());

        // 返回设备信息
        List<ThingsModelValueItem> list = getCacheDeviceStatus(device.getProductId(), device.getSerialNumber());
        if (list != null && list.size() > 0) {
            device.setThingsModelValue(JSONObject.toJSONString(list));
        }
        /*查询子设备*/
        Device subBo = new Device();
        subBo.setGwDevCode(device.getSerialNumber());
        List<Device> subDeviceList = deviceMapper.selectDeviceList(subBo);
        //获取子设备的首地址
        if (!CollectionUtils.isEmpty(subDeviceList)) {
            device.setSlaveId(subDeviceList.get(0).getSlaveId());
        }
        device.setSubDeviceList(subDeviceList);
        return device;
    }

    /**
     * 设备关联用户
     *
     * @param deviceRelateUserInput
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public AjaxResult deviceRelateUser(DeviceRelateUserInput deviceRelateUserInput) {
        // 查询用户信息
        SysUser sysUser = userService.selectUserById(deviceRelateUserInput.getUserId());
        for (int i = 0; i < deviceRelateUserInput.getDeviceNumberAndProductIds().size(); i++) {
            Device existDevice = deviceMapper.selectDeviceBySerialNumber(deviceRelateUserInput.getDeviceNumberAndProductIds().get(i).getDeviceNumber());
            if (existDevice != null) {
                if (existDevice.getUserId().longValue() == deviceRelateUserInput.getUserId().longValue()) {
                    return AjaxResult.error("用户已经拥有设备：" + existDevice.getDeviceName() + ", 设备编号：" + existDevice.getSerialNumber());
                }
                // 先删除设备的所有用户
                deviceUserMapper.deleteDeviceUserByDeviceId(new UserIdDeviceIdModel(null, existDevice.getDeviceId()));
                // 添加新的设备用户
                DeviceUser deviceUser = new DeviceUser();
                deviceUser.setUserId(sysUser.getUserId());
                deviceUser.setUserName(sysUser.getUserName());
                deviceUser.setPhonenumber(sysUser.getPhonenumber());
                deviceUser.setDeviceId(existDevice.getDeviceId());
                deviceUser.setDeviceName(existDevice.getDeviceName());
                deviceUser.setTenantId(existDevice.getTenantId());
                deviceUser.setTenantName(existDevice.getTenantName());
                deviceUser.setIsOwner(1);
                deviceUser.setCreateTime(DateUtils.getNowDate());
                deviceUserMapper.insertDeviceUser(deviceUser);
                // 更新设备用户信息
                existDevice.setUserId(deviceRelateUserInput.getUserId());
                existDevice.setUserName(sysUser.getUserName());
                deviceMapper.updateDevice(existDevice);
            } else {
                // 自动添加设备
                int result = insertDeviceAuto(
                        deviceRelateUserInput.getDeviceNumberAndProductIds().get(i).getDeviceNumber(),
                        deviceRelateUserInput.getUserId(),
                        deviceRelateUserInput.getDeviceNumberAndProductIds().get(i).getProductId());
                if (result == 0) {
                    return AjaxResult.error("设备不存在，自动添加设备时失败，请检查产品编号是否正确");
                }
            }
        }
        return AjaxResult.success("添加设备成功");
    }

    /**
     * 设备认证后自动添加设备
     *
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertDeviceAuto(String serialNumber, Long userId, Long productId) {
        // 设备编号唯一检查
        int count = deviceMapper.selectDeviceCountBySerialNumber(serialNumber);
        if (count != 0) {
            log.error("设备编号：" + serialNumber + "已经存在了，新增设备失败");
            return 0;
        }
        Device device = new Device();
        device.setSerialNumber(serialNumber);
        SysUser user = userService.selectUserById(userId);
        device.setUserId(userId);
        device.setUserName(user.getUserName());
        device.setFirmwareVersion(BigDecimal.valueOf(1.0));
        // 设备状态（1-未激活，2-禁用，3-在线，4-离线）
        device.setStatus(3);
        device.setActiveTime(DateUtils.getNowDate());
        device.setIsShadow(0);
        device.setRssi(0);
        // 1-自动定位，2-设备定位，3-自定义位置
        device.setLocationWay(1);
        device.setCreateTime(DateUtils.getNowDate());
        // 随机位置
        device.setLongitude(BigDecimal.valueOf(116.23 - (Math.random() * 15)));
        device.setLatitude(BigDecimal.valueOf(39.54 - (Math.random() * 15)));
        device.setNetworkAddress("中国");
        device.setNetworkIp("127.0.0.1");
        // 设置租户
        Product product = productService.selectProductByProductId(productId);
        if (product == null) {
            log.error("自动添加设备时，根据产品ID查找不到对应产品");
            return 0;
        }
        int random = (int) (Math.random() * (90)) + 10;
        device.setDeviceName(product.getProductName() + random);
        device.setTenantId(product.getTenantId());
        device.setTenantName(product.getTenantName());
        device.setImgUrl(product.getImgUrl());
        device.setProductId(product.getProductId());
        device.setProductName(product.getProductName());
        deviceMapper.insertDevice(device);

        // 缓存设备状态
        cacheDeviceStatus(device.getProductId(), device.getSerialNumber());

        // 添加设备用户
        DeviceUser deviceUser = new DeviceUser();
        deviceUser.setUserId(userId);
        deviceUser.setUserName(user.getUserName());
        deviceUser.setPhonenumber(user.getPhonenumber());
        deviceUser.setDeviceId(device.getDeviceId());
        deviceUser.setDeviceName(device.getDeviceName());
        deviceUser.setTenantId(product.getTenantId());
        deviceUser.setTenantName(product.getTenantName());
        deviceUser.setIsOwner(1);
        return deviceUserMapper.insertDeviceUser(deviceUser);
    }

    /**
     * 获取用户操作设备的影子值
     *
     * @param device
     * @return
     */
    @Override
    public ThingsModelShadow getDeviceShadowThingsModel(Device device) {
        // 物模型值
        List<ThingsModelValueItem> thingsModelValueItems = getCacheDeviceStatus(device.getProductId(), device.getSerialNumber());
        ThingsModelShadow shadow = new ThingsModelShadow();
        // 查询出设置的影子值
        List<ThingsModelValueItem> shadowList = new ArrayList<>();
        for (ThingsModelValueItem item : thingsModelValueItems) {
            if (!item.getValue().equals(item.getShadow()) && !item.getShadow().equals("")) {
                //处理id
                String id = item.getId();
                //modbus类型
                if (id.contains("#")) {
                    id = id.split("#")[0];
                    ThingsModelSimpleItem shaowItem = new ThingsModelSimpleItem(id, item.getShadow(), item.getTempSlaveId(), "");
                    shadow.getProperties().add(shaowItem);
                } else if (item.getShadow().contains(",")) {
                    String[] shadows = item.getShadow().split(",");
                    String[] values = item.getValue().split(",");
                    for (int i = 0; i < shadows.length; i++) {
                        String value = values[i];
                        String shaVal = shadows[i];
                        if (!shaVal.equals(value)) {
                            id = "array_0" + i + "_" + id;
                            ThingsModelSimpleItem shaowItem = new ThingsModelSimpleItem(id, shaVal, "");
                            shadow.getProperties().add(shaowItem);
                        }
                    }
                } else {
                    ThingsModelSimpleItem shaowItem = new ThingsModelSimpleItem(id, item.getShadow(), "");
                    shadow.getProperties().add(shaowItem);
                }
            }
        }
        return shadow;
    }


    /**
     * 修改设备
     *
     * @param device 设备
     * @return 结果
     */
    @Override
    public AjaxResult updateDevice(Device device) {
        // 设备编号唯一检查
        Device oldDevice = deviceMapper.selectDeviceByDeviceId(device.getDeviceId());
        if (!oldDevice.getSerialNumber().equals(device.getSerialNumber())) {
            Device existDevice = deviceMapper.selectDeviceBySerialNumber(device.getSerialNumber());
            if (existDevice != null) {
                log.error("设备编号：" + device.getSerialNumber() + " 已经存在，新增设备失败");
                return AjaxResult.error("设备编号：" + device.getSerialNumber() + " 已经存在，修改失败", 0);
            }
        }
        device.setUpdateTime(DateUtils.getNowDate());
        // 未激活状态,可以修改产品以及物模型值
        if (device.getStatus() == 1) {
            // 缓存设备状态（物模型值）
            cacheDeviceStatus(device.getProductId(), device.getSerialNumber());

        } else {
            device.setProductId(null);
            device.setProductName(null);
        }
        deviceMapper.updateDevice(device);
        // 更新前设备状态为禁用，启用后状态默认为离线，满足时下发获取设备最新状态指令
        if (oldDevice.getStatus() == 2 && device.getStatus() == 4) {
            // 发布设备信息，设备收到该消息后上报最新状态
            // emqxService.publishInfo(oldDevice.getProductId(), oldDevice.getSerialNumber());
        }
        return AjaxResult.success("修改成功", 1);
    }

    /**
     * 生成设备唯一编号
     *
     * @return 结果
     */
    @Override
    public String generationDeviceNum(Integer type) {
        // 设备编号：D + userId + 15位随机字母和数字
        SysUser user = getLoginUser().getUser();
        String number;
        //Hex随机字符串
        if (type == 3){
            number = toolService.generateRandomHex(12);
        }else {
            number = "D" + user.getUserId().toString() + toolService.getStringRandom(10);
        }
        int count = deviceMapper.getDeviceNumCount(number);
        if (count == 0) {
            return number;
        } else {
            generationDeviceNum(type);
        }
        return "";
    }

    /**
     * @param device 设备状态和定位更新
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateDeviceStatusAndLocation(Device device, String ipAddress) {
        // 设置自动定位和状态
        if (ipAddress != "") {
            if (device.getActiveTime() == null) {
                device.setActiveTime(DateUtils.getNowDate());
            }
            // 定位方式(1=ip自动定位，2=设备定位，3=自定义)
            if (device.getLocationWay() == 1) {
                device.setNetworkIp(ipAddress);
                //setLocation(ipAddress, device);
            }
        }
        int result = deviceMapper.updateDeviceStatus(device);
        // 添加到设备日志
        EventLog event = new EventLog();
        event.setDeviceId(device.getDeviceId());
        event.setDeviceName(device.getDeviceName());
        event.setSerialNumber(device.getSerialNumber());
        event.setIsMonitor(0);
        event.setUserId(device.getUserId());
        event.setUserName(device.getUserName());
        event.setTenantId(device.getTenantId());
        event.setTenantName(device.getTenantName());
        event.setCreateTime(DateUtils.getNowDate());
        // 日志模式 1=影子模式，2=在线模式，3=其他
        event.setMode(3);
        if (device.getStatus() == 3) {
            event.setLogValue("1");
            event.setRemark("设备上线");
            event.setIdentity("online");
            event.setLogType(5);
        } else if (device.getStatus() == 4) {
            event.setLogValue("0");
            event.setRemark("设备离线");
            event.setIdentity("offline");
            event.setLogType(6);
        }
        eventLogMapper.insertEventLog(event);
        return result;
    }

    /**
     * @param device 设备状态
     * @return 结果
     */
    @Override
    public int updateDeviceStatus(Device device) {
        return deviceMapper.updateDeviceStatus(device);
    }

    /**
     * 更新固件版本
     *
     * @param device
     * @return
     */
    @Override
    public int updateDeviceFirmwareVersion(Device device) {
        return deviceMapper.updateDeviceFirmwareVersion(device);
    }

    /**
     * 上报设备信息
     *
     * @param device 设备
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int reportDevice(Device device, Device deviceEntity) {
        // 未采用设备定位则清空定位，定位方式(1=ip自动定位，2=设备定位，3=自定义)
        if (deviceEntity.getLocationWay() != 2) {
            device.setLatitude(null);
            device.setLongitude(null);
        }
        int result = 0;
        if (deviceEntity != null && device.getUserId() != null) {
            // 通过配网或者扫码关联设备后，设备的用户信息需要变更
            if (deviceEntity.getUserId().longValue() != device.getUserId().longValue()) {
                // 先删除设备的所有用户
                deviceUserMapper.deleteDeviceUserByDeviceId(new UserIdDeviceIdModel(null, deviceEntity.getDeviceId()));
                // 添加新的设备用户
                SysUser sysUser = userService.selectUserById(device.getUserId());
                DeviceUser deviceUser = new DeviceUser();
                deviceUser.setUserId(sysUser.getUserId());
                deviceUser.setUserName(sysUser.getUserName());
                deviceUser.setPhonenumber(sysUser.getPhonenumber());
                deviceUser.setDeviceId(deviceEntity.getDeviceId());
                deviceUser.setDeviceName(deviceEntity.getDeviceName());
                deviceUser.setTenantId(deviceEntity.getTenantId());
                deviceUser.setTenantName(deviceEntity.getTenantName());
                deviceUser.setIsOwner(1);
                deviceUser.setCreateTime(DateUtils.getNowDate());
                deviceUserMapper.insertDeviceUser(deviceUser);
                // 更新设备用户信息
                device.setUserId(device.getUserId());
                device.setUserName(sysUser.getUserName());
            }
            device.setUpdateTime(DateUtils.getNowDate());
            if (deviceEntity.getActiveTime() == null || deviceEntity.getActiveTime().equals("")) {
                device.setActiveTime(DateUtils.getNowDate());
            }
            // 不更新物模型
            device.setThingsModelValue(null);
            result = deviceMapper.updateDeviceBySerialNumber(device);
        }
        return result;
    }

    /**
     * 重置设备状态
     *
     * @return 结果
     */
    @Override
    public int resetDeviceStatus(String deviceNum) {
        int result = deviceMapper.resetDeviceStatus(deviceNum);
        return result;
    }

    /**
     * 删除设备
     *
     * @param deviceId 需要删除的设备主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteDeviceByDeviceId(Long deviceId) throws SchedulerException {
        SysUser user = getLoginUser().getUser();
        // 是否为普通用户，普通用户如果不是设备所有者，只能删除设备用户和用户自己的设备关联分组信息
        boolean isGeneralUser = false;
        List<SysRole> roles = user.getRoles();
        for (int i = 0; i < roles.size(); i++) {
            if (roles.get(i).getRoleKey().equals("general")) {
                isGeneralUser = true;
                break;
            }
        }
        Device device = deviceMapper.selectDeviceByDeviceId(deviceId);
        if (isGeneralUser && device.getUserId().longValue() != user.getUserId()) {
            // 删除用户分组中的设备 普通用户，且不是设备所有者。
            deviceMapper.deleteDeviceGroupByDeviceId(new UserIdDeviceIdModel(user.getUserId(), deviceId));
            // 删除用户的设备用户信息。
            deviceUserMapper.deleteDeviceUserByDeviceId(new UserIdDeviceIdModel(user.getUserId(), deviceId));
        } else {
            // 删除设备分组。  租户、管理员和设备所有者
            deviceMapper.deleteDeviceGroupByDeviceId(new UserIdDeviceIdModel(null, deviceId));
            // 删除设备用户。
            deviceUserMapper.deleteDeviceUserByDeviceId(new UserIdDeviceIdModel(null, deviceId));
            // 删除定时任务 TODO - emq兼容
            // deviceJobService.deleteJobByDeviceIds(new Long[]{deviceId});
            // 批量删除设备监测日志
            logService.deleteDeviceLogByDeviceNumber(device.getSerialNumber());
            // 批量删除设备事件日志  DeviceNumber
            eventLogService.deleteEventLogByDeviceNumber(device.getSerialNumber());
            // 批量删除设备功能日志
            functionLogService.deleteFunctionLogByDeviceNumber(device.getSerialNumber());
            // redis中删除设备物模型（状态）
            String key = RedisKeyBuilder.buildTSLVCacheKey(device.getProductId(), device.getSerialNumber());
            redisCache.deleteObject(key);
            // 删除设备
            deviceMapper.deleteDeviceByDeviceIds(new Long[]{deviceId});
        }
        //查询是否有子设备
        Integer subDeviceCount = this.getSubDeviceCount(device.getSerialNumber());
        if (null != subDeviceCount && subDeviceCount > 0) {
            this.deleteSubDevice(device.getSerialNumber());
        }
        return 1;
    }

    /**
     * 根据网关编号删除子设备
     *
     * @param gwCode
     */
    @Override
    public void deleteSubDevice(String gwCode) {
        deviceMapper.deleteSubDevice(gwCode);
    }

    /**
     * 根据设备编号查询协议编码
     *
     * @param serialNumber
     * @return
     */
    @Override
    public Map<String, Object> selectProtocolBySerialNumber(String serialNumber) {
        return deviceMapper.selectProtocolBySerialNumber(serialNumber);
    }

    /**
     * 查询产品下所有设备，返回设备编号
     *
     * @param productId 产品id
     * @return
     */
    @Override
    public List<Device> selectDevicesByProductId(Long productId, Integer hasSub) {
        return deviceMapper.selectDevicesByProductId(productId, hasSub);
    }

    /**
     * 查询子设备总数
     *
     * @param gwDevCode 网关编号
     * @return 数量
     */
    @Override
    public Integer getSubDeviceCount(String gwDevCode) {
        return deviceMapper.getSubDeviceCount(gwDevCode);
    }


    /**
     * 批量更新设备状态
     *
     * @param serialNumbers 设备ids
     * @param status        状态
     */
    @Override
    public void batchChangeStatus(List<String> serialNumbers, DeviceStatus status) {
        if (CollectionUtils.isEmpty(serialNumbers)) {
            return;
        }
        //设备离线
        if (DeviceStatus.OFFLINE.equals(status)) {
            deviceMapper.batchChangeOffline(serialNumbers);
        } else if (DeviceStatus.ONLINE.equals(status)) {
            deviceMapper.batchChangeOnline(serialNumbers);
        }
        deviceCache.updateBatchDeviceStatusCache(serialNumbers, status);
    }

    /**
     * 查询在线的modbus网关设备
     *
     * @return
     */
    @Override
    public List<Device> selectOnlineModbusDevices() {
        return deviceMapper.selectOnlineModbusDevices();
    }

    /**
     * 根据设备编号查询设备信息 -不带缓存物模型值
     *
     * @param serialNumber
     * @return
     */
    @Override
    public Device selectDeviceNoModel(String serialNumber) {
        return deviceMapper.selectDeviceBySerialNumber(serialNumber);
    }

    /**
     * 获取设备MQTT连接参数
     * @param deviceId 设备id
     * @return
     */
    @Override
    public DeviceMqttConnectVO getMqttConnectData(Long deviceId) {
        DeviceMqttConnectVO connectVO = new DeviceMqttConnectVO();
        DeviceMqttVO deviceMqttVO = deviceMapper.selectMqttConnectData(deviceId);
        if (deviceMqttVO == null) {
            throw new ServiceException("获取设备MQTT连接参数失败");
        }
        // 不管认证方式，目前就只返回简单认证方式
        String password;
        if (ProductAuthConstant.AUTHORIZE.equals(deviceMqttVO.getIsAuthorize())) {
            // 查询产品授权码
            List<ProductAuthorize> productAuthorizeList = productAuthorizeService.listByProductId(deviceMqttVO.getProductId());
            if (CollectionUtils.isEmpty(productAuthorizeList)) {
                throw new ServiceException("产品已启用授权，获取设备授权码失败，请先配置授权码");
            }
            List<ProductAuthorize> collect = productAuthorizeList.stream().filter(p -> p.getProductId().equals(deviceMqttVO.getDeviceId())).collect(Collectors.toList());
            ProductAuthorize productAuthorize = CollectionUtils.isEmpty(collect) ? productAuthorizeList.get(0) : collect.get(0);
            password = deviceMqttVO.getMqttPassword() + "&" + productAuthorize.getAuthorizeCode();
        } else {
            password = deviceMqttVO.getMqttPassword();
        }
        String clientId = ProductAuthConstant.CLIENT_ID_AUTH_TYPE_SIMPLE + "&" + deviceMqttVO.getSerialNumber() + "&" + deviceMqttVO.getProductId() + "&" + deviceMqttVO.getUserId();
        // 组装返回结果
        connectVO.setClientId(clientId).setUsername(deviceMqttVO.getMqttAccount()).setPasswd(password).setPort(brokerPort);
        return connectVO;
    }

    /**
     * 根据IP获取地址
     *
     * @param ip
     * @return
     */
    private void setLocation(String ip, Device device) {
        String IP_URL = "http://whois.pconline.com.cn/ipJson.jsp";
        String address = "未知地址";
        // 内网不查询
        if (IpUtils.internalIp(ip)) {
            device.setNetworkAddress("内网IP");
        }
        try {
            String rspStr = HttpUtils.sendGet(IP_URL, "ip=" + ip + "&json=true", Constants.GBK);
            if (!StringUtils.isEmpty(rspStr)) {
                JSONObject obj = JSONObject.parseObject(rspStr);
                device.setNetworkAddress(obj.getString("addr"));
                System.out.println(device.getSerialNumber() + "- 设置地址：" + obj.getString("addr"));
                // 查询经纬度
                setLatitudeAndLongitude(obj.getString("city"), device);
            }
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    /**
     * 设置经纬度
     *
     * @param city
     */
    private void setLatitudeAndLongitude(String city, Device device) {
        String BAIDU_URL = "https://api.map.baidu.com/geocoder";
        String baiduResponse = HttpUtils.sendGet(BAIDU_URL, "address=" + city + "&output=json", Constants.GBK);
        if (!StringUtils.isEmpty(baiduResponse)) {
            JSONObject baiduObject = JSONObject.parseObject(baiduResponse);
            JSONObject location = baiduObject.getJSONObject("result").getJSONObject("location");
            device.setLongitude(location.getBigDecimal("lng"));
            device.setLatitude(location.getBigDecimal("lat"));
            System.out.println(device.getSerialNumber() + "- 设置经度：" + location.getBigDecimal("lng") + "，设置纬度：" + location.getBigDecimal("lat"));
        }
    }

    /**
     * 缓存设备状态到redis
     *
     * @return
     */
    public List<ThingsModelValueItem> cacheDeviceStatus(Long productId, String serialNumber) {
        // 获取物模型,设置默认值
        String thingsModels = thingsModelService.getCacheThingsModelByProductId(productId);
        JSONObject thingsModelObject = JSONObject.parseObject(thingsModels);
        JSONArray properties = thingsModelObject.getJSONArray("properties");
        JSONArray functions = thingsModelObject.getJSONArray("functions");
        List<ThingsModelValueItem> valueList = new ArrayList<>();
        if (!CollectionUtils.isEmpty(properties)) {
            valueList.addAll(properties.toJavaList(ThingsModelValueItem.class));
        }
        if (!CollectionUtils.isEmpty(functions)) {
            valueList.addAll(functions.toJavaList(ThingsModelValueItem.class));
        }
        String key = RedisKeyBuilder.buildTSLVCacheKey(productId, serialNumber);
        Map<String, String> maps = new HashMap<>();
        for (ThingsModelValueItem item : valueList) {
            String id = item.getTempSlaveId() == null ? item.getId() : item.getId() + "#" + item.getTempSlaveId();
            List<ThingsModel> params = item.getDatatype().getParams();
            ValueItem valueItem = new ValueItem();
            valueItem.setValue("");
            valueItem.setId(id);
            valueItem.setName(item.getName());
            valueItem.setShadow("");
            if (null != item.getDatatype()) {
                String type = item.getDatatype().getType();
                DataEnum dataEnum = DataEnum.convert(type);
                switch (dataEnum) {
                    case INTEGER:
                    case DECIMAL:
                    case STRING:
                    case ENUM:
                        if (null != item.getTempSlaveId()) {
                            valueItem.setSlaveId(item.getTempSlaveId());
                            valueItem.setRegArr(item.getId());
                        }
                        maps.put(id, JSONObject.toJSONString(valueItem));
                        break;
                    case ARRAY:
                        // 数组元素赋值（英文逗号分割的字符串,包含简单类型数组和对象类型数组，数组元素ID格式：array_01_humidity）
                        String defaultValue = " ";
                        if (item.getDatatype().getArrayType().equals("object")) {
                            for (int i = 0; i < item.getDatatype().getArrayCount(); i++) {
                                // 默认值需要保留为空格,便于解析字符串为数组
                                defaultValue = defaultValue + ", ";
                            }
                            for (ThingsModel param : params) {
                                valueItem.setValue(defaultValue);
                                valueItem.setShadow(defaultValue);
                                valueItem.setName(param.getName());
                                valueItem.setId(param.getId());
                                maps.put(param.getId(), JSONObject.toJSONString(valueItem));
                            }
                        } else {
                            for (int i = 0; i < item.getDatatype().getArrayCount(); i++) {
                                defaultValue = defaultValue + ", ";
                            }
                            valueItem.setValue(defaultValue);
                            valueItem.setShadow(defaultValue);
                            valueItem.setName(item.getName());
                            valueItem.setId(item.getId());
                            maps.put(item.getId(), JSONObject.toJSONString(valueItem));
                        }
                        break;
                    case OBJECT:
                        for (ThingsModel param : params) {
                            valueItem.setName(param.getName());
                            valueItem.setId(param.getId());
                            maps.put(param.getId(), JSONObject.toJSONString(valueItem));
                        }
                        break;
                }
            }
        }
        redisCache.hashPutAll(key, maps);
        return valueList;
    }


    private List<ThingsModelValueItem> getCacheDeviceStatus(Long productId, String deviceNumber) {
        String key = RedisKeyBuilder.buildTSLVCacheKey(productId, deviceNumber);
        Map<String, String> map = redisCache.hashEntity(key);
        List<ThingsModelValueItem> valueList = new ArrayList<>();
        if (map == null || map.size() == 0) {
            // 缓存设备状态（物模型值）到redis
            valueList = cacheDeviceStatus(productId, deviceNumber);
        } else {
            // 获取redis缓存的物模型值
            valueList = map.values().stream().map(s -> JSONObject.parseObject(s, ThingsModelValueItem.class))
                    .collect(Collectors.toList());
        }
        return valueList;
    }

}
