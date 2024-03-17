package com.fastbee.common.core.mq.message;

import lombok.Data;

/**
 * 平台下发指令数据model
 * @author bill
 */
@Data
public class DeviceFunctionMessage {

    /*流水号，兼容modbus标准协议没有消息流水号*/
    private String seqNo;
    /*平台时间*/
    private Long pfTimestamp;
    /*下发的消息体*/
    private Object body;
    /*下发的指令物模型标识符*/
    private String identifier;
    /*下发的数据寄存器地址*/
    private String hexAddress;
    /*产品ID*/
    private Long productId;
    /*设备编号*/
    private String serialNumber;
    /*网关设备编号*/
    private String protocolCode;

    /*是否有子设备 0-否，1-是*/
    private Integer hasSub;
    /*子设备从机编号 例如 02 编号从机。通过主机集控下发的指定从机编号*/
    private String subDeviceCode;
}
