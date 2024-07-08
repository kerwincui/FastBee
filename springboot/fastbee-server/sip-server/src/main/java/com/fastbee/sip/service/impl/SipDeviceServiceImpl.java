package com.fastbee.sip.service.impl;

import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.service.IDeviceService;
import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.domain.SipDeviceChannel;
import com.fastbee.sip.mapper.SipDeviceChannelMapper;
import com.fastbee.sip.mapper.SipDeviceMapper;
import com.fastbee.sip.model.BaseTree;
import com.fastbee.sip.service.ISipDeviceChannelService;
import com.fastbee.sip.service.ISipDeviceService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 监控设备Service业务层处理
 *
 * @author zhuangpeng.li
 * @date 2022-10-07
 */
@Service
@Slf4j
public class SipDeviceServiceImpl implements ISipDeviceService
{
    @Autowired
    private SipDeviceMapper sipDeviceMapper;

    @Autowired
    private SipDeviceChannelMapper sipDeviceChannelMapper;

    @Autowired
    private ISipDeviceChannelService sipDeviceChannelService;

    @Autowired
    private IDeviceService deviceService;

    @Override
    public boolean exists(String sipId) {
        return sipDeviceMapper.selectSipDeviceBySipId(sipId) != null;
    }

    @Override
    public boolean updateDevice(SipDevice device) {
        SipDevice devicetemp = sipDeviceMapper.selectSipDeviceBySipId(device.getDeviceSipId());
        if (devicetemp == null) {
            return sipDeviceMapper.insertSipDevice(device) > 0;
        }else {
            device.setDeviceId(devicetemp.getDeviceId());
            return sipDeviceMapper.updateSipDevice(device) > 0;
        }
    }

    /**
     * 查询监控设备
     *
     * @param deviceId 监控设备主键
     * @return 监控设备
     */
    @Override
    public SipDevice selectSipDeviceByDeviceId(Long deviceId)
    {
        return sipDeviceMapper.selectSipDeviceByDeviceId(deviceId);
    }

    @Override
    public SipDevice selectSipDeviceBySipId(String sipId)
    {
        return sipDeviceMapper.selectSipDeviceBySipId(sipId);
    }
    /**
     * 查询监控设备列表
     *
     * @param sipDevice 监控设备
     * @return 监控设备
     */
    @Override
    public List<SipDevice> selectSipDeviceList(SipDevice sipDevice)
    {
        return sipDeviceMapper.selectSipDeviceList(sipDevice);
    }

    @Override
    public List<BaseTree<SipDeviceChannel>> selectSipDeviceChannelList(String deviceId) {
        return sipDeviceChannelService.queryVideoDeviceTree(deviceId,null,false);
    }

    /**
     * 新增监控设备
     *
     * @param sipDevice 监控设备
     * @return 结果
     */
    @Override
    public int insertSipDevice(SipDevice sipDevice)
    {
        sipDevice.setCreateTime(DateUtils.getNowDate());
        return sipDeviceMapper.insertSipDevice(sipDevice);
    }

    /**
     * 修改监控设备
     *
     * @param sipDevice 监控设备
     * @return 结果
     */
    @Override
    public int updateSipDevice(SipDevice sipDevice)
    {
        sipDevice.setUpdateTime(DateUtils.getNowDate());
        return sipDeviceMapper.updateSipDevice(sipDevice);
    }

    @Override
    public int updateSipDeviceStatus(SipDevice sipDevice) {
        sipDevice.setUpdateTime(DateUtils.getNowDate());
        return sipDeviceMapper.updateSipDeviceStatus(sipDevice);
    }

    /**
     * 批量删除监控设备
     *
     * @param deviceIds 需要删除的监控设备主键
     * @return 结果
     */
    @Override
    public int deleteSipDeviceByDeviceIds(Long[] deviceIds)
    {
        return sipDeviceMapper.deleteSipDeviceByDeviceIds(deviceIds);
    }

    /**
     * 删除监控设备信息
     *
     * @param deviceId 监控设备主键
     * @return 结果
     */
    @Override
    public int deleteSipDeviceByDeviceId(String deviceId)
    {
        return sipDeviceMapper.deleteSipDeviceByDeviceId(Long.valueOf(deviceId));
    }

    @Override
    public int deleteSipDeviceBySipId(String SipId)
    {
        sipDeviceMapper.deleteSipDeviceByByDeviceSipId(SipId);
        return sipDeviceChannelMapper.deleteSipDeviceChannelByDeviceId(SipId);
    }
}
