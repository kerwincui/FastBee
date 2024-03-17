package com.fastbee.base.session;

import com.fastbee.common.core.protocol.Message;
import io.netty.buffer.ByteBuf;
import io.netty.channel.socket.DatagramPacket;

/**
 * 报文消息的包装
 * @author bill
 */
public abstract class Packet {

    /*session*/
    public final Session session;
    /*基础消息*/
    public Message message;
    /*报文缓存buf*/
    public ByteBuf byteBuf;

    public static Packet of(Session session, Message message) {
        if (session.isUdp()) {
            return new UDP(session, message, null);
        }
        return new TCP(session, message, message.getPayload());
    }

    public static Packet of(Session session, ByteBuf message) {
        if (session.isUdp()) {
            return new UDP(session, null, message);
        }
        return new TCP(session, null, message);
    }

    private Packet(Session session, Message message, ByteBuf byteBuf) {
        this.session = session;
        this.message = message;
        this.byteBuf = byteBuf;
    }

    public Packet replace(Message message) {
        this.message = message;
        return this;
    }

    public ByteBuf take() {
        ByteBuf temp = this.byteBuf;
        this.byteBuf = null;
        return temp;
    }

    public abstract Object wrap(ByteBuf byteBuf);

    private static class TCP extends Packet {
        private TCP(Session session, Message message, ByteBuf byteBuf) {
            super(session, message, byteBuf);
        }

        @Override
        public Object wrap(ByteBuf byteBuf) {
            return byteBuf;
        }
    }

    private static class UDP extends Packet {
        private UDP(Session session, Message message, ByteBuf byteBuf) {
            super(session, message, byteBuf);
        }

        @Override
        public Object wrap(ByteBuf byteBuf) {
            return new DatagramPacket(byteBuf, session.remoteAddress());
        }
    }
}
