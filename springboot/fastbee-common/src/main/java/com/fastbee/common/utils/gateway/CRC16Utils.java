package com.fastbee.common.utils.gateway;


import com.fastbee.common.utils.gateway.protocol.ByteUtils;

public class CRC16Utils {

    //ff
    private static int CRC_FF = 0x000000ff;
    //01
    private static int CRC_01 = 0x00000001;
    //04
    private static final int LENGTH_04 = 4;
    //16进制
    private static final int OXFF = 0xff;

    /**
     * 低位在前，高位在后
     *
     * @param bytes
     * @return
     */
    public static String getCRC(byte[] bytes) {
        return getCRC(bytes, true);
    }

    /**
     * @param bytes
     * @param lb    是否低位在前, 高位在后
     * @return
     */
    public static String getCRC(byte[] bytes, boolean lb) {
        int CRC = 0x0000ffff;
        int POLYNOMIAL = 0x0000a001;

        int i, j;
        for (i = 0; i < bytes.length; i++) {
            CRC ^= ((int) bytes[i] & 0x000000ff);
            for (j = 0; j < 8; j++) {
                if ((CRC & 0x00000001) != 0) {
                    CRC >>= 1;
                    CRC ^= POLYNOMIAL;
                } else {
                    CRC >>= 1;
                }
            }
        }

        //结果转换为16进制
        String result = Integer.toHexString(CRC).toUpperCase();
        if (result.length() != 4) {
            StringBuffer sb = new StringBuffer("0000");
            result = sb.replace(4 - result.length(), 4, result).toString();
        }

        if (lb) { // 低位在前, 高位在后
            result = result.substring(2, 4) + result.substring(0, 2);
        }

        return result;
    }

    /**
     * 计算CRC校验和
     *
     * @param bytes
     * @return 返回 byte[]
     */
    public static byte[] getCrc16Byte(byte[] bytes) {

        //寄存器全为1
        int CRC_16 = 0x0000ffff;
        // 多项式校验值
        int POLYNOMIAL = 0x0000a001;
        for (byte aByte : bytes) {
            CRC_16 ^= ((int) aByte & CRC_FF);
            for (int j = 0; j < 8; j++) {
                if ((CRC_16 & CRC_01) != 0) {
                    CRC_16 >>= 1;
                    CRC_16 ^= POLYNOMIAL;
                } else {
                    CRC_16 >>= 1;
                }
            }
        }
        //  低8位 ，高8位
        return new byte[]{(byte) (CRC_16 & OXFF), (byte) (CRC_16 >> 8 & OXFF)};
    }

    public static byte[] CRC(byte[] source) {
        source[2] = (byte) ((int) source[2] * 2);
        byte[] result = new byte[source.length + 2];
        byte[] crc16Byte = CRC16Utils.getCrc16Byte(source);
        System.arraycopy(source, 0, result, 0, source.length);
        System.arraycopy(crc16Byte, 0, result, result.length - 2, 2);
        return result;
    }

    public static byte CRC8(byte[] buffer) {
        int crci = 0xFF; //起始字节FF
        for (int j = 0; j < buffer.length; j++) {
            crci ^= buffer[j] & 0xFF;
            for (int i = 0; i < 8; i++) {
                if ((crci & 1) != 0) {
                    crci >>= 1;
                    crci ^= 0xB8; //多项式当中的那个啥的，不同多项式不一样
                } else {
                    crci >>= 1;
                }
            }
        }
        return (byte) crci;
    }


    public static void main(String[] args)throws Exception {
        String hex = "01000002";
        byte[] bytes = ByteUtils.hexToByte(hex);
        String crc = getCRC(bytes);
        System.out.println(crc);
        String crc8 = "680868333701120008C100";
        byte[] byte8 = ByteUtils.hexToByte(crc8);
        int b = CRC8(byte8);
        System.out.println((int) b);
    }


}
