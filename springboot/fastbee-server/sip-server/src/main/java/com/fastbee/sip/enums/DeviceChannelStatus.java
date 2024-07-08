package com.fastbee.sip.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum DeviceChannelStatus {
    //1=-未使用，2-在线，3-离线，4-禁用
    notused(1),
    online(2),
    offline(3),
    off(4);
    private final Integer value;
}
