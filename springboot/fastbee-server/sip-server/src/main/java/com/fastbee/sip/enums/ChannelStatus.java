package com.fastbee.sip.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public enum ChannelStatus {
    online("ON", "在线"),

    lost("VLOST", "视频丢失"),
    defect("DEFECT", "故障"),
    add("ADD", "新增"),
    delete("DEL", "删除"),
    update("UPDATE", "更新"),
    offline("OFF", "离线"),
    ;

    private final String code;
    private final String text;

}
