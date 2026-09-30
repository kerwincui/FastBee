package com.fastbee.iot.model;


import lombok.Data;

/**
 * @author gsb
 * @date 2023/9/4 17:23
 */
@Data
public class ProductCode {

    /**
     * 产品id
     */
    private Long productId;
    /**
     * 协议编号
     */
    private String protocolCode;
    /**
     * 设备归属用户id，用于校验 MQTT 客户端是否有权操作该设备
     */
    private Long userId;
    /**
     * 设备归属租户id
     */
    private Long tenantId;
}
