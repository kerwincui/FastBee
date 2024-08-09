package com.fastbee.common.core.thingsModel;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

/**
 * 物模型值的项
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@AllArgsConstructor
@Builder
@Data
public class SceneThingsModelItem
{
    /** 物模型唯一标识符 */
    private String id;

    /** 物模型值 */
    private String value;

    /** 类型：1=属性， 2=功能，3=事件, 4=设备升级，5=设备上线，6=设备下线 ，*/
    private int type;

    /** 脚本ID */
    private String stripId;

    /** 场景ID*/
    private Long sceneId;

    /** 产品ID */
    private Long productId;

    /** 设备编号 */
    private String DeviceNumber;
}
