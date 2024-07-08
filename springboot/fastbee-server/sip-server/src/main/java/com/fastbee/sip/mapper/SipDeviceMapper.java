package com.fastbee.sip.mapper;

import com.fastbee.sip.domain.SipDevice;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 监控设备Mapper接口
 *
 * @author zhuangpeng.li
 * @date 2022-10-07
 */
@Repository
public interface SipDeviceMapper
{
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
    public List<SipDevice> selectOfflineSipDevice(Integer timeout);

    /**
     * 新增监控设备
     *
     * @param sipDevice 监控设备
     * @return 结果
     */
    int insertSipDevice(SipDevice sipDevice);

    /**
     * 修改监控设备
     *
     * @param sipDevice 监控设备
     * @return 结果
     */
    int updateSipDevice(SipDevice sipDevice);

    /**
     * 更新设备状态
     *
     * @param sipDevice 设备
     * @return 结果
     */
    public int updateSipDeviceStatus(SipDevice sipDevice);

    /**
     * 删除监控设备
     *
     * @param deviceId 监控设备主键
     * @return 结果
     */
    public int deleteSipDeviceByDeviceId(Long deviceId);

    /**
     * 批量删除监控设备
     *
     * @param deviceIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSipDeviceByDeviceIds(Long[] deviceIds);

    public int deleteSipDeviceByByDeviceSipId(String deviceSipId);
}
