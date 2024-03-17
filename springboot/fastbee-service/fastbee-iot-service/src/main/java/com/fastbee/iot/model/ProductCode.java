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
}
