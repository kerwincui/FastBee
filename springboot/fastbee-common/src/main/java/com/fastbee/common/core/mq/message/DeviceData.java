package com.fastbee.common.core.mq.message;

import com.fastbee.common.core.protocol.Message;
import com.fastbee.common.core.protocol.modbus.ModbusCode;
import io.netty.buffer.ByteBuf;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 消息解析model
 * @author gsb
 * @date 2022/10/10 15:53
 */
@EqualsAndHashCode(callSuper = true)
@Data
@Builder
public class DeviceData extends Message {

    /*topic*/
    private String topicName;

    /*设备编号*/
    private String serialNumber;

    /*原数据*/
    private byte[] data;

    private ByteBuf buf;

    /*消息类型 1.设备上报数据 2.设备回调数据*/
    private int messageType;

    /*下发数据model*/
    private DeviceDownMessage downMessage;

    private Object body;
    /*MQTT OR 其他*/
    private int type;

    /*Modbus*/
    private ModbusCode code;

    private PropRead prop;
    /*是否使用modbus客户端模拟测试*/
    private boolean isEnabledTest;
    /**产品id*/
    private Long productId;
}
