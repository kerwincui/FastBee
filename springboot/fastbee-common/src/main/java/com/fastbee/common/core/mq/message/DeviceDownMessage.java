package com.fastbee.common.core.mq.message;

import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.core.protocol.modbus.ModbusCode;
import com.fastbee.common.enums.ServerType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 设备下发指令model
 *
 * @author gsb
 * @date 2022/10/10 16:18
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DeviceDownMessage {

    private String messageId;
    /**
     * 时间戳，单位毫秒
     */
    private Long timestamp;
    /**
     * 消息体
     */
    private Object body;
    /*下发的指令,服务调用的时候就是服务标识符*/
    private String identifier;
    /*产品id*/
    private Long productId;
    /**
     * 设备编码
     */
    private String serialNumber;
    /*网关设备编码*/
    String subSerialNumber;
    /**
     * true: 表示是一条发往网关子设备的指令
     * 默认是false
     */
    Boolean subFlag = false;
    /**
     * 从机编号
     */
    private Integer slaveId;
    private ModbusCode code;
    private int count;
    private int address;
    private String protocolCode;

    private List<PropRead> values;
    private String topic;
    private String subCode;
    private ServerType serverType;

    public DeviceDownMessage(List<PropRead> values, String topic, String subCode,String transport) {
        this.values = values;
        this.topic = topic;
        this.subCode = subCode;
        this.serverType = ServerType.explain(transport);
    }
}
