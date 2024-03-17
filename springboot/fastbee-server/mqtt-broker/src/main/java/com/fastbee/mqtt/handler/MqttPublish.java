package com.fastbee.mqtt.handler;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.mq.DeviceReportBo;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.enums.ServerType;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.gateway.mq.TopicsUtils;
import com.fastbee.mq.redischannel.producer.MessageProducer;
import com.fastbee.mq.service.IDeviceReportMessageService;
import com.fastbee.mqtt.annotation.Process;
import com.fastbee.mqtt.handler.adapter.MqttHandler;
import com.fastbee.mqtt.manager.ClientManager;
import com.fastbee.mqtt.manager.ResponseManager;
import com.fastbee.mqtt.manager.RetainMsgManager;
import com.fastbee.mqtt.model.ClientMessage;
import com.fastbee.mqtt.service.IMessageStore;
import com.fastbee.base.session.Session;
import com.fastbee.base.util.AttributeUtils;
import io.netty.buffer.ByteBufUtil;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.mqtt.*;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Resource;

/**
 * 客户端消息推送处理类
 *
 * @author bill
 */
@Slf4j
@Process(type = MqttMessageType.PUBLISH)
public class MqttPublish implements MqttHandler {

    @Autowired
    private IMessageStore messageStore;
    @Resource
    private TopicsUtils topicsUtils;
    @Resource
    private RedisCache redisCache;
    @Resource
    private IDeviceReportMessageService deviceReportMessageService;

    @Override
    public void handler(ChannelHandlerContext ctx, MqttMessage message) {
        MqttPublishMessage publishMessage = (MqttPublishMessage) message;
        /*获取客户端id*/
        String clientId = AttributeUtils.getClientId(ctx.channel());
        String topicName = publishMessage.variableHeader().topicName();
        log.debug("=>***客户端[{}],主题[{}],推送消息[{}]", clientId, topicName,
                ByteBufUtil.hexDump(publishMessage.content()));
        // 以get结尾是模拟客户端数据,只转发消息
        if (topicName.endsWith(FastBeeConstant.MQTT.PROPERTY_GET_SIMULATE)) {
            sendTestToMQ(publishMessage);
        } else {
            /*获取客户端session*/
            Session session = AttributeUtils.getSession(ctx.channel());
            /*推送保留信息*/
            pubRetain(publishMessage);
            /*响应客户端消息到达Broker*/
            callBack(session, publishMessage, clientId);
            /*推送到订阅的客户端*/
            sendMessageToClients(publishMessage);
            /*推送到MQ处理*/
            sendToMQ(publishMessage);
            /*累计接收消息数*/
            redisCache.incr2(FastBeeConstant.REDIS.MESSAGE_RECEIVE_TOTAL, -1L);
            redisCache.incr2(FastBeeConstant.REDIS.MESSAGE_RECEIVE_TODAY, 60 * 60 * 24);
        }
    }

    /**
     * 消息推送
     *
     * @param message 推送消息
     */
    @SneakyThrows
    public void sendToMQ(MqttPublishMessage message) {
        /*获取topic*/
        String topicName = message.variableHeader().topicName();
        /*只处理上报数据*/
        if (!topicName.endsWith(FastBeeConstant.MQTT.UP_TOPIC_SUFFIX)) {
            return;
        }
        DeviceReportBo reportBo = DeviceReportBo.builder()
                .serialNumber(topicsUtils.parseSerialNumber(topicName))
                .topicName(topicName)
                .packetId((long) message.variableHeader().packetId())
                .platformDate(DateUtils.getNowDate())
                .data(ByteBufUtil.getBytes(message.content()))
                .serverType(ServerType.MQTT)
                .build();
        if (topicName.endsWith(FastBeeConstant.TOPIC.MSG_REPLY) ||
                topicName.endsWith(FastBeeConstant.TOPIC.SUB_UPGRADE_REPLY) ||
                topicName.endsWith(FastBeeConstant.TOPIC.UPGRADE_REPLY)) {
            /*设备应答服务器回调数据*/
            reportBo.setReportType(2);
        } else {
            /*设备上报数据*/
            reportBo.setReportType(1);
        }
        if (topicName.contains("property")) {
            deviceReportMessageService.parseReportMsg(reportBo);
        }

    }

    /**
     * 发送模拟数据进行处理
     * @param message
     */
    public void sendTestToMQ(MqttPublishMessage message) {
        /*获取topic*/
        String topicName = message.variableHeader().topicName();
        DeviceReportBo reportBo = DeviceReportBo.builder()
                .serialNumber(topicsUtils.parseSerialNumber(topicName))
                .topicName(topicName)
                .packetId((long) message.variableHeader().packetId())
                .platformDate(DateUtils.getNowDate())
                .data(ByteBufUtil.getBytes(message.content()))
                .build();
        MessageProducer.sendOtherMsg(reportBo);
    }


    /**
     * 推送消息到订阅客户端
     *
     * @param message 消息
     */
    public void sendMessageToClients(MqttPublishMessage message) {
        ClientManager.pubTopic(message);
    }


    /**
     * 应答客户端，消息到达Broker
     *
     * @param session 客户端
     * @param message 消息
     */
    private void callBack(Session session, MqttPublishMessage message, String clientId) {
        /*获取消息等级*/
        MqttQoS mqttQoS = message.fixedHeader().qosLevel();
        int packetId = message.variableHeader().packetId();
        MqttFixedHeader header;
        switch (mqttQoS.value()) {
            /*0,1消息等级，直接回复*/
            case 0:
            case 1:
                header = new MqttFixedHeader(MqttMessageType.PUBACK, false, mqttQoS, false, 0);
                break;
            case 2:
                // 处理Qos2的消息确认
                if (!messageStore.outRelContains(packetId)) {
                    messageStore.saveRelInMsg(packetId);
                }
                header = new MqttFixedHeader(MqttMessageType.PUBREC, false, MqttQoS.AT_MOST_ONCE, false, 0);
                break;
            default:
                header = null;
        }
        /*处理消息等级*/
        handleMqttQos(packetId, mqttQoS, true, clientId);
        /*响应客户端*/
        MqttMessageIdVariableHeader variableHeader = null;
        if (packetId > 0) {
            variableHeader = MqttMessageIdVariableHeader.from(packetId);
        }
        MqttPubAckMessage ackMessage = new MqttPubAckMessage(header, variableHeader);
        if (mqttQoS.value() >= 1) {
            ResponseManager.responseMessage(session, ackMessage, true);
        }
        /*更新客户端ping时间*/
        ClientManager.updatePing(session.getClientId());

    }

    /**
     * Qos不同消息处理
     */
    private void handleMqttQos(int packetId, MqttQoS qoS, boolean clearSession, String clientId) {
        if (qoS == MqttQoS.AT_LEAST_ONCE || qoS == MqttQoS.EXACTLY_ONCE) {
            ClientMessage clientMessage = ClientMessage.of(clientId, qoS, null, false);
            messageStore.savePubMsg(packetId, clientMessage);
        }
    }


    /**
     * 推送保留信息
     */
    @SneakyThrows
    private void pubRetain(MqttPublishMessage message) {
        redisCache.incr2(FastBeeConstant.REDIS.MESSAGE_RETAIN_TOTAL, -1L);
        /*根据message.fixedHeader().isRetain() 判断是否有保留信息*/
        RetainMsgManager.pushMessage(message);
    }


}
