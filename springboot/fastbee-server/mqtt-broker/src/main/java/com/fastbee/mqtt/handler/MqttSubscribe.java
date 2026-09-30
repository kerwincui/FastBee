package com.fastbee.mqtt.handler;

import com.alibaba.fastjson2.JSON;
import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.mqtt.annotation.Process;
import com.fastbee.mqtt.model.ClientMessage;
import com.fastbee.base.session.Session;
import com.fastbee.base.util.AttributeUtils;
import com.fastbee.mqtt.utils.MqttMessageUtils;
import com.fastbee.mqtt.model.RetainMessage;
import com.fastbee.mqtt.handler.adapter.MqttHandler;
import com.fastbee.mqtt.manager.ClientManager;
import com.fastbee.mqtt.manager.ResponseManager;
import com.fastbee.mqtt.manager.RetainMsgManager;
import com.fastbee.common.utils.gateway.mq.TopicsUtils;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.mqtt.*;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;


@Slf4j
@Process(type = MqttMessageType.SUBSCRIBE)
public class MqttSubscribe implements MqttHandler {

    @Resource
    private RedisCache redisCache;
    @Resource
    private com.fastbee.mqtt.acl.MqttAccessControl mqttAccessControl;

    @Override
    public void handler(ChannelHandlerContext ctx, MqttMessage message) {
        subscribe(ctx, (MqttSubscribeMessage) message);
    }


    public void subscribe(ChannelHandlerContext ctx, MqttSubscribeMessage message) {
        /*获取session*/
        Session session = AttributeUtils.getSession(ctx.channel());
        if (session == null) { ctx.close(); return; }
        /*获取客户端订阅的topic列表*/
        List<MqttTopicSubscription> topList = message.payload().topicSubscriptions();
        /*获取topicName列表*/
        List<String> topicNameList = topList.stream().map(MqttTopicSubscription::topicName).collect(Collectors.toList());
        log.debug("=>客户端:{},订阅主题:{}", session.getClientId(), JSON.toJSONString(topicNameList));
        if (!TopicsUtils.validTopicFilter(topicNameList)) {
            log.error("=>订阅主题不合法:{}", JSON.toJSONString(topicNameList));
            ctx.close();
            return;
        }
        java.util.List<Integer> grants = new java.util.ArrayList<>();
        java.util.List<MqttTopicSubscription> permitted = new java.util.ArrayList<>();
        for (MqttTopicSubscription subscription : topList) {
            boolean allowed = mqttAccessControl.canSubscribe(session.getPrincipal(), subscription.topicName());
            grants.add(allowed ? subscription.qualityOfService().value() : 128);
            if (allowed) permitted.add(subscription);
        }
        /*存储到本地topic缓存*/
        permitted.forEach(subscription -> {
            String topicName = subscription.topicName();
            ClientManager.push(topicName, session);
            /*累计订阅数*/
            redisCache.incr2(FastBeeConstant.REDIS.MESSAGE_SUBSCRIBE_TOTAL,-1L);
        });
        /*更新客户端ping*/
        ClientManager.updatePing(session.getClientId());
        /*应答客户端订阅成功*/
        MqttSubAckMessage subAckMessage = new MqttSubAckMessage(
                new MqttFixedHeader(MqttMessageType.SUBACK, false, MqttQoS.AT_MOST_ONCE, false, 0),
                MqttMessageIdVariableHeader.from(message.variableHeader().messageId()), new MqttSubAckPayload(grants));
        ResponseManager.responseMessage(session, subAckMessage, true);
        /*客户端订阅了遗留消息主题后，推送遗留消息给客户端*/
        permitted.forEach(topic -> {
            retain(topic.topicName(), session, topic.qualityOfService());
        });
    }


    /**
     * 推送遗留消息
     *
     * @param topicName 主题
     * @param session   客户端
     * @param mqttQoS   消息质量
     */
    @SneakyThrows
    private void retain(String topicName, Session session, MqttQoS mqttQoS) {
        RetainMessage message = RetainMsgManager.getRetain(topicName);
        if (null == message) {
            return;
        }
        MqttQoS qos = message.getQos() > mqttQoS.value() ? mqttQoS : MqttQoS.valueOf(message.getQos());
        switch (qos.value()) {
            case 0:
                buildMessage(qos, topicName, 0, message.getMessage(), session);
                break;
            case 1:
            case 2:
                /*使用实时时间戳充当 packId*/
                buildMessage(qos, topicName, (int) System.currentTimeMillis(), message.getMessage(), session);
                break;
        }
    }

    /*组装推送数据*/
    private void buildMessage(MqttQoS qos, String topicName, int packetId, byte[] message, Session session) {
        /*生成客户端model*/
        ClientMessage clientMessage = ClientMessage.of(qos, topicName, false, message);
        /*组建推送消息*/
        MqttPublishMessage publishMessage = MqttMessageUtils.buildPublishMessage(clientMessage, packetId);
        /*推送消息*/
        ResponseManager.publishClients(publishMessage, session);
    }


}
