package com.fastbee.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 物模型类型
 *
 * @author bill
 */
@Getter
@AllArgsConstructor
public enum ThingsModelType {

    PROP(1, "PROPERTY", "属性","properties"),
    SERVICE(2, "FUNCTION", "服务","functions"),
    EVENT(3, "EVENT", "事件","events"),;

    int code;
    String type;
    String name;
    String list;

    public static ThingsModelType getType(int code) {
        for (ThingsModelType value : ThingsModelType.values()) {
            if (value.code == code) {
                return value;
            }
        }
        return ThingsModelType.PROP;
    }

    public static ThingsModelType getType(String type) {
        for (ThingsModelType value : ThingsModelType.values()) {
            if (value.type.equals(type)) {
                return value;
            }
        }
        return ThingsModelType.PROP;
    }

    public static String getName(int code) {
        for (ThingsModelType value : ThingsModelType.values()) {
            if (value.code == code) {
                return value.list;
            }
        }
        return ThingsModelType.PROP.list;
    }
}
