package com.fastbee.gateway.boot.start;

import com.fastbee.common.core.mq.DeviceReportBo;
import com.fastbee.common.enums.ServerType;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.common.utils.gateway.mq.TopicsUtils;
import com.fastbee.iot.ruleEngine.RuleProcess;
import com.fastbee.mqttclient.IEmqxMessageProducer;
import com.fastbee.ruleEngine.context.MsgContext;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.IMqttMessageListener;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.stereotype.Component;

import jakarta.annotation.Resource;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.Objects;

@Slf4j
@Component
public class subscribeCallback implements IMqttMessageListener {
    @Resource
    private RuleProcess ruleProcess;
    @Resource
    private TopicsUtils topicsUtils;
    @Resource
    private IEmqxMessageProducer emqxMessageSerice;

    @Override
    public void messageArrived(String topic, MqttMessage mqttMessage) throws Exception {
        String message = new String(mqttMessage.getPayload());
        log.info("接收消息主题 : " + topic);
        log.info("接收消息Qos : " + mqttMessage.getQos());
        log.info("接收消息内容 : " + message);

        //这里默认设备编号长度超过9位
        String[] split = topic.split("/");
        String sn = Arrays.stream(split).filter(imei -> imei.length() > 9).findFirst().get();
        // 规则引擎脚本处理,完成后返回结果
        MsgContext context = ruleProcess.processRuleScript(sn, 1, topic, message);
        if (!Objects.isNull(context) && StringUtils.isNotEmpty(context.getPayload())
                && StringUtils.isNotEmpty(context.getTopic())) {
            topic = context.getTopic();
            message = context.getPayload();
        }
        String serialNumber = topicsUtils.parseSerialNumber(topic);
        Long productId = topicsUtils.parseProductId(topic);
        String name = topicsUtils.parseTopicName(topic);
        DeviceReportBo reportBo = DeviceReportBo.builder()
                .serialNumber(serialNumber)
                .productId(productId)
                .data(message.getBytes(StandardCharsets.UTF_8))
                .platformDate(DateUtils.getNowDate())
                .topicName(topic)
                .serverType(ServerType.MQTT)
                .build();
        /*将mqtt的消息发送至MQ队列处理消息 ,减轻mqtt客户端消息压力*/
        emqxMessageSerice.sendEmqxMessage(name,reportBo);
    }
}
