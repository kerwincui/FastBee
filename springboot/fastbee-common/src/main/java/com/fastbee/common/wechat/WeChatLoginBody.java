package com.fastbee.common.wechat;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 微信端登录参数
 * @author fastb
 * @date 2023-07-31 11:32
 */
@Data
@Accessors(chain = true)
public class WeChatLoginBody {

    /**
     * 传入参数：临时登录凭证
     */
    private String code;

    /**
     * 临时获取用户手机号凭证
     */
    private String phoneCode;

    /**
     * 传入参数 openid
     */
    private String openId;

    /**
     * 传入参数 session_key
     */
    private String sessionKey;

    /**
     * 传入参数 unionid
     */
    private String unionId;

    /**
     * 传入参数: 用户非敏感信息
     */
    private String rawData;

    /**
     * 传入参数: 签名
     */
    private String signature;

    /**
     * 传入参数: 用户敏感信息
     */
    private String encryptedData;

    /**
     * 传入参数: 解密算法的向量
     */
    private String iv;

    /**
     * 用户手机号
     */
    private String userPhone;

    /**
     * 用户密码
     */
    private String userPwd;

    /**
     * 接口调用凭证
     */
    private String accessToken;

    /**
     * access_token 接口调用凭证超时时间，单位（秒）
     */
    private Long expiresIn;

    /**
     * 用户刷新 access_token
     */
    private String refreshToken;

    /**
     * 用户授权的作用域（snsapi_userinfo）
     */
    private String scope;
}
