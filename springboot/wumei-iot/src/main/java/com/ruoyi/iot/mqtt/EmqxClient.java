package com.ruoyi.iot.mqtt;

import org.eclipse.paho.client.mqttv3.*;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @Classname EmqxClient
 * @Description mqtt推送客户端
 */
@Component
public class EmqxClient {
    private static final Logger logger = LoggerFactory.getLogger(EmqxClient.class);

    @Autowired
    private EmqxCallback emqxCallback;

    @Autowired
    private EmqxService emqxService;

    public static MqttClient client;

    /**
     * 客户端连接
     *
     * @param host      ip+端口
     * @param clientID  客户端Id
     * @param username  用户名
     * @param password  密码
     * @param timeout   超时时间
     * @param keepalive 保留数
     */
    public void connect(String host, String clientID, String username, String password, int timeout, int keepalive) {
        MqttClient client;
        try {
            client = new MqttClient(host, clientID, new MemoryPersistence());
            MqttConnectOptions options = new MqttConnectOptions();
            options.setCleanSession(true);
            options.setUserName(username);
            options.setPassword(password.toCharArray());
            options.setConnectionTimeout(timeout);
            options.setKeepAliveInterval(keepalive);
            EmqxClient.client=client;
            client.setCallback(emqxCallback);
            clientConnect(options,client);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 10秒重连一次
     * @param options
     * @param client
     * @throws InterruptedException
     */
    public void clientConnect(MqttConnectOptions options, MqttClient client) throws InterruptedException {
        try {
            client.connect(options);
            logger.info("mqtt连接成功");
            // 订阅主题
            emqxService.subscribe(client);
        } catch (Exception e) {
            logger.error("mqtt连接失败,"+e.getMessage());
            //发生错误后重新连接
            Thread.sleep(10000);
            clientConnect(options,client);
        }
    }

    /**
     * 发布
     * @param qos         连接方式
     * @param retained    是否保留
     * @param topic       主题
     * @param pushMessage 消息体
     */
    public void publish(int qos, boolean retained, String topic, String pushMessage) {
        logger.info("发布主题" + topic);
        MqttMessage message = new MqttMessage();
        message.setQos(qos);
        message.setRetained(retained);
        message.setPayload(pushMessage.getBytes());
        MqttTopic mTopic = EmqxClient.client.getTopic(topic);
        if (null == mTopic) {
            logger.error("topic not exist");
        }
        MqttDeliveryToken token;
        try {
            token = mTopic.publish(message);
            token.waitForCompletion();
        } catch (MqttPersistenceException e) {
            e.printStackTrace();
        } catch (MqttException e) {
            e.printStackTrace();
        }
    }

    /**
     * 订阅某个主题
     * @param topic 主题
     * @param qos   连接方式
     */
    public void subscribe(String topic, int qos) {
        logger.info("订阅主题" + topic);
        try {
            EmqxClient.client.subscribe(topic, qos);
        } catch (MqttException e) {
            e.printStackTrace();
        }
    }
}