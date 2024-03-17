package com.fastbee.mqtt.manager;

import com.fastbee.base.session.Session;
import io.netty.buffer.ByteBuf;
import io.netty.channel.Channel;
import io.netty.channel.ChannelFuture;
import io.netty.handler.codec.mqtt.*;
import lombok.extern.slf4j.Slf4j;


@Slf4j
public class ResponseManager {


    /**
     * 发送信息：用于服务端收到消息客户端数据后，向客户端发送响应信息
     *
     * @param session 上下文
     * @param msg     mqtt消息
     * @param flush   是否刷新
     */
    public static void responseMessage(Session session, MqttMessage msg, boolean flush) {
        ChannelFuture future = flush ? session.getHandlerContext().writeAndFlush(msg) : session.getHandlerContext().write(msg);
        future.addListener(f -> {
            if (!f.isSuccess()) {
                log.error("=>响应设备[{}],发送消息:{},失败原因:{}", session.getClientId(), msg, f.cause());
            }else {
                //log.debug("=>相应设备:[{}],发送消息:[{}]",session.getClientId(),msg);
            }
        });
    }

    /**
     * 发送信息:用于服务端向客户端通过clientID下发消息(单客户端)
     *
     * @param msg      mqtt消息
     * @param clientId 客户端id
     * @param flush    是否刷新
     */
    public static void sendMessage(MqttMessage msg, String clientId, boolean flush) {
        Session session = SessionManger.getSession(clientId);
        if (session == null || null == session.getHandlerContext()) {
            return;
        }
        responseMessage(session, msg, flush);
    }

    /**
     * 推送消息给订阅客户端(所有订阅客户端)
     *
     * @param msg     推送消息
     * @param session 客户端
     */
    public static void publishClients(MqttPublishMessage msg, Session session) {
        try {
            final Channel channel = session.getHandlerContext().channel();
            MqttQoS qos = msg.fixedHeader().qosLevel();
            ByteBuf sendBuf = msg.content().retainedDuplicate();
            sendBuf.resetReaderIndex();
            /*配置推送消息类型*/
            MqttFixedHeader Header = new MqttFixedHeader(MqttMessageType.PUBLISH,
                    false, qos, msg.fixedHeader().isRetain(), 0);
            /*设置topic packetId*/
            MqttPublishVariableHeader publishVariableHeader = new MqttPublishVariableHeader(
                    msg.variableHeader().topicName(), msg.variableHeader().packetId());
            /*推送消息*/
            MqttPublishMessage publishMessage = new MqttPublishMessage(Header,
                    publishVariableHeader, sendBuf);
            channel.writeAndFlush(publishMessage);

        } catch (Exception e) {
            log.error("=>发送消息异常 {}", msg, e);
        }
    }

}
