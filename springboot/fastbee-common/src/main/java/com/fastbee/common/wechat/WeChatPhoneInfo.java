package com.fastbee.common.wechat;

import com.alibaba.fastjson2.annotation.JSONField;
import lombok.Data;

/**
 * @author fastb
 * @date 2023-08-16 17:48
 */
@Data
public class WeChatPhoneInfo {

    @JSONField(name = "errcode")
    private String errCode;

    @JSONField(name = "errmsg")
    private String errmsg;

    @JSONField(name = "phone_info")
    private PhoneInfo phoneInfo;

    @Data
    public class PhoneInfo {

        private String phoneNumber;

        private String purePhoneNumber;

        private String countryCode;

        private WaterMark watermark;
    }

    @Data
    class WaterMark {

        private String timestamp;

        private String appid;
    }
}
