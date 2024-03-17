package com.fastbee.common.core.mq.message;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * @author bill
 */
@Data
public class MqttBo {

    /*主题*/
    private String topic;
    /*数据*/
    private String data;
    /*消息质量*/
    private int qos = 1;
    /*发送方向*/
    private String direction;
    /*时间*/
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date ts;
}

