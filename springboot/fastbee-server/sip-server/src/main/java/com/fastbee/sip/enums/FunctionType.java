package com.fastbee.sip.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Objects;

@AllArgsConstructor
@Getter
public enum FunctionType {
    VIDEOPUSH("video_push", "设备推流"),
    AUDIOBROADCAST("audio_broadcast", "语音广播"),
    OTHER("other", "其他");
    private final String value;
    private final String text;
    public static FunctionType fromType(String Type) {
        for (FunctionType type : FunctionType.values()) {
            if (Objects.equals(type.getValue(), Type)) {
                return type;
            }
        }
        return null;
    }

}
