package com.fastbee.sip.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum PTZCmd {
    out(32),
    in(16),
    up(8),
    down(4),
    left(2),
    right(1);

    private final Integer value;
}
