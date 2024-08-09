package com.fastbee.sip.mapper;

import com.fastbee.sip.domain.SipDeviceChannel;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 监控设备通道信息Mapper接口
 *
 * @author zhuangpeng.li
 * @date 2022-10-07
 */
@Repository
public interface SipDeviceChannelMapper {
    /**
     * 查询监控设备通道信息
     *
     * @param channelId 监控设备通道信息主键
     * @return 监控设备通道信息
     */
    public SipDeviceChannel selectSipDeviceChannelById(Long channelId);

    public SipDeviceChannel selectSipDeviceChannelByChannelSipId(String channelSipId);

    public List<SipDeviceChannel> selectSipDeviceChannelByDeviceSipId(String deviceSipId);

    /**
     * 查询监控设备通道信息列表
     *
     * @param sipDeviceChannel 监控设备通道信息
     * @return 监控设备通道信息集合
     */
    public List<SipDeviceChannel> selectSipDeviceChannelList(SipDeviceChannel sipDeviceChannel);
    List<SipDeviceChannel> selectChannelWithCivilCodeAndLength(@Param("deviceSipId") String deviceSipId, @Param("parentId") String parentId, @Param("length")Integer length);

    public List<SipDeviceChannel> selectChannelByCivilCode(@Param("deviceSipId") String deviceSipId, @Param("parentId") String parentId);
    List<SipDeviceChannel> selectChannelWithoutCiviCode(String deviceId);
    Integer getChannelMinLength(String deviceSipId);
    /**
     * 新增监控设备通道信息
     *
     * @param sipDeviceChannel 监控设备通道信息
     * @return 结果
     */
    public int insertSipDeviceChannel(SipDeviceChannel sipDeviceChannel);

    /**
     * 修改监控设备通道信息
     *
     * @param sipDeviceChannel 监控设备通道信息
     * @return 结果
     */
    public int updateSipDeviceChannel(SipDeviceChannel sipDeviceChannel);

    public int updateChannelStreamId(SipDeviceChannel sipDeviceChannel);

    /**
     * 删除监控设备通道信息
     *
     * @param channelId 监控设备通道信息主键
     * @return 结果
     */
    public int deleteSipDeviceChannelById(Long channelId);

    /**
     * 批量删除监控设备通道信息
     *
     * @param channelIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSipDeviceChannelByIds(Long[] channelIds);

    public int deleteSipDeviceChannelByDeviceId(String deviceSipId);
}
