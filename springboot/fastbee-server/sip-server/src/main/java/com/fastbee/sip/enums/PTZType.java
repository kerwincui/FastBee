package com.fastbee.sip.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum PTZType {
    unknown(0, "未知"),
    ball(1, "球机"),
    hemisphere(2, "半球机"),
    fixed(3, "固定抢机"),
    remoteControl(4, "遥控抢机");

    private final Integer value;
    private final String text;
}
