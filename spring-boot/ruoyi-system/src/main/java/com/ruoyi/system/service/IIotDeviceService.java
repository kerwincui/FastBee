package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.IotDevice;
import com.ruoyi.system.domain.vo.IotDeviceListDto;

/**
 * 设备Service接口
 * 
 * @author kerwincui
 * @date 2021-05-06
 */
public interface IIotDeviceService 
{
    /**
     * 查询设备
     * 
     * @param deviceId 设备ID
     * @return 设备
     */
    public IotDevice selectIotDeviceById(Long deviceId);

    /**
     * 根据编号查询设备
     */
    public IotDevice selectIotDeviceByNum(String deviceNum);

    /**
     * 查询设备列表
     * 
     * @param iotDevice 设备
     * @return 设备集合
     */
    public List<IotDeviceListDto> selectIotDeviceList(IotDevice iotDevice);

    /**
     * 新增设备
     * 
     * @param iotDevice 设备
     * @return 结果
     */
    public int insertIotDevice(IotDevice iotDevice);

    /**
     * 修改设备
     * 
     * @param iotDevice 设备
     * @return 结果
     */
    public int updateIotDevice(IotDevice iotDevice);

    /**
     * 批量删除设备
     * 
     * @param deviceIds 需要删除的设备ID
     * @return 结果
     */
    public int deleteIotDeviceByIds(Long[] deviceIds);

    /**
     * 删除设备信息
     * 
     * @param deviceId 设备ID
     * @return 结果
     */
    public int deleteIotDeviceById(Long deviceId);
}
