package com.fastbee.common.core.mq.message;

import lombok.Data;

/**
 * 网关子设备model
 * @author gsb
 * @date 2022/10/10 10:18
 */
@Data
public class SubDeviceMessage {
    /*子设备编号或编码*/
    private String serialNumber;
    /*数据*/
    private byte[] data;
    /*消息id*/
    private String messageId;
}
