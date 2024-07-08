package com.fastbee.sip.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum AlarmMethod {
    unknown("0", "未知"),
    telAlarm("1", "电话报警"),
    devAlarm("2", "设备报警"),
    smsAlarm("3", "短信报警"),
    gpsAlarm("4", "GPS报警"),
    videoAlarm("5", "视频报警"),
    devErrorAlarm("6", "设备故障报警"),
    other("7", "其他报警");
    private final String value;

    private final String text;
}
