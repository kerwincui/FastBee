package com.fastbee.common.core.protocol;

import io.netty.buffer.ByteBuf;
import lombok.Data;

import java.io.Serializable;

/**
 * 基础消息
 *
 * @author bill
 */
@Data
public class Message implements Serializable {

    /*获取客户端id*/
   public String clientId;
    /*消息类型*/
    public String messageId;
    /*消息流水号*/
    public String serNo;
    /**消息通道id*/
    public String channelId;

    public ByteBuf payload;

    /**
     * 是否数据和注册包都封装到一起
     */
    private Boolean isPackage = false;

    private Object body;
}
