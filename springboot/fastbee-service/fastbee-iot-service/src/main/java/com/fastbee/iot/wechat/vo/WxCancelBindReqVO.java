package com.fastbee.iot.wechat.vo;

import lombok.Data;

/**
 * 微信解绑传参类
 * @author fastb
 * @date 2023-08-30 15:10
 */
@Data
public class WxCancelBindReqVO {

    /**
     * 验证类型
     */
    private Integer verifyType;

    /**
     * 用户密码
     */
    private String password;

    /**
     * 手机号
     */
    private String userPhone;

    /**
     * 短信验证码
     */
    private String smsCode;
}
