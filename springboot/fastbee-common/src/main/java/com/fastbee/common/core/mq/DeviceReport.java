package com.fastbee.common.core.mq;

import com.fastbee.common.core.mq.message.SubDeviceMessage;
import com.fastbee.common.core.protocol.Message;
import com.fastbee.common.core.thingsModel.ThingsModelValuesInput;
import com.fastbee.common.enums.FunctionReplyStatus;
import com.fastbee.common.enums.ServerType;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;
import java.util.List;


/**
 * 设备上行数据model
 *
 * @author bill
 */
@EqualsAndHashCode(callSuper = true)
@Data
public class DeviceReport extends Message {

    /**
     * 设备编号
     */
    private String serialNumber;
    /**
     * 产品ID
     */
    private Long productId;
    /**
     * 平台时间
     */
    private Date platformDate;
    /**
     * 寄存器地址
     */
    private String hexAddress;
    /**
     * 物模型标识符
     */
    private String identifier;
    /**
     * 消息id
     */
    private String messageId;
    /**
     * 设备主动上报的消息体
     * key 物模型Identifier
     * value 物模型设备对应值
     */
    private ThingsModelValuesInput valuesInput;
    /**
     * 消息id或 消息流水号
     */
    private String serNo;
    /**
     * 值是否监控，如果监控表示需要历史存储,该值来自物模型
     */
    private Integer isMonitor;
    /** ================网关子设备====================*/
    /**
     * 网关子设备编号
     */
    private List<String> subDeviceCodes;
    /**
     * 网关子设备消息
     */
    private List<SubDeviceMessage> subDeviceMessages;
    /** ================回调数据====================*/

    /**
     * 是否设备回复数据
     */
    private Boolean isReply = false;

    /**
     * 设备回复消息
     */
    private String replyMessage;
    /**
     * 设备回复状态
     */
    private FunctionReplyStatus status;
    /**
     * 从机编号
     */
    private Integer slaveId;
    /**
     * 服务器类型
     */
    private ServerType serverType;
    /**
     * 寄存器地址
     */
    private int address;

    private String protocolCode;

    private Long userId;
    private String userName;
    private String deviceName;
}
