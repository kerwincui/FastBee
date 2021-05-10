package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.IotDeviceMapper;
import com.ruoyi.system.domain.IotDevice;
import com.ruoyi.system.service.IIotDeviceService;

/**
 * 设备Service业务层处理
 * 
 * @author kerwincui
 * @date 2021-05-06
 */
@Service
public class IotDeviceServiceImpl implements IIotDeviceService 
{
    @Autowired
    private IotDeviceMapper iotDeviceMapper;

    /**
     * 查询设备
     * 
     * @param deviceId 设备ID
     * @return 设备
     */
    @Override
    public IotDevice selectIotDeviceById(Long deviceId)
    {
        return iotDeviceMapper.selectIotDeviceById(deviceId);
    }

    /**
     * 查询设备列表
     * 
     * @param iotDevice 设备
     * @return 设备
     */
    @Override
    public List<IotDevice> selectIotDeviceList(IotDevice iotDevice)
    {
        return iotDeviceMapper.selectIotDeviceList(iotDevice);
    }

    /**
     * 新增设备
     * 
     * @param iotDevice 设备
     * @return 结果
     */
    @Override
    public int insertIotDevice(IotDevice iotDevice)
    {
        iotDevice.setCreateTime(DateUtils.getNowDate());
        return iotDeviceMapper.insertIotDevice(iotDevice);
    }

    /**
     * 修改设备
     * 
     * @param iotDevice 设备
     * @return 结果
     */
    @Override
    public int updateIotDevice(IotDevice iotDevice)
    {
        iotDevice.setUpdateTime(DateUtils.getNowDate());
        return iotDeviceMapper.updateIotDevice(iotDevice);
    }

    /**
     * 批量删除设备
     * 
     * @param deviceIds 需要删除的设备ID
     * @return 结果
     */
    @Override
    public int deleteIotDeviceByIds(Long[] deviceIds)
    {
        return iotDeviceMapper.deleteIotDeviceByIds(deviceIds);
    }

    /**
     * 删除设备信息
     * 
     * @param deviceId 设备ID
     * @return 结果
     */
    @Override
    public int deleteIotDeviceById(Long deviceId)
    {
        return iotDeviceMapper.deleteIotDeviceById(deviceId);
    }
}
