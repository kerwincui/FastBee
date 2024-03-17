package com.fastbee.common.wechat;

import com.alibaba.fastjson2.annotation.JSONField;
import lombok.Data;

/**
 * WeChat 调用api接口获取openid登信息后的返回类
 * @author fastb
 * @date 2023-07-31 11:43
 */
@Data
public class WeChatAppResult {

    /**
     * 接口调用凭证
     */
    @JSONField(name = "access_token")
    private String accessToken;

    /**
     * access_token 接口调用凭证超时时间，单位（秒）
     */
    @JSONField(name = "expires_in")
    private Long expiresIn;

    /**
     * 用户刷新 access_token
     */
    @JSONField(name = "refresh_token")
    private String refreshToken;

    /**
     * 授权用户唯一标识
     */
    @JSONField(name = "openid")
    private String openId;

    /**
     * 用户授权的作用域（snsapi_userinfo）
     */
    @JSONField(name = "scope")
    private String scope;

    /**
     * 当且仅当该移动应用已获得该用户的 userinfo 授权时，才会出现该字段
     */
    @JSONField(name = "unionid")
    private String unionId;

    /**
     * 错误码
     */
    @JSONField(name = "errcode")
    private Integer errCode;

    /**
     * 错误信息
     */
    @JSONField(name = "errmsg")
    private String errMsg;

    /**
     * 是否绑定手机号
     */
    private Boolean isBind;

    /**
     * token 自定义登录状态
     */
    private String token;

}
