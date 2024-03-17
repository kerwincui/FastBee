package com.fastbee.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Objects;

/**
 * @author gsb
 * @date 2023/6/3 14:09
 */
@Getter
@AllArgsConstructor
public enum DataEnum {

    DECIMAL("decimal", "十进制"),
    DOUBLE("double", "双精度"),
    ENUM("enum","枚举"),
    BOOLEAN("boolean","布尔类型"),
    INTEGER("integer","整形"),
    OBJECT("object", "对象"),
    STRING("string","字符串"),
    ARRAY("array","数组");

    String type;
    String msg;

    public static DataEnum convert(String type){
        for (DataEnum value : DataEnum.values()) {
            if (Objects.equals(value.type, type)){
                return value;
            }
        }
        return DataEnum.STRING;
    }

}
