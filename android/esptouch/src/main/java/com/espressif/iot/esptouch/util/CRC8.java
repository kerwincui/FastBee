package com.espressif.iot.esptouch.util;

import java.util.zip.Checksum;

public class CRC8 implements Checksum {

    private static final short[] crcTable = new short[256];
    private static final short CRC_POLYNOM = 0x8c;
    private static final short CRC_INITIAL = 0x00;

    static {
        for (int dividend = 0; dividend < 256; dividend++) {
            int remainder = dividend;// << 8;
            for (int bit = 0; bit < 8; ++bit)
                if ((remainder & 0x01) != 0)
                    remainder = (remainder >>> 1) ^ CRC_POLYNOM;
                else
                    remainder >>>= 1;
            crcTable[dividend] = (short) remainder;
        }
    }

    private final short init;
    private short value;

    public CRC8() {
        this.value = this.init = CRC_INITIAL;
    }

    @Override
    public void update(byte[] buffer, int offset, int len) {
        for (int i = 0; i < len; i++) {
            int data = buffer[offset + i] ^ value;
            value = (short) (crcTable[data & 0xff] ^ (value << 8));
        }
    }

    /**
     * Updates the current checksum with the specified array of bytes.
     * Equivalent to calling <code>update(buffer, 0, buffer.length)</code>.
     *
     * @param buffer the byte array to update the checksum with
     */
    public void update(byte[] buffer) {
        update(buffer, 0, buffer.length);
    }

    @Override
    public void update(int b) {
        update(new byte[]{(byte) b}, 0, 1);
    }

    @Override
    public long getValue() {
        return value & 0xff;
    }

    @Override
    public void reset() {
        value = init;
    }

}
