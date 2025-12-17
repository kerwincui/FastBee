package com.fastbee.iot.tsdb.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * 类名: TDengineConfig
 * 描述: TDengine配置类
 * 时间: 2022/5/13,0016 1:14
 * 开发人: wxy
 */
@Configuration
@Data
@ConfigurationProperties(prefix = "spring.datasource.dynamic.datasource.taos")
public class TDengineConfig {
    private boolean enabled;
    private String dbName;
    private String url;
    private String username;
    private String password;
}
