package com.ruoyi.iot.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.http.HttpUtils;
import com.ruoyi.common.utils.ip.IpUtils;
import com.ruoyi.iot.domain.Device;
import com.ruoyi.iot.domain.DeviceLog;
import com.ruoyi.iot.domain.DeviceUser;
import com.ruoyi.iot.domain.Product;
import com.ruoyi.iot.mqtt.EmqxService;
import com.ruoyi.iot.tdengine.service.ILogService;
import com.ruoyi.iot.mapper.DeviceLogMapper;
import com.ruoyi.iot.mapper.DeviceMapper;
import com.ruoyi.iot.mapper.DeviceUserMapper;
import com.ruoyi.iot.model.*;
import com.ruoyi.iot.model.ThingsModelItem.*;
import com.ruoyi.iot.model.ThingsModels.*;
import com.ruoyi.iot.service.IDeviceService;
import com.ruoyi.iot.service.IProductService;
import com.ruoyi.iot.service.IToolService;
import com.ruoyi.system.service.ISysUserService;
import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import static com.ruoyi.common.utils.SecurityUtils.getLoginUser;

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
    private DeviceJobServiceImpl deviceJobService;

    @Autowired
    private DeviceLogMapper deviceLogMapper;

    @Autowired
    private IToolService toolService;

    @Autowired
    private IProductService productService;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ILogService logService;

    @Autowired
    @Lazy
    private EmqxService emqxService;

    /**
     * 查询设备
     *
     * @param deviceId 设备主键
     * @return 设备
     */
    @Override
    public Device selectDeviceByDeviceId(Long deviceId) {
        return deviceMapper.selectDeviceByDeviceId(deviceId);
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
        return deviceMapper.selectDeviceBySerialNumber(serialNumber);
    }

    /**
     * 根据设备编号查询简介设备
     *
     * @param serialNumber 设备主键
     * @return 设备
     */
    @Override
    public Device selectShortDeviceBySerialNumber(String serialNumber) {
        return deviceMapper.selectShortDeviceBySerialNumber(serialNumber);
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

    /**
     * 查询设备
     *
     * @param deviceId 设备主键
     * @return 设备
     */
    @Override
    public DeviceShortOutput selectDeviceRunningStatusByDeviceId(Long deviceId) {
        DeviceShortOutput device = deviceMapper.selectDeviceRunningStatusByDeviceId(deviceId);
        JSONObject thingsModelObject = JSONObject.parseObject(thingsModelService.getCacheThingsModelByProductId(device.getProductId()));
        JSONArray properties = thingsModelObject.getJSONArray("properties");
        JSONArray functions = thingsModelObject.getJSONArray("functions");
        // 物模型转换为对象中的不同类别集合
        convertJsonToCategoryList(properties, device, false, false);
        convertJsonToCategoryList(functions, device, false, false);
        device.setThingsModelValue("");
        return device;
    }


    /**
     * 更新设备的物模型
     *
     * @param input 设备ID和物模型值
     * @param type  1=属性 2=功能
     * @return 设备
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int reportDeviceThingsModelValue(ThingsModelValuesInput input, int type, boolean isShadow) {
        // 查询物模型
        String thingsModels = thingsModelService.getCacheThingsModelByProductId(input.getProductId());
        JSONObject thingsModelObject = JSONObject.parseObject(thingsModels);
        List<ThingsModelValueItemDto> valueList = null;
        if (type == 1) {
            JSONArray properties = thingsModelObject.getJSONArray("properties");
            valueList = properties.toJavaList(ThingsModelValueItemDto.class);
        } else if (type == 2) {
            JSONArray functions = thingsModelObject.getJSONArray("functions");
            valueList = functions.toJavaList(ThingsModelValueItemDto.class);
        }

        // 查询物模型值
        ThingsModelValuesOutput deviceThings = deviceMapper.selectDeviceThingsModelValueBySerialNumber(input.getDeviceNumber());
        List<ThingsModelValueItem> thingsModelValues = JSONObject.parseArray(deviceThings.getThingsModelValue(), ThingsModelValueItem.class);

        for (int i = 0; i < input.getThingsModelValueRemarkItem().size(); i++) {
            // 赋值
            for (int j = 0; j < thingsModelValues.size(); j++) {
                if (input.getThingsModelValueRemarkItem().get(i).getId().equals(thingsModelValues.get(j).getId())) {
                    // 影子模式只更新影子值
                    if (!isShadow) {
                        thingsModelValues.get(j).setValue(String.valueOf(input.getThingsModelValueRemarkItem().get(i).getValue()));
                    }
                    thingsModelValues.get(j).setShadow(String.valueOf(input.getThingsModelValueRemarkItem().get(i).getValue()));
                    break;
                }
            }

            //日志
            for (int k = 0; k < valueList.size(); k++) {
                if (valueList.get(k).getId().equals(input.getThingsModelValueRemarkItem().get(i).getId())) {
                    valueList.get(k).setValue(input.getThingsModelValueRemarkItem().get(i).getValue());
                    // TODO 场景联动、告警规则匹配处理

                    // 添加到设备日志
                    DeviceLog deviceLog = new DeviceLog();
                    deviceLog.setDeviceId(deviceThings.getDeviceId());
                    deviceLog.setSerialNumber(deviceThings.getSerialNumber());
                    deviceLog.setDeviceName(deviceThings.getDeviceName());
                    deviceLog.setLogValue(input.getThingsModelValueRemarkItem().get(i).getValue());
                    deviceLog.setRemark(input.getThingsModelValueRemarkItem().get(i).getRemark());
                    deviceLog.setIdentity(input.getThingsModelValueRemarkItem().get(i).getId());
                    deviceLog.setIsMonitor(valueList.get(k).getIsMonitor() == null ? 0 : valueList.get(k).getIsMonitor());
                    deviceLog.setLogType(type);
                    deviceLog.setUserId(deviceThings.getUserId());
                    deviceLog.setUserName(deviceThings.getUserName());
                    deviceLog.setTenantId(deviceThings.getTenantId());
                    deviceLog.setTenantName(deviceThings.getTenantName());
                    deviceLog.setCreateTime(DateUtils.getNowDate());
                    // 1=影子模式，2=在线模式，3=其他
                    deviceLog.setMode(isShadow ? 1 : 2);
                    logService.saveDeviceLog(deviceLog);
                    break;
                }
            }
        }
        input.setStringValue(JSONObject.toJSONString(thingsModelValues));
        input.setDeviceId(deviceThings.getDeviceId());
        return deviceMapper.updateDeviceThingsModelValue(input);
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
        return deviceMapper.selectAllDeviceShortList(device);
    }

    /**
     * 查询设备简短列表
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
        for (int i = 0; i < deviceList.size(); i++) {
            JSONObject thingsModelObject = JSONObject.parseObject(thingsModelService.getCacheThingsModelByProductId(deviceList.get(i).getProductId()));
            JSONArray properties = thingsModelObject.getJSONArray("properties");
            JSONArray functions = thingsModelObject.getJSONArray("functions");
            // 物模型转换为对象中的不同类别集合
            convertJsonToCategoryList(properties, deviceList.get(i), true, false);
            convertJsonToCategoryList(functions, deviceList.get(i), true, false);
            // 置空物模型，已分配到不同类型中
            deviceList.get(i).setThingsModelValue("");
        }
        return deviceList;
    }


    /**
     * Json物模型集合转换为对象中的分类集合
     *
     * @param jsonArray  物模型集合
     * @param isOnlyTop  是否只显示置顶数据
     * @param isOnlyRead 是否设置为只读
     * @param device     设备
     */
    @Async
    public void convertJsonToCategoryList(JSONArray jsonArray, DeviceShortOutput device, boolean isOnlyTop, boolean isOnlyRead) {
        // 获取物模型值
        JSONArray thingsValueArray = JSONObject.parseArray(device.getThingsModelValue());
        for (int i = 0; i < jsonArray.size(); i++) {
            JSONObject thingsJson = jsonArray.getJSONObject(i);
            JSONObject datatypeJson = thingsJson.getJSONObject("datatype");
            ThingsModelItemBase thingsModel = new ThingsModelItemBase();
            thingsModel.setIsTop(thingsJson.getInteger("isTop"));
            // 只显示isTop数据
            if (thingsModel.getIsTop() == 0 && isOnlyTop == true) {
                continue;
            }

            thingsModel.setId(thingsJson.getString("id"));
            thingsModel.setName(thingsJson.getString("name"));
            thingsModel.setIsMonitor(thingsJson.getInteger("isMonitor") == null ? 0 : thingsJson.getInteger("isMonitor"));
            thingsModel.setType(datatypeJson.getString("type"));
            thingsModel.setValue("");
            // 获取value
            for (int j = 0; j < thingsValueArray.size(); j++) {
                if (thingsValueArray.getJSONObject(j).getString("id").equals(thingsModel.getId())) {
                    String value = thingsValueArray.getJSONObject(j).getString("value");
                    String shadow = thingsValueArray.getJSONObject(j).getString("shadow");
                    thingsModel.setValue(value);
                    thingsModel.setShadow(shadow);
                    // bool 类型默认值为0，解决移动端报错问题
                    if (thingsModel.getType().equals("bool")) {
                        thingsModel.setValue(value.equals("") ? "0" : value);
                        thingsModel.setShadow(shadow.equals("") ? "0" : shadow);
                    }
                    break;
                }
            }
            // 根据分类不同，存储到不同集合
            if (datatypeJson.getString("type").equals("decimal")) {
                DecimalModelOutput model = new DecimalModelOutput();
                BeanUtils.copyProperties(thingsModel, model);
                model.setMax(datatypeJson.getBigDecimal("max"));
                model.setMin(datatypeJson.getBigDecimal("min"));
                model.setStep(datatypeJson.getBigDecimal("step"));
                model.setUnit(datatypeJson.getString("unit"));
                if (model.getIsMonitor() == 1 || isOnlyRead == true) {
                    ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
                    BeanUtils.copyProperties(model, readonlyModel);
                    device.getReadOnlyList().add(readonlyModel);
                } else {
                    device.getDecimalList().add(model);
                }
            } else if (datatypeJson.getString("type").equals("integer")) {
                IntegerModelOutput model = new IntegerModelOutput();
                BeanUtils.copyProperties(thingsModel, model);
                model.setMax(datatypeJson.getBigDecimal("max"));
                model.setMin(datatypeJson.getBigDecimal("min"));
                model.setStep(datatypeJson.getBigDecimal("step"));
                model.setUnit(datatypeJson.getString("unit"));
                if (model.getIsMonitor() == 1 || isOnlyRead == true) {
                    ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
                    BeanUtils.copyProperties(model, readonlyModel);
                    device.getReadOnlyList().add(readonlyModel);
                } else {
                    device.getIntegerList().add(model);
                }
            } else if (datatypeJson.getString("type").equals("bool")) {
                BoolModelOutput model = new BoolModelOutput();
                BeanUtils.copyProperties(thingsModel, model);
                model.setFalseText(datatypeJson.getString("falseText"));
                model.setTrueText(datatypeJson.getString("trueText"));
                if (model.getIsMonitor() == 1 || isOnlyRead == true) {
                    ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
                    BeanUtils.copyProperties(model, readonlyModel);
                    device.getReadOnlyList().add(readonlyModel);
                } else {
                    device.getBoolList().add(model);
                }
            } else if (datatypeJson.getString("type").equals("string")) {
                StringModelOutput model = new StringModelOutput();
                BeanUtils.copyProperties(thingsModel, model);
                model.setMaxLength(datatypeJson.getInteger("maxLength"));
                if (model.getIsMonitor() == 1 || isOnlyRead == true) {
                    ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
                    BeanUtils.copyProperties(model, readonlyModel);
                    device.getReadOnlyList().add(readonlyModel);
                } else {
                    device.getStringList().add(model);
                }
            } else if (datatypeJson.getString("type").equals("array")) {
                ArrayModelOutput model = new ArrayModelOutput();
                BeanUtils.copyProperties(thingsModel, model);
                model.setArrayType(datatypeJson.getString("arrayType"));
                if (model.getIsMonitor() == 1 || isOnlyRead == true) {
                    ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
                    BeanUtils.copyProperties(model, readonlyModel);
                    device.getReadOnlyList().add(readonlyModel);
                } else {
                    device.getArrayList().add(model);
                }
            } else if (datatypeJson.getString("type").equals("enum")) {
                EnumModelOutput model = new EnumModelOutput();
                BeanUtils.copyProperties(thingsModel, model);
                List<EnumItemOutput> enumItemList = JSONObject.parseArray(datatypeJson.getString("enumList"), EnumItemOutput.class);
                model.setEnumList(enumItemList);
                if (model.getIsMonitor() == 1 || isOnlyRead == true) {
                    ReadOnlyModelOutput readonlyModel = new ReadOnlyModelOutput();
                    BeanUtils.copyProperties(model, readonlyModel);
                    device.getReadOnlyList().add(readonlyModel);
                } else {
                    device.getEnumList().add(model);
                }
            }
        }
        // 排序
        device.setReadOnlyList(device.getReadOnlyList().stream().sorted(Comparator.comparing(ThingsModelItemBase::getIsMonitor).reversed()).collect(Collectors.toList()));
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
            return device;
        }
        SysUser sysUser = getLoginUser().getUser();
        //添加设备
        device.setCreateTime(DateUtils.getNowDate());
        device.setThingsModelValue(JSONObject.toJSONString(getThingsModelDefaultValue(device.getProductId())));
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
        setLocation(user.getLoginIp(), device);

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
        deviceUserMapper.insertDeviceUser(deviceUser);
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
        device.setStatus(1);
        device.setActiveTime(DateUtils.getNowDate());
        device.setIsShadow(0);
        device.setRssi(0);
        // 1-自动定位，2-设备定位，3-自定义位置
        device.setLocationWay(1);
        device.setCreateTime(DateUtils.getNowDate());
        device.setThingsModelValue(JSONObject.toJSONString(getThingsModelDefaultValue(productId)));
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
     * 获取物模型值
     *
     * @param productId
     * @return
     */
    private List<ThingsModelValueItem> getThingsModelDefaultValue(Long productId) {
        // 获取物模型,设置默认值
        String thingsModels = thingsModelService.getCacheThingsModelByProductId(productId);
        JSONObject thingsModelObject = JSONObject.parseObject(thingsModels);
        JSONArray properties = thingsModelObject.getJSONArray("properties");
        JSONArray functions = thingsModelObject.getJSONArray("functions");
        List<ThingsModelValueItem> valueList = properties.toJavaList(ThingsModelValueItem.class);
        valueList.addAll(functions.toJavaList(ThingsModelValueItem.class));
        valueList.forEach(x -> {
            x.setValue("");
            x.setShadow("");
        });
        return valueList;
    }

    /**
     * 获取设备设置的影子
     *
     * @param device
     * @return
     */
    @Override
    public ThingsModelShadow getDeviceShadowThingsModel(Device device) {
        // 物模型
        String thingsModels = thingsModelService.getCacheThingsModelByProductId(device.getProductId());
        JSONObject thingsModelObject = JSONObject.parseObject(thingsModels);
        JSONArray properties = thingsModelObject.getJSONArray("properties");
        JSONArray functions = thingsModelObject.getJSONArray("functions");

        // 物模型值
        List<ThingsModelValueItem> thingsModelValueItems = JSONObject.parseArray(device.getThingsModelValue(), ThingsModelValueItem.class);

        // 查询出设置的影子值
        List<ThingsModelValueItem> shadowList = new ArrayList<>();
        for (int i = 0; i < thingsModelValueItems.size(); i++) {
            if (!thingsModelValueItems.get(i).getValue().equals(thingsModelValueItems.get(i).getShadow())) {
                shadowList.add(thingsModelValueItems.get(i));
                System.out.println("添加影子：" + thingsModelValueItems.get(i).getId());
            }
        }
        ThingsModelShadow shadow = new ThingsModelShadow();
        for (int i = 0; i < shadowList.size(); i++) {
            boolean isGetValue = false;
            for (int j = 0; j < properties.size(); j++) {
                if (properties.getJSONObject(j).getInteger("isMonitor") == 0 && properties.getJSONObject(j).getString("id").equals(shadowList.get(i).getId())) {
                    IdentityAndName item = new IdentityAndName(shadowList.get(i).getId(), shadowList.get(i).getShadow());
                    shadow.getProperties().add(item);
                    System.out.println("添加影子属性：" + item.getId());
                    isGetValue = true;
                    break;
                }
            }
            if (!isGetValue) {
                for (int k = 0; k < functions.size(); k++) {
                    if (functions.getJSONObject(k).getString("id").equals(shadowList.get(i).getId())) {
                        IdentityAndName item = new IdentityAndName(shadowList.get(i).getId(), shadowList.get(i).getShadow());
                        shadow.getFunctions().add(item);
                        System.out.println("添加影子功能：" + item.getId());
                        break;
                    }
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
                return AjaxResult.success("设备编号：" + device.getSerialNumber() + " 已经存在，修改失败", 0);
            }
        }
        device.setUpdateTime(DateUtils.getNowDate());
        // 未激活状态,可以修改产品以及物模型值
        if (device.getStatus() == 1) {
            device.setThingsModelValue(JSONObject.toJSONString(getThingsModelDefaultValue(device.getProductId())));
        } else {
            device.setProductId(null);
            device.setProductName(null);
        }
        deviceMapper.updateDevice(device);
        // 设备取消禁用
        if (oldDevice.getStatus() == 2 && device.getStatus() == 4) {
            // 发布设备信息
            emqxService.publishInfo(oldDevice.getProductId(), oldDevice.getSerialNumber());
        }
        return AjaxResult.success("修改成功", 1);
    }

    /**
     * 生成设备唯一编号
     *
     * @return 结果
     */
    @Override
    public String generationDeviceNum() {
        // 设备编号：D + userId + 15位随机字母和数字
        SysUser user = getLoginUser().getUser();
        String number = "D" + user.getUserId().toString() + toolService.getStringRandom(10);
        int count = deviceMapper.getDeviceNumCount(number);
        if (count == 0) {
            return number;
        } else {
            generationDeviceNum();
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
                setLocation(ipAddress, device);
            }
        }
        int result = deviceMapper.updateDeviceStatus(device);

        // 添加到设备日志
        DeviceLog deviceLog = new DeviceLog();
        deviceLog.setDeviceId(device.getDeviceId());
        deviceLog.setDeviceName(device.getDeviceName());
        deviceLog.setSerialNumber(device.getSerialNumber());
        deviceLog.setIsMonitor(0);
        deviceLog.setUserId(device.getUserId());
        deviceLog.setUserName(device.getUserName());
        deviceLog.setTenantId(device.getTenantId());
        deviceLog.setTenantName(device.getTenantName());
        deviceLog.setCreateTime(DateUtils.getNowDate());
        // 日志模式 1=影子模式，2=在线模式，3=其他
        deviceLog.setMode(3);
        if (device.getStatus() == 3) {
            deviceLog.setLogValue("1");
            deviceLog.setRemark("设备上线");
            deviceLog.setIdentity("online");
            deviceLog.setLogType(5);
        } else if (device.getStatus() == 4) {
            deviceLog.setLogValue("0");
            deviceLog.setRemark("设备离线");
            deviceLog.setIdentity("offline");
            deviceLog.setLogType(6);
        }
        logService.saveDeviceLog(deviceLog);
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
        if (deviceEntity != null) {
            // 联网方式为Wifi的需要更新用户信息（1=wifi、2=蜂窝(2G/3G/4G/5G)、3=以太网、4=其他）
            Product product = productService.selectProductByProductId(deviceEntity.getProductId());
            if (product.getNetworkMethod() == 1) {
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
            }else{
                // 其他联网设备不更新用户信息
                device.setUserId(null);
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
            // 删除定时任务
            deviceJobService.deleteJobByDeviceIds(new Long[]{deviceId});
            // 批量删除设备日志
            logService.deleteDeviceLogByDeviceNumber(device.getSerialNumber());
            // TODO 删除设备告警记录

            // 删除设备
            deviceMapper.deleteDeviceByDeviceIds(new Long[]{deviceId});
        }
        return 1;
    }
}
