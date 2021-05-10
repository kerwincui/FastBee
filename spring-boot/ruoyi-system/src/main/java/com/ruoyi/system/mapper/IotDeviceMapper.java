package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.IotDevice;

/**
 * 设备Mapper接口
 * 
 * @author kerwincui
 * @date 2021-05-06
 */
public interface IotDeviceMapper 
{
    /**
     * 查询设备
     * 
     * @param deviceId 设备ID
     * @return 设备
     */
    public IotDevice selectIotDeviceById(Long deviceId);

    /**
     * 查询设备列表
     * 
     * @param iotDevice 设备
     * @return 设备集合
     */
    public List<IotDevice> selectIotDeviceList(IotDevice iotDevice);

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
     * 删除设备
     * 
     * @param deviceId 设备ID
     * @return 结果
     */
    public int deleteIotDeviceById(Long deviceId);

    /**
     * 批量删除设备
     * 
     * @param deviceIds 需要删除的数据ID
     * @return 结果
     */
    public int deleteIotDeviceByIds(Long[] deviceIds);
}
