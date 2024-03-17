package com.fastbee.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum DeviceStatus {

    UNACTIVATED(1,"NOTACTIVE","未激活"),
    FORBIDDEN(2,"DISABLE","禁用"),
    ONLINE(3,"ONLINE","在线"),
    OFFLINE(4,"OFFLINE","离线");

    private int type;
    private String code;
    private String description;

    public static DeviceStatus convert(int type){
        for (DeviceStatus value : DeviceStatus.values()) {
            if (value.type == type){
                return value;
            }
        }
        return null;
    }

    public static DeviceStatus convert(String code){
        for (DeviceStatus value : DeviceStatus.values()) {
            if (value.code.equals(code)){
                return value;
            }
        }
        return null;
    }
}
