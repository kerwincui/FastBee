package com.fastbee.iot.tsdb.config;

import com.influxdb.client.*;
import lombok.Data;
import okhttp3.OkHttpClient;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.TimeUnit;

/**
 * @Author gx_ma
 * @Date: 2025/03/04/ 11:19
 * @description
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "spring.datasource.dynamic.datasource.influx")
public class InfluxConfig {
    private boolean enabled;
    private String url;
    private String token;
    private String org;
    private String bucket;
    private String measurement;


    /**
     * 创建 OkHttpClient 实例，用于 HTTP 请求配置（单例）
     *
     * @return OkHttpClient 实例
     */
    @Bean
    @ConditionalOnProperty(prefix = "spring.datasource.dynamic.datasource.influx", name = "enabled", havingValue = "true")
    public OkHttpClient okHttpClient() {
        return new OkHttpClient.Builder()
                .connectTimeout(30, TimeUnit.SECONDS)
                .readTimeout(60, TimeUnit.SECONDS)
                .connectionPool(new okhttp3.ConnectionPool(50, 1, TimeUnit.MINUTES))
                .build();
    }

    /**
     * 创建 InfluxDBClient 客户端实例
     *
     * @return InfluxDBClient 实例
     */
    @Bean
    @ConditionalOnProperty(prefix = "spring.datasource.dynamic.datasource.influx", name = "enabled", havingValue = "true")
    public InfluxDBClient influxDBClient(OkHttpClient okHttpClient) {
        return InfluxDBClientFactory.create(
                InfluxDBClientOptions.builder()
                        .url(this.url)
                        .org(this.org)
                        .bucket(this.bucket)
                        .authenticateToken(this.token.toCharArray())
                        .okHttpClient(okHttpClient.newBuilder())
                        .build()
        );
    }

    /**
     * 创建 WriteApiBlocking 写入 API 实例
     *
     * @param influxDBClient InfluxDBClient 实例
     * @return WriteApiBlocking 实例
     */
    @Bean
    @ConditionalOnProperty(prefix = "spring.datasource.dynamic.datasource.influx", name = "enabled", havingValue = "true")
    public WriteApiBlocking writeApi(final InfluxDBClient influxDBClient) {
        return influxDBClient.getWriteApiBlocking();
    }
}
