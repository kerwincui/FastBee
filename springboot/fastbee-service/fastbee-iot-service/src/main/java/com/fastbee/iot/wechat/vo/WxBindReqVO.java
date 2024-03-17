package com.fastbee.iot.wechat.vo;

import lombok.Data;

/**
 * @author fastb
 * @date 2023-08-30 17:21
 */
@Data
public class WxBindReqVO {

    private String sourceClient;

    private String openId;

    private String unionId;

    private String code;
}
