package com.fastbee.common.core.mq;

import com.fastbee.common.core.mq.message.PropRead;
import com.fastbee.common.core.thingsModel.ThingsModelValuesInput;
import com.fastbee.common.enums.FunctionReplyStatus;
import com.fastbee.common.enums.ServerType;
import com.fastbee.common.enums.ThingsModelType;
import io.netty.buffer.ByteBuf;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 设备上报
 * @author bill
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DeviceReportBo {

    /*设备编号或IMEI号*/
    private String serialNumber;
    /*产品ID*/
    private Long productId;
    /*4G物联网卡CCID*/
    private String ccId;
    /*topic*/
    private String topicName;
    /*mqtt消息中的packetId*/
    private Long packetId;
    /*上报时间*/
    private Date platformDate;
    /*物模型类型 1=-属性，2-功能，3-事件 */
    private ThingsModelType type;
    /*上报数据*/
    private byte[] data;
    /*1-设备数据上报 2- 下发指令给设备，设备应答数据*/
    private Integer reportType;
    /*消息id*/
    private String messageId;
    /* modbus协议消息回调,记录数据*/
    private PropRead prop;
    /*解析后组装好的数据*/
    private ThingsModelValuesInput valuesInput;
    /*处理的消息服务类型*/
    private ServerType serverType;
    private Integer slaveId;

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
     * 寄存器地址
     */
    private int address;

    private String protocolCode;

}
