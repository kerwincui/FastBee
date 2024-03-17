package com.fastbee.gateway.boot.start;

import com.fastbee.mq.mqttClient.PubMqttClient;
import com.fastbee.mq.redischannel.listen.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 启动类
 *
 * @author bill
 */
@Component
@Slf4j
@Order(2)
public class StartBoot implements ApplicationRunner {


    @Autowired
    private PubMqttClient mqttClient;
    @Resource
    private DeviceOtherListen otherListen;


    @Override
    public void run(ApplicationArguments args) throws Exception {
        try {
            otherListen.listen();
            /*启动内部客户端,用来下发客户端服务*/
            mqttClient.initialize();
            log.info("=>设备监听队列启动成功");
        } catch (Exception e) {
            log.error("=>客户端启动失败:{}", e.getMessage(),e);
        }
    }
}
