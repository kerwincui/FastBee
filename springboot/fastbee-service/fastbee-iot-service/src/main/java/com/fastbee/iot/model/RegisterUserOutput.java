package com.fastbee.iot.model;

import lombok.Data;

/**
 * @author fastb
 * @date 2023-08-17 11:46
 */
@Data
public class RegisterUserOutput {

    /**
     * 错误信息
     */
    private String msg;

    /**
     * 用户id
     */
    private Long sysUserId;
}
