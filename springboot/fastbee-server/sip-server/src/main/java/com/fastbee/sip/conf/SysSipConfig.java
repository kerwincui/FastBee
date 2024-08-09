package com.fastbee.sip.conf;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;


@Setter
@Getter
@Component
@ConfigurationProperties(prefix = "sip")
public class SysSipConfig {
    boolean enabled;
    String ip;
    Integer port;
    String domain;
    String id;
    String password;
}
