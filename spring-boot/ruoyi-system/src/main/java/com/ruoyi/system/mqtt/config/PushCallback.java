/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
package com.ruoyi.system.mqtt.config;

import com.alibaba.fastjson.JSON;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.common.utils.ip.AddressUtils;
import com.ruoyi.common.utils.ip.IpUtils;
import com.ruoyi.system.domain.IotCategory;
import com.ruoyi.system.domain.IotDevice;
import com.ruoyi.system.domain.IotDeviceSet;
import com.ruoyi.system.domain.IotDeviceStatus;
import com.ruoyi.system.service.IIotCategoryService;
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
import java.util.Random;

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
    private IIotCategoryService iotCategoryService;
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
            IotDevice deviceEntity=iotDeviceService.selectIotDeviceByNum(device.getDeviceNum());
            if(deviceEntity!=null){
                device.setDeviceId(deviceEntity.getDeviceId());
                iotDeviceService.updateIotDevice(device);
            }else {
                IotCategory categoryEntity=iotCategoryService.selectIotCategoryById(device.getCategoryId());
                if(device.getDeviceName()==null || device.getDeviceNum().length()==0) {
                    Random rand = new Random(); //随机生成两位数
                    device.setDeviceName(categoryEntity.getCategoryName()+(rand.nextInt(90) + 10));
                }
                iotDeviceService.insertIotDevice(device);
            }
            //获取设备状态(消息内容不能为空，硬件获取不到数据报错)
            mqttPushClient.publish(1,false,"status/get/"+device.getDeviceNum(),"wumei.live");
            //获取设备配置
            mqttPushClient.publish(1,false,"setting/get/"+device.getDeviceNum(),"wumei.live");
        }else if(topic.equals("status")){
            IotDeviceStatus deviceStatus = JSON.parseObject(new String(mqttMessage.getPayload()), IotDeviceStatus.class);
            IotDevice device=iotDeviceService.selectIotDeviceByNum(deviceStatus.getDeviceNum());
            //添加设备状态
            deviceStatus.setDeviceId(device.getDeviceId());
            iotDeviceStatusService.insertIotDeviceStatus(deviceStatus);
        }else if(topic.equals("setting")){
            IotDeviceSet deviceSet = JSON.parseObject(new String(mqttMessage.getPayload()), IotDeviceSet.class);
            // 智能配网时需要获取IP、地址和设备用户
            IotDevice device=iotDeviceService.selectIotDeviceByNum(deviceSet.getDeviceNum());
            if(deviceSet.getIsSmartConfig()==1){
                final String ip = IpUtils.getIpAddr(ServletUtils.getRequest());
                deviceSet.setNetworkIp(ip);
                deviceSet.setNetworkAddress( AddressUtils.getRealAddressByIP(ip));
                //更新设备用户
                device.setOwnerId(deviceSet.getOwnerId());
                iotDeviceService.updateIotDevice(device);
            }
            //添加设备配置
            deviceSet.setDeviceId(device.getDeviceId());
            iotDeviceSetService.insertIotDeviceSet(deviceSet);
        }else if(topic.equals("offline")){
            //离线遗嘱
            IotDeviceStatus deviceStatus = JSON.parseObject(new String(mqttMessage.getPayload()), IotDeviceStatus.class);
            IotDeviceStatus deviceStatusEntity=iotDeviceStatusService.selectIotDeviceStatusByDeviceNum(deviceStatus.getDeviceNum());
            //设备状态为离线
            if(deviceStatusEntity!=null) {
                deviceStatusEntity.setIsOnline(0);
                iotDeviceStatusService.insertIotDeviceStatus(deviceStatusEntity);
            }
        }
    }

    @Override
    public void deliveryComplete(IMqttDeliveryToken iMqttDeliveryToken) {
        logger.info("deliveryComplete---------" + iMqttDeliveryToken.isComplete());
    }
}
