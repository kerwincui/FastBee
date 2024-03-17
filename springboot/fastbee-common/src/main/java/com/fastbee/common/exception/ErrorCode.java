package com.fastbee.common.exception;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 错误码对象
 *
 */
@Data
@Accessors(chain = true)
public class ErrorCode {

    /**
     * 错误码
     */
    private final Integer code;
    /**
     * 错误提示
     */
    private final String msg;

    public ErrorCode(Integer code, String message) {
        this.code = code;
        this.msg = message;
    }

}
