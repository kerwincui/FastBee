package com.fastbee.common.core.mq;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 设备消息回调或者下发指令值
 *
 * @author gsb
 * @date 2022/5/11 9:27
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MessageReplyBo {


    private String id;
    /**
     * 消息回执的messageId，和下行消息呼应
     */
    private String messageId;
    /**
     * 设备处理消息的状态
     */
    private Integer status;
    /**
     * 抵达服务器时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date timestamp;
    /**
     * 设备上报的时间
     */
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date deviceTimestamp;
    /**
     * 回执消息内容
     */
    private String body;
    /*产品编号*/
    private Long productId;
    /*设备编号*/
    private String serialNumber;
}
