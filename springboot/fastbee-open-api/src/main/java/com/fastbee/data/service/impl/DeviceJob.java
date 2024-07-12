package com.fastbee.data.service.impl;

import com.fastbee.iot.domain.Device;
import com.fastbee.iot.service.IDeviceService;
import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.domain.SipDeviceChannel;
import com.fastbee.sip.enums.DeviceChannelStatus;
import com.fastbee.sip.mapper.SipDeviceChannelMapper;
import com.fastbee.sip.mapper.SipDeviceMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

@Component
@Slf4j
public class DeviceJob {

    @Resource
    private IDeviceService deviceService;

    @Autowired
    private SipDeviceMapper sipDeviceMapper;

    @Autowired
    private SipDeviceChannelMapper sipDeviceChannelMapper;

    public void updateSipDeviceOnlineStatus(Integer timeout) {
        List<SipDevice> devs = sipDeviceMapper.selectOfflineSipDevice(timeout);
        devs.forEach(item -> {
            if (!Objects.equals(item.getDeviceSipId(), "")) {
                //更新iot设备状态
                Device dev = deviceService.selectDeviceBySerialNumber(item.getDeviceSipId());
                if (dev != null && dev.getStatus() == 3) {
                    log.warn("定时任务：=>设备:{} 已经下线，设备超过{}秒没上线！", item.getDeviceSipId(), timeout);
                    dev.setStatus(4);
                    deviceService.updateDeviceStatusAndLocation(dev, "");
                }
                //更新通道状态
                List<SipDeviceChannel> channels = sipDeviceChannelMapper.selectSipDeviceChannelByDeviceSipId(item.getDeviceSipId());
                channels.forEach(citem -> {
                    citem.setStatus(DeviceChannelStatus.offline.getValue());
                    sipDeviceChannelMapper.updateSipDeviceChannel(citem);
                });
            }
        });
    }
}
