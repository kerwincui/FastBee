package com.fastbee.iot.service;

import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.thingsModel.ThingsModelSimpleItem;
import com.fastbee.common.enums.DeviceStatus;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.model.*;
import com.fastbee.iot.model.ThingsModels.ThingsModelShadow;
import com.fastbee.iot.model.ThingsModels.ThingsModelValueItem;
import com.fastbee.common.core.thingsModel.ThingsModelValuesInput;
import org.quartz.SchedulerException;

import java.util.List;
import java.util.Map;

/**
 * 设备Service接口
 *
 * @author kerwincui
 * @date 2021-12-16
 */
public interface IDeviceService
{
    /**
     * 查询设备
     *
     * @param deviceId 设备主键
     * @return 设备
     */
    public Device selectDeviceByDeviceId(Long deviceId);

    /**
     * 查询设备统计信息
     *
     * @return 设备
     */
    public DeviceStatistic selectDeviceStatistic();

    /**
     * 根据设备编号查询设备
     *
     * @param serialNumber 设备主键
     * @return 设备
     */
    public Device selectDeviceBySerialNumber(String serialNumber);

    /**
     * 根据设备编号查询简洁设备
     *
     * @param serialNumber 设备主键
     * @return 设备
     */
    public Device selectShortDeviceBySerialNumber(String serialNumber);

    /**
     * 根据设备编号查询设备认证信息
     *
     * @param model 设备编号和产品ID
     * @return 设备
     */
    public ProductAuthenticateModel selectProductAuthenticate(AuthenticateInputModel model);

    /**
     * 查询设备和运行状态
     *
     * @param deviceId 设备主键
     * @return 设备
     */
    public DeviceShortOutput selectDeviceRunningStatusByDeviceId(Long deviceId,Integer slaveId);

    /**
     * 上报设备的物模型
     * @param input
     * @return
     */
    public List<ThingsModelSimpleItem> reportDeviceThingsModelValue(ThingsModelValuesInput input, int type, boolean isShadow);

    /**
     * 查询设备列表
     *
     * @param device 设备
     * @return 设备集合
     */
    public List<Device> selectDeviceList(Device device);

    /**
     * 查询未分配授权码设备列表
     *
     * @param device 设备
     * @return 设备集合
     */
    public List<Device> selectUnAuthDeviceList(Device device);

    /**
     * 查询分组可添加设备分页列表
     *
     * @param device 设备
     * @return 设备集合
     */
    public List<Device> selectDeviceListByGroup(Device device);

    /**
     * 查询所有设备简短列表
     *
     * @return 设备
     */
    public List<DeviceAllShortOutput> selectAllDeviceShortList();

    /**
     * 查询设备简短列表
     *
     * @param device 设备
     * @return 设备集合
     */
    public List<DeviceShortOutput> selectDeviceShortList(Device device);

    /**
     * 新增设备
     *
     * @param device 设备
     * @return 结果
     */
    public Device insertDevice(Device device);

    /**
     * 设备关联用户
     *
     * @param deviceRelateUserInput 设备
     * @return 结果
     */
    public AjaxResult deviceRelateUser(DeviceRelateUserInput deviceRelateUserInput);

    /**
     * 设备认证后自动添加设备
     *
     * @return 结果
     */
    public int insertDeviceAuto(String serialNumber,Long userId,Long productId);

    /**
     * 获取设备设置的影子
     * @param device
     * @return
     */
    public ThingsModelShadow getDeviceShadowThingsModel(Device device);

    /**
     * 修改设备
     *
     * @param device 设备
     * @return 结果
     */
    public AjaxResult updateDevice(Device device);

    /**
     * 更新设备状态和定位
     * @param device 设备
     * @return 结果
     */
    public int updateDeviceStatusAndLocation(Device device,String ipAddress);

    /**
     * 更新设备状态
     * @param device 设备
     * @return 结果
     */
    public int updateDeviceStatus(Device device);

    /**
     * 更新固件版本
     * @param device
     * @return
     */
    public int updateDeviceFirmwareVersion(Device device);

    /**
     * 上报设备信息
     * @param device 设备
     * @return 结果
     */
    public int reportDevice(Device device,Device deviceentity);

    /**
     * 删除设备
     *
     * @param deviceId 需要删除的设备主键集合
     * @return 结果
     */
    public int deleteDeviceByDeviceId(Long deviceId) throws SchedulerException;

    /**
     * 根据网关编号删除子设备
     * @param gwCode
     */
    public void deleteSubDevice(String gwCode);

    /**
     * 缓存设备状态到redis
     *
     * @return
     */
    public List<ThingsModelValueItem> cacheDeviceStatus(Long productId, String serialNumber);

    /**
     * 生成设备唯一编号
     * @return 结果
     */
    public String generationDeviceNum(Integer type);

    /**
     * 重置设备状态
     * @return 结果
     */
    public int resetDeviceStatus(String deviceNum);

    /**
     * 根据设备编号查询协议编码
     * @param serialNumber 设备编号
     * @return
     */
    public Map<String,Object> selectProtocolBySerialNumber(String serialNumber);

    /**
     * 查询产品下所有设备，返回设备编号
     * @param productId 产品id
     * @return
     */
    public List<Device> selectDevicesByProductId(Long productId,Integer hasSub);

    /**
     * 查询子设备总数
     * @param gwDevCode 网关编号
     * @return 数量
     */
    public Integer getSubDeviceCount(String gwDevCode);

    /**
     * 批量更新设备状态
     * @param serialNumbers 设备ids
     * @param status 状态
     */
    public void batchChangeStatus(List<String> serialNumbers , DeviceStatus status);

    /**
     * 查询在线的modbus网关设备
     * @return
     */
    public List<Device> selectOnlineModbusDevices();

    /**
     * 根据设备编号查询设备信息 -不带缓存物模型值
     * @param serialNumber
     * @return
     */
    public Device selectDeviceNoModel(String serialNumber);

    /**
     * 获取设备MQTT连接参数
     * @param deviceId 设备id
     * @return
     */
    public DeviceMqttConnectVO getMqttConnectData(Long deviceId);
}
