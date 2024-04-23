package com.fastbee.iot.ruleEngine;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MsgContext {

    /** 消息主题 */
    private String topic;

    /** 消息内容 */
    private String payload;
    /**
     * 设备编号
     */
    private String serialNumber;
    /**
     * 产品id
     */
    private Long productId;
    /**
     * 协议编码
     */
    private String protocolCode;
}
