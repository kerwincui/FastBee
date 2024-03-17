package com.fastbee.common.wechat;

import com.alibaba.fastjson2.annotation.JSONField;
import lombok.Data;

/**
 * 微信用户信息
 * @author fastb
 * @date 2023-07-31 14:56
 */
@Data
public class WeChatUserInfo {

    /**
     * 普通用户的标识，对当前开发者账号唯一
     */
    @JSONField(name = "openid")
    private String openId;

    /**
     * 普通用户昵称
     */
    @JSONField(name = "nickname")
    private String nickname;

    /**
     * 普通用户性别，1 为男性，2 为女性
     */
    @JSONField(name = "sex")
    private Integer sex;

    /**
     * 普通用户个人资料填写的省份
     */
    @JSONField(name = "province")
    private String province;

    /**
     * 普通用户个人资料填写的城市
     */
    @JSONField(name = "city")
    private String city;

    /**
     * 国家，如中国为 CN
     */
    @JSONField(name = "country")
    private String country;

    /**
     * 用户头像，最后一个数值代表正方形头像大小（有 0、46、64、96、132 数值可选，0 代表 640*640 正方形头像），用户没有头像时该项为空
     */
    @JSONField(name = "headimgurl")
    private String headImgUrl;

    /**
     * 用户特权信息，json 数组，如微信沃卡用户为（chinaunicom）
     */
    @JSONField(name = "privilege")
    private String privilege;

    /**
     * 用户统一标识。针对一个微信开放平台账号下的应用，同一用户的 unionid 是唯一的。
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

}
