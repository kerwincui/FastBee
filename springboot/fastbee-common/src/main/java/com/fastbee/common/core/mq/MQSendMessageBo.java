package com.fastbee.common.core.mq;

import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.core.protocol.modbus.ModbusCode;
import com.fastbee.common.enums.ThingsModelType;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 服务(指令)下发对象
 *
 * @author bill
 */
@Data
@NoArgsConstructor
public class MQSendMessageBo {

    /*设备编号*/
    private String serialNumber;
    /*下发属性标识符*/
    private String identifier;
    /*寄存器地址 10进制*/
    private String hexAddress;
    /*topic*/
    private JSONObject  command;
    private String topicName;
    /*产品ID*/
    private Long productId;
    /*物模型类型 1=-属性，2-功能，3-事件，4-属性和功能*/
    private ThingsModelType type;
    /*下发的数据*/
    private JSONObject value;
    /*协议编号 例如：modbus-rtu*/
    private String protocolCode;
    /*messageId生成放到调用接口的时候生成*/
    private String messageId;
    /*流水号，针对某些协议没有消息流水号无法区分下发的消息和上报的消息是否对应*/
    private String serialNo;
    /*从机id*/
    private Integer slaveId;
    /**显示值*/
    private String showValue;
    private String modelName;
    private ModbusCode code;
    /*是否是影子模式*/
    private Boolean isShadow;
    /*传输协议*/
    private String transport;


}
