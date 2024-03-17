package com.fastbee.common.core.mq.message;

import com.fastbee.common.core.protocol.modbus.ModbusCode;
import lombok.Data;

/**
 * @author gsb
 * @date 2022/12/9 10:15
 */
@Data
public class PropRead {

    /**设备编号*/
    private String serialNumber;
    /**寄存器起始地址*/
    private int address;
    /**
     * 读取寄存器个数
     */
    private int count;
    /**数据结果长度计算值*/
    private int length;
    /**
     * 从机地址
     */
    private int slaveId;
    /**
     * 读取个数
     */
    private int quantity;
    /**
     * 数据
     */
    private String data;
    /**
     * 功能码
     */
    private ModbusCode code;
}
