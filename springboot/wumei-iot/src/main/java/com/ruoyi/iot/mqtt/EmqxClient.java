package com.ruoyi.iot.mqtt;

import com.ruoyi.common.exception.ServiceException;
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
//@Component
public class EmqxClient {
    private static final Logger logger = LoggerFactory.getLogger(EmqxClient.class);

    @Autowired
    private EmqxCallback emqxCallback;

    @Autowired
    private EmqxService emqxService;

    /**MQTT异步客户端*/
    public static MqttAsyncClient client;

    /**连接配置*/
    private MqttConnectOptions options;

    /**服务器地址url*/
    private String hostname;

    /**超时时间*/
    private int timeout;

    /**包活时间*/
    private int keepalive;

    /**客户端唯一ID*/
    private String clientId;

    /**用户名*/
    private String username;

    /**密码*/
    private String password;

    /**是否清除会话*/
    private boolean clearSession;

    public EmqxClient(String clientId,String username,String password,String hostname,
                      int timeout,int keepalive,boolean clearSession){
        this.clientId = clientId;
        this.username = username;
        this.password = password;
        this.hostname = hostname;
        this.timeout = timeout;
        this.keepalive = keepalive;
        this.clearSession = clearSession;
    }


    /**
     * 连接MQTT服务器
     */
    public synchronized void connect(){

        /*设置配置*/
        if (options == null){
            setOptions();
        }
        if (client == null){
            createClient();
        }
        while (!client.isConnected()){
            try {
                IMqttToken token = client.connect(options);
                token.waitForCompletion();
            }catch (Exception e){
                logger.error("=====>>>>>mqtt连接失败 message={}",e.getMessage());
                e.printStackTrace();
            }
        }
    }

    /**
     * 创建客户端
     */
    private void createClient(){
        if (client == null){
            try {
              /*host为主机名，clientId是连接MQTT的客户端ID，MemoryPersistence设置clientId的保存方式
                默认是以内存方式保存*/
                client = new MqttAsyncClient(hostname,clientId,new MemoryPersistence());
                //设置回调函数
                client.setCallback(emqxCallback);
                logger.debug("====>>>mqtt客户端启动成功");
            }catch (MqttException e){
                logger.error("mqtt客户端连接错误 error={}",e.getMessage());
                e.printStackTrace();
            }
        }
    }

    /**
     * 设置连接属性
     */
    private void setOptions(){
        if (options != null){
            options = null;
        }
        options = new MqttConnectOptions();
        options.setUserName(username);
        options.setPassword(password.toCharArray());
        options.setConnectionTimeout(timeout);
        options.setKeepAliveInterval(keepalive);
        //设置自动重新连接
        options.setAutomaticReconnect(true);
        options.setCleanSession(clearSession);
        logger.debug("====>>>>设置mqtt参数成功");
    }

    /**
     * 断开与mqtt的连接
     */
    public synchronized void disconnect(){
        //判断客户端是否null 是否连接
        if (client != null && client.isConnected()){
            try {
                IMqttToken token = client.disconnect();
                token.waitForCompletion();
            }catch (MqttException e){
                logger.error("====>>>>断开mqtt连接发生错误 message={}",e.getMessage());
            }
        }
        client = null;
    }

    /**
     * 重新连接MQTT
     */
    public synchronized void refresh(){
        disconnect();
        setOptions();
        createClient();
        connect();
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

        try {
            IMqttDeliveryToken token = client.publish(topic,message);
            token.waitForCompletion();
        } catch (MqttPersistenceException e) {
            e.printStackTrace();
        } catch (MqttException e) {
            logger.error("=======>>>>>发布主题时发生错误 topic={},message={}",topic,e.getMessage());
        }
    }

    /**
     * 订阅某个主题
     * @param topic 主题
     * @param qos   消息质量
     *              Qos1：消息发送一次，不确保
     *              Qos2：至少分发一次，服务器确保接收消息进行确认
     *              Qos3：只分发一次，确保消息送达和只传递一次
     */
    public void subscribe(String topic, int qos){
        logger.info("=======>>>>>订阅了主题 topic={}",topic);
        try {
            IMqttToken token = client.subscribe(topic, qos);
            token.waitForCompletion();
        }catch (MqttException e){
            logger.error("=======>>>>>订阅主题 topic={} 失败 message={}",topic,e.getMessage());
        }
    }

    /**是否处于连接状态*/
    public boolean isConnected(){
        return client != null && client.isConnected();
    }

    public String getClientId() {return  clientId;};
}