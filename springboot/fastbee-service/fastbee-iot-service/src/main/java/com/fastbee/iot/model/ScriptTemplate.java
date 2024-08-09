package com.fastbee.iot.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ScriptTemplate {
    /** 场景ID */
    private Long sceneId;

    /** 脚本ID */
    private String scriptId;

    /** 类型 1=属性， 2=功能，3=事件，4=设备升级，5=设备上线，6=设备下线 */
    private int type;

    /** 触发执行源 1=设备触发/执行 2=定时触发 3=产品触发/执行 4=告警执行 */
    private int source;

    /** 静默时间，单位分钟 */
    private int silent;

    /** 延迟执行，单位秒钟 */
    private int delay;

    /** 执行条件（1=或、任意条件，2=且、所有条件，3=非，不满足） */
    private int cond;

    /** 脚本用途，1=数据流，2=触发器，3=执行动作 */
    private int purpose;

    /** 物模型标识符 */
    private String id;

    /** 物模型值 */
    private String value;

    /** 比较操作符,等于/不等于/大于/小于/包含/不包含/在...之间/不在...之间 */
    private String operator;

    /** 设备编号，多个设备英文逗号分隔 */
    private String deviceNums;

    /** 所属产品编号 */
    private Long productId;
}
