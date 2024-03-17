package com.fastbee.common.wechat;

import com.alibaba.fastjson2.annotation.JSONField;
import lombok.Data;

/**
 * @author fastb
 * @date 2023-08-14 10:07
 */
@Data
public class WeChatMiniProgramResult {

    /**
     * 会话密钥
     */
    @JSONField(name = "session_key")
    private String sessionKey;

    /**
     * 用户在开放平台的唯一标识符，若当前小程序已绑定到微信开放平台账号下会返回，详见 UnionID 机制说明
     */
    @JSONField(name = "unionid")
    private String unionId;

    /**
     * 错误信息
     */
    @JSONField(name = "errmsg")
    private String errMsg;

    /**
     * 用户唯一标识
     */
    @JSONField(name = "openid")
    private String openId;

    /**
     * 错误码
     */
    @JSONField(name = "errcode")
    private String errCode;
}
