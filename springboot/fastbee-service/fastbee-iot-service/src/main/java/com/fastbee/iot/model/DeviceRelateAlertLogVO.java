package com.fastbee.iot.model;

import lombok.Data;

/**
 * @author fastb
 * @date 2023-09-13 11:18
 */
@Data
public class DeviceRelateAlertLogVO {

    /**
     * 设备ID
     */
    private Long deviceId;

    /**
     * 设备编号
     */
    private String serialNumber;

    /**
     * 设备名称
     */
    private String deviceName;

    /**
     * 用户ID
     */
    private Long userId;
}
