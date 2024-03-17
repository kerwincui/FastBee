package com.fastbee.common.core.iot.response;

import lombok.Data;

/**
 * @author gsb
 * @date 2023/4/8 15:43
 */
@Data
public class DeCodeBo {

    /**原始报文*/
    private String payload;
    /**从机编号*/
    private Integer slaveId;
    /**寄存器地址*/
    private Integer address;
    /**功能码*/
    private Integer code;
    /**读取个数*/
    private Integer count;
    /**写入值*/
    private Integer writeData;
    /**读写类型  1-解析 2-读指令 3-写指令 */
    private Integer type;
}
