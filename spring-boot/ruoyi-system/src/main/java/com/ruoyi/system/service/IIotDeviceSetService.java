package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.IotDeviceSet;

/**
 * 设备配置Service接口
 * 
 * @author kerwincui
 * @date 2021-05-06
 */
public interface IIotDeviceSetService 
{
    /**
     * 查询设备配置
     * 
     * @param deviceConfigId 设备配置ID
     * @return 设备配置
     */
    public IotDeviceSet selectIotDeviceSetById(Long deviceSetId);

    /**
     * 查询设备最新配置
     *
     * @param deviceId 设备ID
     * @return 设备配置
     */
    public IotDeviceSet selectIotDeviceSetByDeviceId(Long deviceId);

    /**
     * 查询设备配置列表
     * 
     * @param iotDeviceSet 设备配置
     * @return 设备配置集合
     */
    public List<IotDeviceSet> selectIotDeviceSetList(IotDeviceSet iotDeviceSet);

    /**
     * 新增设备配置
     * 
     * @param iotDeviceSet 设备配置
     * @return 结果
     */
    public int insertIotDeviceSet(IotDeviceSet iotDeviceSet);

    /**
     * 修改设备配置
     * 
     * @param iotDeviceSet 设备配置
     * @return 结果
     */
    public int updateIotDeviceSet(IotDeviceSet iotDeviceSet);

    /**
     * 批量删除设备配置
     * 
     * @param deviceConfigIds 需要删除的设备配置ID
     * @return 结果
     */
    public int deleteIotDeviceSetByIds(Long[] deviceConfigIds);

    /**
     * 删除设备配置信息
     * 
     * @param deviceConfigId 设备配置ID
     * @return 结果
     */
    public int deleteIotDeviceSetById(Long deviceConfigId);
}
