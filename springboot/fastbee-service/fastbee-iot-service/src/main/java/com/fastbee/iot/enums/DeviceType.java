package com.fastbee.iot.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum DeviceType {
    /**
     * 未知
     */
    UNKNOWN(0, "未知"),
    /**
     * 直连设备
     */
    DIRECT_DEVICE(1, "直连设备"),
    /**
     * 网关设备
     */
    GATEWAY(2, "网关设备"),
    /**
     * 监控设备
     */
    CAMERA(3, "监控设备");

    private int code;
    private String desc;
}
