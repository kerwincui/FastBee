package com.ruoyi.iot.mqtt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MqttClientConfiguration {

    @Autowired
    private MqttConfig mqttConfig;

    @Bean
    EmqxClient mqttClient(){
        EmqxClient client = new EmqxClient(mqttConfig.getclientId(),
                mqttConfig.getusername(),
                mqttConfig.getpassword(),
                mqttConfig.gethostUrl(),
                mqttConfig.gettimeout(),
                mqttConfig.getkeepalive(),
                mqttConfig.isClearSession()
        );
        return client;
    }
}
