package com.fastbee.data.service.impl;

import com.fastbee.base.session.Session;
import com.fastbee.common.enums.DeviceStatus;
import com.fastbee.framework.mybatis.helper.DataBaseHelper;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.model.DeviceStatusVO;
import com.fastbee.iot.service.IDeviceService;
import com.fastbee.mq.service.IMqttMessagePublish;
import com.fastbee.mqtt.manager.SessionManger;
import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.domain.SipDeviceChannel;
import com.fastbee.sip.enums.DeviceChannelStatus;
import com.fastbee.sip.mapper.SipDeviceChannelMapper;
import com.fastbee.sip.mapper.SipDeviceMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

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

    @Resource
    private IMqttMessagePublish mqttMessagePublish;

    private Boolean enabled = true;

    public void updateSipDeviceOnlineStatus(Integer timeout) {
        String checkTimeCondition = DataBaseHelper.checkTime(timeout);
        List<SipDevice> devs = sipDeviceMapper.selectOfflineSipDevice(checkTimeCondition);
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

    /**
     * 定期同步设备状态
     *  1.将异常在线设备变更为离线状态
     *  2.将离线设备但实际在线设备变更为在线
     */
    public void syncDeviceStatus() {
        if (enabled) {
            //获取所有已激活并不是禁用的设备
            List<DeviceStatusVO> deviceStatusVOList = deviceService.selectDeviceActive();
            if (!CollectionUtils.isEmpty(deviceStatusVOList)) {
                for (DeviceStatusVO statusVO : deviceStatusVOList) {
                    Session session = SessionManger.getSession(statusVO.getSerialNumber());
                    Device device = new Device();
                    device.setSerialNumber(statusVO.getSerialNumber());
                    device.setRssi(statusVO.getRssi());
                    device.setProductId(statusVO.getProductId());
                    device.setIsShadow(statusVO.getIsShadow());
                    // 如果session中设备在线，数据库状态离线 ,则更新设备的状态为在线
                    if (!Objects.isNull(session) && statusVO.getStatus() == DeviceStatus.OFFLINE.getType()) {
                        device.setStatus(DeviceStatus.ONLINE.getType());
                        deviceService.updateDeviceStatus(device);
                        mqttMessagePublish.pushDeviceStatus(device, DeviceStatus.ONLINE);
                    }
                    if (Objects.isNull(session) && statusVO.getStatus() == DeviceStatus.ONLINE.getType()) {
                        device.setStatus(DeviceStatus.OFFLINE.getType());
                        deviceService.updateDeviceStatus(device);
                        mqttMessagePublish.pushDeviceStatus(device, DeviceStatus.OFFLINE);
                    }
                }
            }
        }
    }
}
