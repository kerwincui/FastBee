package com.fastbee.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 设备回调状态
 * @author bill
 */
@Getter
@AllArgsConstructor
public enum FunctionReplyStatus {
    SUCCESS(200,"设备执行成功"),
    FAIl(201,"指令执行失败"),
    UNKNOWN(204,"设备超时未回复"),
    NORELY(203, "指令下发成功");

    int code;
    String message;

}
