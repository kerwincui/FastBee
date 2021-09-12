package com.ruoyi.common.core.domain.model;

import com.alibaba.fastjson.JSONObject;
import lombok.Data;

/**
 * 微信小程序用户登录对象
 *
 * @author ruoyi
 */
@Data
public class MpLoginBody {
    private String code;

    private JSONObject options; //{"path":"pages/mine/help/index","query":{},"scene":1001,"referrerInfo":{}}

}
