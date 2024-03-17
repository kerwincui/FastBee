package com.fastbee.base.util;

import com.fastbee.common.core.mq.DeviceStatusBo;
import com.fastbee.common.enums.DeviceStatus;
import com.fastbee.common.utils.DateUtils;
import io.netty.channel.Channel;

import java.net.InetSocketAddress;

/**
 * 设备信息工具类
 * @author bill
 */
public class DeviceUtils {




    /*构造返回MQ的设备状态model*/
    public static DeviceStatusBo buildStatusMsg(Channel channel, String clientId, DeviceStatus status, String ip){
        InetSocketAddress address = (InetSocketAddress) channel.remoteAddress();
        return DeviceStatusBo.builder()
                .serialNumber(clientId)
                .status(status)
                .ip(ip)
                .hostName(address.getHostName())
                .port(address.getPort())
                .timestamp(DateUtils.getNowDate()).build();
    }
}
