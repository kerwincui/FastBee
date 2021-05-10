package com.ruoyi.system.mqtt.config;

import com.alibaba.fastjson.JSON;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.IotDevice;
import com.ruoyi.system.domain.IotDeviceSet;
import com.ruoyi.system.domain.IotDeviceStatus;
import com.ruoyi.system.service.IIotDeviceService;
import com.ruoyi.system.service.IIotDeviceSetService;
import com.ruoyi.system.service.IIotDeviceStatusService;
import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @Classname PushCallback
 * @Description 消费监听类
 */
@Component
public class PushCallback implements MqttCallback {
    private static final Logger logger = LoggerFactory.getLogger(MqttPushClient.class);

    @Autowired
    private MqttConfig mqttConfig;
    @Autowired
    private IIotDeviceService iotDeviceService;
    @Autowired
    private IIotDeviceStatusService iotDeviceStatusService;
    @Autowired
    private IIotDeviceSetService iotDeviceSetService;
    @Autowired
    private MqttPushClient mqttPushClient;

    private static MqttClient client;

    @Override
    public void connectionLost(Throwable throwable) {
        // 连接丢失后，一般在这里面进行重连
        logger.info("连接断开，可以做重连");
        if (client == null || !client.isConnected()) {
            mqttConfig.getMqttPushClient();
        }
    }

    @Override
    public void messageArrived(String topic, MqttMessage mqttMessage) throws Exception {
        // subscribe后得到的消息会执行到这里面
        logger.info("接收消息主题 : " + topic);
        logger.info("接收消息Qos : " + mqttMessage.getQos());
        logger.info("接收消息内容 : " + new String(mqttMessage.getPayload()));

        if(topic.equals("device_info")){
            //添加设备信息
            IotDevice device = JSON.parseObject(new String(mqttMessage.getPayload()), IotDevice.class);
            iotDeviceService.insertIotDevice(device);
            //获取设备状态
            mqttPushClient.publish(0,false,"status/new/"+device.getDeviceNum(),"");
            //获取设备配置
            mqttPushClient.publish(0,false,"setting/new/"+device.getDeviceNum(),"");
        }else if(topic.equals("status")){
            IotDeviceStatus deviceStatus = JSON.parseObject(new String(mqttMessage.getPayload()), IotDeviceStatus.class);
            IotDevice device=iotDeviceService.selectIotDeviceById(deviceStatus.getDeviceId());
            //添加设备状态
            deviceStatus.setDeviceId(device.getDeviceId());
            iotDeviceStatusService.insertIotDeviceStatus(deviceStatus);
        }else if(topic.equals("setting")){
            IotDeviceSet deviceSet = JSON.parseObject(new String(mqttMessage.getPayload()), IotDeviceSet.class);
            //更新设备用户
            IotDevice device=iotDeviceService.selectIotDeviceById(deviceSet.getDeviceId());
            device.setOwnerId(deviceSet.getOwnerId());
            iotDeviceService.updateIotDevice(device);
            //添加设备配置
            deviceSet.setDeviceId(device.getDeviceId());
            iotDeviceSetService.insertIotDeviceSet(deviceSet);
        }else if(topic.equals("offline")){
            //离线遗嘱
            IotDeviceStatus deviceStatus = JSON.parseObject(new String(mqttMessage.getPayload()), IotDeviceStatus.class);
            //添加设备状态
            IotDeviceStatus newDeviceStatus=iotDeviceStatusService.selectIotDeviceStatusById(deviceStatus.getDeviceStatusId());
            newDeviceStatus.setIsOnline(0);
            iotDeviceStatusService.insertIotDeviceStatus(newDeviceStatus);
        }
    }

    @Override
    public void deliveryComplete(IMqttDeliveryToken iMqttDeliveryToken) {
        logger.info("deliveryComplete---------" + iMqttDeliveryToken.isComplete());
    }
}
