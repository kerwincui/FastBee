package com.fastbee.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author gsb
 * @date 2022/9/15 9:10
 */
@Getter
@AllArgsConstructor
public enum ServerType {

    MQTT(1, "MQTT","MQTT-BROKER"),
    COAP(2, "COAP","COAP-SERVER"),
    TCP(3, "TCP","TCP-SERVER"),
    UDP(4, "UDP","UDP-SERVER"),
    WEBSOCKET(5,"WEBSOCKET","WEBSOCKET-SERVER"),
    GB28181(6,"GB28181","SIP-SERVER"),
    OTHER(999,"WEBSOCKET","MQTT-BROKER");

    private int type;
    private String code;
    private String des;



    public static ServerType explain(String code) {
        for (ServerType value : ServerType.values()) {
            if (value.code.equals(code)) {
                return value;
            }
        }
        return ServerType.MQTT;
    }
}
