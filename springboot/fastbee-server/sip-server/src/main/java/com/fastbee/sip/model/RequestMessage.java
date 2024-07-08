package com.fastbee.sip.model;

import lombok.Data;

@Data
public class RequestMessage {
    private String id;
    private String deviceId;
    private String type;
    private Object data;
}
