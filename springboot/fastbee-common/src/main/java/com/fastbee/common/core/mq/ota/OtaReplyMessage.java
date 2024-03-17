package com.fastbee.common.core.mq.ota;

import lombok.Data;

/**
 * OTA升级回复model
 * @author gsb
 * @date 2022/10/24 17:20
 */
@Data
public class OtaReplyMessage {

    private String messageId;
    // 200成功 其他。。
    private int code;
    private String msg;
}
