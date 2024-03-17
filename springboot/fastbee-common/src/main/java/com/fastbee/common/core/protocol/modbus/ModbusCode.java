package com.fastbee.common.core.protocol.modbus;

import com.fastbee.common.exception.ServiceException;
import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Modbus功能码
 * @author bill
 *
 * {bit 位操作}
 * 线圈寄存器：   bit对应一个信号的开关状态。功能码里面又分为写单个线圈寄存器和写多个线圈寄存器。对应上面的功能码也就是：0x01  0x05  0x0f
 * 离散输入寄存器：离散输入寄存器就 是 只读线圈寄存器，每个bit表示一个开关量，是不能够写的。 功能码： 0x02
 *
 * {byte 字节操作}
 * 保持寄存器：  两个byte，可读写的 写也分为单个写和多个写对应的三个：0x03 0x06 0x10
 * 输入寄存器：  和保持寄存器类似，只支持读而不能写，一般是读取各种实时数据。一个寄存器也是占据两个byte的空间。对应的功能码： 0x04
 *
 */
@Getter
@AllArgsConstructor
public enum ModbusCode {

    Read01("读线圈",(byte) 0x01), // 读线圈(读写位模式)
    Read02("读离散量输入",(byte) 0x02), // 读离散量输入(位只读模式)
    Read03("读保持寄存器",(byte) 0x03), // 读保持寄存器(字节读写模式)
    Read04("读输入寄存器",(byte) 0x04), // 读输入寄存器(字节只读模式)

    Write05("写单个线圈(读写位模式)",(byte) 0x05), // 写单个线圈(读写位模式)
    Write06("写多个线圈",(byte) 0x06), // 写单个保持寄存器
    Write0F("写多个线圈",(byte) 0x0F), // 写多个线圈
    Write10("写多个保持寄存器",(byte) 0x10) // 写多个保持寄存器
    ;

    private String desc;
    private byte code;

    public static ModbusCode getInstance(int code) {
        switch ((byte)code) {
            case 0x01:
                return Read01;
            case 0x02:
                return Read02;
            case 0x03:
                return Read03;
            case 0x04:
                return Read04;

            case 0x05:
                return Write05;
            case 0x06:
                return Write06;
            case 0x0F:
                return Write0F;
            case 0x10:
                return Write10;

            default:
                throw new ServiceException("功能码[" + code + "],未定义");
        }
    }

    public static String getDes(int code){
        switch ((byte)code) {
            case 0x01:
                return Read01.desc;
            case 0x02:
                return Read02.desc;
            case 0x03:
                return Read03.desc;
            case 0x04:
                return Read04.desc;
            case 0x05:
                return Write05.desc;
            case 0x06:
                return Write06.desc;
            case 0x0F:
                return Write0F.desc;
            case 0x10:
                return Write10.desc;

            default:
                return "UNKOWN";
        }
    }

}
