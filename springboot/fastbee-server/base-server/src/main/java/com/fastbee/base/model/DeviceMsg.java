package com.fastbee.base.model;

import lombok.Data;

/**
 * @author gsb
 * @date 2023/3/9 10:07
 */
@Data
public class DeviceMsg {

    protected String clientId;

    protected Long deviceId;

    private int protocolVersion;

    private Long productId;
}
