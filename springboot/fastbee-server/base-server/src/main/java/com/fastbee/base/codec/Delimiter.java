package com.fastbee.base.codec;

/**
 * 分隔符报文处理器
 * 处理分割符报文，tcp粘包处理
 * @author bill
 */
public class Delimiter {

    public final byte[] value;
    public final boolean strip;

    public Delimiter(byte[] value) {
        this(value, true);
    }

    public Delimiter(byte[] value, boolean strip) {
        this.value = value;
        this.strip = strip;
    }

    public byte[] getValue() {
        return value;
    }

    public boolean isStrip() {
        return strip;
    }
}
