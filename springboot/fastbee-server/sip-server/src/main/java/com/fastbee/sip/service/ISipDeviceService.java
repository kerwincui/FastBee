package com.fastbee.sip.service;

import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.domain.SipDeviceChannel;
import com.fastbee.sip.model.BaseTree;

import java.util.List;

/**
 * 监控设备Service接口
 *
 * @author zhuangpeng.li
 * @date 2022-10-07
 */
public interface ISipDeviceService
{
    boolean exists(String sipId);
    boolean updateDevice(SipDevice device);
    /**
     * 查询监控设备
     *
     * @param deviceId 监控设备主键
     * @return 监控设备
     */
    public SipDevice selectSipDeviceByDeviceId(Long deviceId);
    public SipDevice selectSipDeviceBySipId(String sipId);
    /**
     * 查询监控设备列表
     *
     * @param sipDevice 监控设备
     * @return 监控设备集合
     */
    public List<SipDevice> selectSipDeviceList(SipDevice sipDevice);
    public List<BaseTree<SipDeviceChannel>> selectSipDeviceChannelList(String deviceId);
    /**
     * 新增监控设备
     *
     * @param sipDevice 监控设备
     * @return 结果
     */
    public int insertSipDevice(SipDevice sipDevice);

    /**
     * 修改监控设备
     *
     * @param sipDevice 监控设备
     * @return 结果
     */
    public int updateSipDevice(SipDevice sipDevice);

    public int updateSipDeviceStatus(SipDevice sipDevice);

    /**
     * 批量删除监控设备
     *
     * @param deviceIds 需要删除的监控设备主键集合
     * @return 结果
     */
    public int deleteSipDeviceByDeviceIds(Long[] deviceIds);

    /**
     * 删除监控设备信息
     *
     * @param deviceId 监控设备主键
     * @return 结果
     */
    public int deleteSipDeviceByDeviceId(String deviceId);
    public int deleteSipDeviceBySipId(String SipId);
}
