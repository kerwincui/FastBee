package com.fastbee.iot.model.dto;

import com.fastbee.common.core.domain.BaseEntity;
import com.fastbee.iot.model.ThingsModelItem.Datatype;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 物模型对象 iot_things_model
 *
 * @author kerwincui
 * @date 2023-01-14
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class ThingsModelDTO extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 物模型ID */
    private Long modelId;

    /** 物模型名称 */
    private String modelName;

    /** 产品ID */
    private Long productId;

    /** 产品名称 */
    private String productName;

    /** 租户ID */
    private Long tenantId;

    /** 租户名称 */
    private String tenantName;

    /** 标识符，产品下唯一 */
    private String identifier;

    /** 模型类别（1-属性，2-功能，3-事件） */
    private Integer type;

    /** 计算公式 */
    private String formula;

    /** 数据定义 */
    private String specs;

    /** 是否图表显示（0-否，1-是） */
    private Integer isChart;

    /** 是否历史存储（0-否，1-是） */
    private Integer isHistory;

    /** 是否实时监测（0-否，1-是） */
    private Integer isMonitor;

    /** 是否分享设备权限（0-否，1-是） */
    private Integer isSharePerm;

    /** 是否分享设备权限（0-否，1-是） */
    private Integer isApp;

    private String unit;

    /** 数据定义 */
    private Datatype datatype;

    private String limitValue;

    /** 是否只读数据(0-否，1-是) */
    private Integer isReadonly;


    private Integer modelOrder;

    private String value = "";

    private String ts;

    private String serialNumber;

    private Boolean isShadow;
    /**
     * 是否可下发指令 0 -不可操作 1-可
     */
    private Integer canSend;

    private String shadow = "";

    /**
     * 所属设备名称
     */
    private String deviceName;

    private String address;

}
