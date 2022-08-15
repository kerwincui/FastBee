package com.ruoyi.iot.mapper;

import com.ruoyi.iot.domain.Device;
import com.ruoyi.iot.model.*;
import com.ruoyi.iot.model.ThingsModels.ThingsModelValuesInput;
import com.ruoyi.iot.model.ThingsModels.ThingsModelValuesOutput;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 设备Mapper接口
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@Repository
public interface DeviceMapper 
{
    /**
     * 查询设备
     * 
     * @param deviceId 设备主键
     * @return 设备
     */
    public Device selectDeviceByDeviceId(Long deviceId);

    /**
     * 查询设备和产品总数
     *
     * @return 设备
     */
    public DeviceStatistic selectDeviceProductAlertCount(Device device);

    /**
     * 根据设备编号查询设备
     *
     * @param serialNumber 设备主键
     * @return 设备
     */
    public Device selectDeviceBySerialNumber(String serialNumber);


    /**
     * 根据设备编号查询设备数量
     *
     * @param serialNumber 设备主键
     * @return 设备
     */
    public int selectDeviceCountBySerialNumber(String serialNumber);

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
    public ProductAuthenticateModel selectProductAuthenticate(AuthenticateInputModel model);

    /**
     * 查询设备和运行状态
     *
     * @param deviceId 设备主键
     * @return 设备
     */
    public DeviceShortOutput selectDeviceRunningStatusByDeviceId(Long deviceId);

    /**
     * 查询设备的物模型值
     *
     * @param serialNumber 设备编号
     * @return 设备
     */
    public ThingsModelValuesOutput selectDeviceThingsModelValueBySerialNumber(String serialNumber);

    /**
     * 修改设备的物模型值
     *
     * @param input 设备ID和物模型值
     * @return 结果
     */
    public int updateDeviceThingsModelValue(ThingsModelValuesInput input);


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
     * 查询设备简短列表
     *
     * @param device 设备
     * @return 设备集合
     */
    public List<DeviceShortOutput> selectDeviceShortList(Device device);

    /**
     * 查询所有设备简短列表
     *
     * @return 设备集合
     */
    public List<DeviceAllShortOutput> selectAllDeviceShortList(Device device);

    /**
     * 新增设备
     * 
     * @param device 设备
     * @return 结果
     */
    public int insertDevice(Device device);

    /**
     * 修改设备
     * 
     * @param device 设备
     * @return 结果
     */
    public int updateDevice(Device device);

    /**
     * 更新设备状态
     *
     * @param device 设备
     * @return 结果
     */
    public int updateDeviceStatus(Device device);

    /**
     * 通过设备编号修改设备
     *
     * @param device 设备
     * @return 结果
     */
    public int updateDeviceBySerialNumber(Device device);

    /**
     * 删除设备
     * 
     * @param deviceId 设备主键
     * @return 结果
     */
    public int deleteDeviceByDeviceId(Long deviceId);

    /**
     * 批量删除设备
     * 
     * @param deviceIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteDeviceByDeviceIds(Long[] deviceIds);

    /**
     * 查询设备序列号的数量
     * @param deviceNum
     * @return
     */
    public int getDeviceNumCount(String deviceNum);

    /**
     * 根据设备IDS删除设备分组
     * @param deviceIds
     * @return
     */
    public int deleteDeviceGroupByDeviceId(UserIdDeviceIdModel userDeviceGroupIdModel);

    /**
     * 重置设备状态
     * @return 结果
     */
    public int resetDeviceStatus(String deviceNum);

}
