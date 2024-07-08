package com.fastbee.sip.server.msg;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fastbee.sip.server.SipMessage;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class GB28181Device implements SipMessage {
    @JsonProperty("DeviceID")
    private String id;

    /**
     * 设备名
     */
    @JsonProperty("DeviceName")
    private String name;

    /**
     * 生产厂商
     */
    @JsonProperty("Manufacturer")
    private String manufacturer;

    /**
     * 型号
     */
    @JsonProperty("Model")
    private String model;

    /**
     * 固件版本
     */
    @JsonProperty("Firmware")
    private String firmware;

    /**
     * 传输协议
     * UDP/TCP
     */
    private String transport;

    /**
     * 数据流传输模式
     */
    private StreamMode streamMode = StreamMode.UDP;

    /**
     * 访问地址
     */
    private String host;

    /**
     * 访问端口
     */
    private int port;

    /**
     * 是否在线
     */
    private boolean online;

    @JsonProperty("Channel")
    private int channelNumber;

    /**
     * 通道列表
     */
    private List<String> channelList;

    @JsonProperty("SN")
    private String sn;

    /**
     * 心跳间隔
     */
    private long heartBeatInterval = 300;

    @Override
    public String getDeviceId() {
        return null;
    }

    @Override
    public String getSn() {
        return null;
    }

    public enum StreamMode {
        UDP,
        TCP_ACTIVE,//主动模式
        TCP_PASSIVE//被动模式
    }

    public String getHostAndPort() {
        return getHost() + ":" + getPort();
    }

}
