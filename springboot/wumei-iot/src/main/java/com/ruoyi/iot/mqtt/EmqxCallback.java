package com.ruoyi.iot.mqtt;

import com.ruoyi.framework.web.domain.server.Sys;
import org.eclipse.paho.client.mqttv3.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @Classname MqttCallback
 * @Description 消费监听类
 */
@Component
public class EmqxCallback implements MqttCallback {
    private static final Logger logger = LoggerFactory.getLogger(EmqxCallback.class);

    @Autowired
    private MqttConfig mqttConfig;

    @Autowired
    private EmqxService emqxService;

    @Override
    public void connectionLost(Throwable throwable) {
        try {
            // 重连mqtt
            while(true) {
                logger.info("mqtt连接断开，重新连接中...");
                EmqxClient.client.reconnect();
                Thread.sleep(10000);
                if(EmqxClient.client.isConnected()){
                    logger.info("mqtt已经重新连接");
                    break;
                }
            }
        } catch (MqttException | InterruptedException e) {
            // e.printStackTrace();
            logger.error("发生错误："+e.getMessage());
        }
    }



    @Override
    public void messageArrived(String topic, MqttMessage mqttMessage) throws Exception {
        emqxService.subscribeCallback(topic,mqttMessage);
    }

    @Override
    public void deliveryComplete(IMqttDeliveryToken iMqttDeliveryToken) {
        // 消息到达 MQTT 代理时触发的事件
    }
}
