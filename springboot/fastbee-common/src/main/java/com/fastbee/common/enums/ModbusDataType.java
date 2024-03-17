package com.fastbee.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Objects;

/**
 * @author gsb
 * @date 2023/9/4 14:46
 */
@Getter
@AllArgsConstructor
public enum ModbusDataType {


    U_SHORT("ushort","16位 无符号"),
    SHORT("short","16位 有符号"),
    LONG_ABCD("long-ABCD","32位 有符号(ABCD)"),
    LONG_CDAB("long-CDAB","32位 有符号(CDAB)"),
    U_LONG_ABCD("ulong-ABCD","32位 无符号(ABCD)"),
    U_LONG_CDAB("ulong-CDAB","32位 无符号(CDAB)"),
    FLOAT_ABCD("float-ABCD","32位 浮点数(ABCD)"),
    FLOAT_CDAB("float-CDAB","32位 浮点数(CDAB)"),
    BIT("bit","位");

    String type;
    String msg;

    public static ModbusDataType convert(String type){
        for (ModbusDataType value : ModbusDataType.values()) {
            if (Objects.equals(value.type,type)){
                return value;
            }
        }
        return ModbusDataType.U_SHORT;
    }
}
