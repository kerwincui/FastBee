package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.IotDeviceSetMapper;
import com.ruoyi.system.domain.IotDeviceSet;
import com.ruoyi.system.service.IIotDeviceSetService;

/**
 * 设备配置Service业务层处理
 * 
 * @author kerwincui
 * @date 2021-05-06
 */
@Service
public class IotDeviceSetServiceImpl implements IIotDeviceSetService 
{
    @Autowired
    private IotDeviceSetMapper iotDeviceSetMapper;

    /**
     * 查询设备配置
     * 
     * @param deviceConfigId 设备配置ID
     * @return 设备配置
     */
    @Override
    public IotDeviceSet selectIotDeviceSetById(Long deviceSetId)
    {
        return iotDeviceSetMapper.selectIotDeviceSetById(deviceSetId);
    }

    /**
     * 查询最新设备配置
     *
     * @param deviceId 设备ID
     * @return 设备配置
     */
    @Override
    public IotDeviceSet selectIotDeviceSetByDeviceId(Long deviceId)
    {
        return iotDeviceSetMapper.selectIotDeviceSetByDeviceId(deviceId);
    }

    /**
     * 查询设备配置列表
     * 
     * @param iotDeviceSet 设备配置
     * @return 设备配置
     */
    @Override
    public List<IotDeviceSet> selectIotDeviceSetList(IotDeviceSet iotDeviceSet)
    {
        return iotDeviceSetMapper.selectIotDeviceSetList(iotDeviceSet);
    }

    /**
     * 新增设备配置
     * 
     * @param iotDeviceSet 设备配置
     * @return 结果
     */
    @Override
    public int insertIotDeviceSet(IotDeviceSet iotDeviceSet)
    {
        iotDeviceSet.setCreateTime(DateUtils.getNowDate());
        return iotDeviceSetMapper.insertIotDeviceSet(iotDeviceSet);
    }

    /**
     * 修改设备配置
     * 
     * @param iotDeviceSet 设备配置
     * @return 结果
     */
    @Override
    public int updateIotDeviceSet(IotDeviceSet iotDeviceSet)
    {
        iotDeviceSet.setUpdateTime(DateUtils.getNowDate());
        return iotDeviceSetMapper.updateIotDeviceSet(iotDeviceSet);
    }

    /**
     * 批量删除设备配置
     * 
     * @param deviceConfigIds 需要删除的设备配置ID
     * @return 结果
     */
    @Override
    public int deleteIotDeviceSetByIds(Long[] deviceConfigIds)
    {
        return iotDeviceSetMapper.deleteIotDeviceSetByIds(deviceConfigIds);
    }

    /**
     * 删除设备配置信息
     * 
     * @param deviceConfigId 设备配置ID
     * @return 结果
     */
    @Override
    public int deleteIotDeviceSetById(Long deviceConfigId)
    {
        return iotDeviceSetMapper.deleteIotDeviceSetById(deviceConfigId);
    }
}
