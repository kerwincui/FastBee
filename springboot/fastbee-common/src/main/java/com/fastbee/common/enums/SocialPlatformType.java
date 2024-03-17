package com.fastbee.common.enums;

import java.util.Arrays;
import java.util.List;

/**
 * 第三方登录平台枚举
 *
 * @author json
 */
public enum SocialPlatformType {
    WECHAT_OPEN_WEB("wechat_open_web", "微信开放平台网站应用"),
    WECHAT_OPEN_WEB_BIND("wechat_open_web_bind", "微信开放平台网站应用个人中心绑定"),
    WECHAT_OPEN_MOBILE("wechat_open_mobile", "微信开放平台移动应用"),
    WECHAT_OPEN_MINI_PROGRAM("wechat_open_mini_program", "微信开放平台小程序"),
    QQ_OPEN_WEB("qq_open_web", "QQ互联网站应用"),
    QQ_OPEN_APP("qq_open_app", "QQ互联移动应用"),
    QQ_OPEN_MINI_PROGRAM("qq_open_mini_program", "QQ互联小程序");
//    ALIPAY_OPEN_WEB("alipay_open_web", ""),
//    ALIPAY_OPEN_APP("alipay_open_app", ""),
//    ALIPAY_OPEN_MINI_PROGRAM("alipay_open_mini_program", "");

    public String sourceClient;

    public String desc;

    SocialPlatformType(String sourceClient, String desc) {
        this.sourceClient = sourceClient;
        this.desc = desc;
    }

    // 查询微信绑定来源集合
    public static final List<String> listWechatPlatform = Arrays.asList(WECHAT_OPEN_WEB.sourceClient, WECHAT_OPEN_MOBILE.sourceClient, WECHAT_OPEN_MINI_PROGRAM.sourceClient);

    public static String getDesc(String sourceClient) {
        for (SocialPlatformType socialPlatformType : SocialPlatformType.values()) {
            if (socialPlatformType.getSourceClient().equals(sourceClient)) {
                return socialPlatformType.getDesc();
            }
        }
        return null;
    }

    public static SocialPlatformType getSocialPlatformType(String sourceClient) {
        for (SocialPlatformType socialPlatformType : SocialPlatformType.values()) {
            if (socialPlatformType.getSourceClient().equals(sourceClient)) {
                return socialPlatformType;
            }
        }
        return null;
    }

    public String getSourceClient() {
        return sourceClient;
    }

    public void setSourceClient(String sourceClient) {
        this.sourceClient = sourceClient;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
