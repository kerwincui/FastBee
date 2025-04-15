package com.fastbee.iot.ruleEngine;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MsgContext {

    private static Logger logger = LoggerFactory.getLogger("script");

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
