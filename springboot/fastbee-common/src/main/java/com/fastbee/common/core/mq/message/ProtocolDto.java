package com.fastbee.common.core.mq.message;

import lombok.Data;

/**
 * 协议bean
 * @author gsb
 * @date 2022/10/25 14:54
 */
@Data
public class ProtocolDto {

    /**协议编号*/
    private String code;
    private String name;
    /*外部协议url*/
    private String protocolUrl;
    private String description;
    /**协议类型 协议类型 0:系统协议 1:jar，2.js,3.c*/
    private Integer protocolType;
}
