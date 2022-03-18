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
public class EmqxCallback implements MqttCallbackExtended {
    private static final Logger logger = LoggerFactory.getLogger(EmqxCallback.class);

    @Autowired
    private MqttConfig mqttConfig;

    @Autowired
    private EmqxService emqxService;

    @Override
    public void connectionLost(Throwable throwable) {
        try {
            logger.info("mqtt断开连接--");
            //EmqxService.client 添加配置 options.setAutomaticReconnect(true);会自动重连
        } catch (Exception e) {
            // e.printStackTrace();
            logger.error("发生错误："+e.getMessage());
        }
    }



    @Override
    public void messageArrived(String topic, MqttMessage mqttMessage) throws Exception {
        emqxService.subscribeCallback(topic,mqttMessage);
    }

    /**
     * 发布消息后，到达MQTT服务器，服务器回调消息接收
     * @param iMqttDeliveryToken
     */
    @Override
    public void deliveryComplete(IMqttDeliveryToken iMqttDeliveryToken) {
        // 消息到达 MQTT 代理时触发的事件
    }

    /**
     * 监听mqtt连接消息
     * @param reconnect
     * @param serverURI
     */
    @Override
    public void connectComplete(boolean reconnect, String serverURI) {
        logger.info("mqtt已经重新连接！！");
        //连接后，可以在此做初始化事件，或订阅
    }
}
