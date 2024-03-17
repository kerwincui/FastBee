package com.fastbee.mq.mqttClient;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.mq.DeviceReportBo;
import com.fastbee.common.enums.ServerType;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.gateway.mq.TopicsPost;
import com.fastbee.common.utils.gateway.mq.TopicsUtils;
import com.fastbee.mq.redischannel.producer.MessageProducer;
import com.fastbee.mq.service.IDeviceReportMessageService;
import com.fastbee.mq.service.IMessagePublishService;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttAsyncClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Arrays;


@Component
@Slf4j
public class MqttService {

    @Resource
    private TopicsUtils topicsUtils;
    @Resource
    private IDeviceReportMessageService deviceReportMessageService;



    public void subscribe(MqttAsyncClient client) throws MqttException {
        TopicsPost allPost = topicsUtils.getAllPost();
        client.subscribe(allPost.getTopics(), allPost.getQos());
        log.info("mqtt监控主题,{}", Arrays.asList(allPost.getTopics()));
    }

    /**
     * 消息回调方法
     *
     * @param topic       主题
     * @param mqttMessage 消息体
     */
    public void subscribeCallback(String topic, MqttMessage mqttMessage) {

        String message = new String(mqttMessage.getPayload());
        log.info("接收消息主题 : " + topic);
        log.info("接收消息Qos : " + mqttMessage.getQos());
        log.info("接收消息内容 : " + message);
        String serialNumber = topicsUtils.parseSerialNumber(topic);
        Long productId = topicsUtils.parseProductId(topic);
        String name = topicsUtils.parseTopicName(topic);
        DeviceReportBo reportBo = DeviceReportBo.builder()
                .serialNumber(serialNumber)
                .productId(productId)
                .data(mqttMessage.getPayload())
                .platformDate(DateUtils.getNowDate())
                .topicName(topic)
                .serverType(ServerType.MQTT)
                .build();
        if (name.startsWith("property")) {
            deviceReportMessageService.parseReportMsg(reportBo);
        }
    }


}
