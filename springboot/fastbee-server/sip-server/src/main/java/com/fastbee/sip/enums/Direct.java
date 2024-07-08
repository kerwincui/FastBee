package com.fastbee.sip.enums;

import lombok.AllArgsConstructor;

import java.util.Arrays;

@AllArgsConstructor
public enum Direct {
    UP(0x08),
    DOWN(0x04),
    LEFT(0x02),
    RIGHT(0x01),
    ZOOM_IN(0x10),
    ZOOM_OUT(0x20),
    STOP(0) {
        @Override
        public int merge(int code) {
            return code;
        }

        @Override
        public boolean match(int code) {
            return code == 0;
        }
    };
    private final int code;

    public int merge(int code) {
        return code | this.code;
    }

    public boolean match(int code) {
        return (code & this.code) != 0;
    }

    public static Direct[] values(int code) {
        return Arrays
                .stream(values())
                .filter(direct -> direct.match(code))
                .toArray(Direct[]::new);
    }

    public static Direct[] values(String code) {
        String[] codes = code.toUpperCase().split(",");

        return Arrays
                .stream(codes)
                .map(Direct::valueOf)
                .toArray(Direct[]::new);
    }
}
