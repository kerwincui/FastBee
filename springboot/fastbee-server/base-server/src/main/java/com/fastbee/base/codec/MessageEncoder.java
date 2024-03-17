package com.fastbee.base.codec;

import com.fastbee.common.core.protocol.Message;
import com.fastbee.base.session.Session;
import io.netty.buffer.ByteBuf;

/**
 * 基础消息编码类
 *
 * @author bill
 */
public interface MessageEncoder{

    ByteBuf encode(Message message, String clientId);
}
