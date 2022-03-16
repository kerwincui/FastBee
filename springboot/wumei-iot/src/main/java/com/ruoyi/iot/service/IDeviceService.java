package com.ruoyi.iot.service;

import com.ruoyi.iot.domain.Device;
import com.ruoyi.iot.model.*;
import com.ruoyi.iot.model.ThingsModels.ThingsModelShadow;
import com.ruoyi.iot.model.ThingsModels.ThingsModelValuesInput;
import org.quartz.SchedulerException;

import java.util.List;

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
     * 根据设备编号查询设备
     *
     * @param serialNumber 设备主键
     * @return 设备
     */
    public Device selectDeviceBySerialNumber(String serialNumber);

    /**
     * 根据设备编号查询简介设备
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
    public DeviceAuthenticateModel selectDeviceAuthenticate(AuthenticateInputModel model);

    /**
     * 查询设备和运行状态
     *
     * @param deviceId 设备主键
     * @return 设备
     */
    public DeviceShortOutput selectDeviceRunningStatusByDeviceId(Long deviceId);

    /**
     * 上报设备的物模型
     * @param input
     * @return
     */
    public int reportDeviceThingsModelValue(ThingsModelValuesInput input,int type,boolean isShadow);

    /**
     * 查询设备列表
     * 
     * @param device 设备
     * @return 设备集合
     */
    public List<Device> selectDeviceList(Device device);

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
    public int updateDevice(Device device);

    /**
     * 更新设备状态
     * @param device 设备
     * @return 结果
     */
    public int updateDeviceStatusAndLocation(Device device,String ipAddress);

    /**
     * 上报设备信息
     * @param device 设备
     * @return 结果
     */
    public int reportDevice(Device device);

    /**
     * 批量删除设备
     * 
     * @param deviceIds 需要删除的设备主键集合
     * @return 结果
     */
    public int deleteDeviceByDeviceIds(Long[] deviceIds) throws SchedulerException;

    /**
     * 删除设备信息
     * 
     * @param deviceId 设备主键
     * @return 结果
     */
    public int deleteDeviceByDeviceId(Long deviceId);

    /**
     * 生成设备唯一编号
     * @return 结果
     */
    public String generationDeviceNum();
}
