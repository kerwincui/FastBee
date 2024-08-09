package com.fastbee.iot.model;

import lombok.Data;


/**
 * 规则引擎脚本查询条件
 * @author kerwin
 */
@Data
public class ScriptCondition
{
    /** 用户ID */
    private Long userId;

    /** 租户ID */
    private Long tencentId;

    /** 应用名 */
    private String applicationName;

    /** 脚本ID */
    private String scriptId;

    /** 脚本名 */
    private String scriptName;

    /** 脚本类型 */
    private String scriptType;
    /**
     * 关联的产品ID
     */
    private Long productId;

    /** 场景ID */
    private Long sceneId;

    /** 脚本类型(1=设备上报，2=平台下发，3=设备上线，4=设备离线) */
    private Integer scriptEvent;

    /** 脚本动作(1=消息重发，2=消息通知，3=Http推送，4=Mqtt桥接，5=数据库存储) */
    private Integer scriptAction;

    /** 脚本用途(1=数据流，2=触发器，3=执行动作) */
    private Integer scriptPurpose;

    /** 脚本语言（groovy | ql express | js | python | lua | aviator） */
    private String scriptLanguage;

    /**是否生效*/
    private Integer enable;
}
