package com.fastbee.iot.tsdb.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@Data
@ConfigurationProperties(prefix = "spring.datasource.dynamic.datasource.iotdb")
public class IotDbConfig {
    private boolean enabled;
    private String dbName;
    private String url;
    private String username;
    private String password;
}
