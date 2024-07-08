package com.fastbee.sip.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.EnumMap;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@AllArgsConstructor
@Getter
public enum AlarmType {
    //设备报警
    videoLost("1", "视频丢失报警", AlarmMethod.devAlarm),
    videoBroken("2", "设备防拆报警", AlarmMethod.devAlarm),
    diskFull("3", "存储设备磁盘满报警", AlarmMethod.devAlarm),
    hot("4", "设备高温报警", AlarmMethod.devAlarm),
    cold("5", "设备低温报警", AlarmMethod.devAlarm),
    //视频报警
    manual("1", "人工视频报警", AlarmMethod.videoAlarm),
    moving("2", "运动目标检测报警", AlarmMethod.videoAlarm),
    residual("3", "遗留物检测报警", AlarmMethod.videoAlarm),
    remove("4", "物体移除检测报警", AlarmMethod.videoAlarm),
    tripLine("5", "绊线检测报警", AlarmMethod.videoAlarm),
    intrusion("6", "入侵检测报警", AlarmMethod.videoAlarm),
    retrograde("7", "逆行检测报警", AlarmMethod.videoAlarm),
    wandering("8", "徘徊检测报警", AlarmMethod.videoAlarm),
    density("9", "密度检测报警", AlarmMethod.videoAlarm),
    error("10", "视频异常检测报警", AlarmMethod.videoAlarm),
    fastMoving("11", "快速移动报警", AlarmMethod.videoAlarm),

    //存储设备
    storageDiskError("1", "存储设备磁盘故障报警", AlarmMethod.devErrorAlarm),

    storageFanError("2", "存储设备风扇故障报警", AlarmMethod.devErrorAlarm);

    private final String code;

    private final String text;

    private final AlarmMethod method;

    private static final Map<AlarmMethod, Map<String, AlarmType>> fastMap = new EnumMap<>(AlarmMethod.class);

    static {
        for (AlarmType value : AlarmType.values()) {
            fastMap.computeIfAbsent(value.method, (ignore) -> new HashMap<>())
                    .put(value.code, value);
        }
    }

    public static Optional<AlarmType> of(AlarmMethod method, String code) {
        Map<String, AlarmType> mapping = fastMap.get(method);
        if (mapping == null) {
            return Optional.empty();
        }
        return Optional.ofNullable(mapping.get(code));
    }

}
