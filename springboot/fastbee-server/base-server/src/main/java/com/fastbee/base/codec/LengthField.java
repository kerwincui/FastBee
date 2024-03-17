package com.fastbee.base.codec;

import static io.netty.util.internal.ObjectUtil.checkPositive;
import static io.netty.util.internal.ObjectUtil.checkPositiveOrZero;

/**
 * 固定长度报文处理器
 * 处理固定长度报文，tcp粘包处理
 * @author bill
 */
public class LengthField {

    public final byte[] prefix;
    /*最大帧长度*/
    public final int lengthFieldMaxFrameLength;
    /*偏移量*/
    public final int lengthFieldOffset;
    /*字段长度*/
    public final int lengthFieldLength;
    /*结尾偏移量*/
    public final int lengthFieldEndOffset;
    /*报文调整 默认0，不调整*/
    public final int lengthAdjustment;
    /*，默认0*/
    public final int initialBytesToStrip;

    /**构造固定长度处理器*/
    public LengthField(byte[] prefix, int maxFrameLength, int lengthFieldOffset, int lengthFieldLength) {
        this(prefix, maxFrameLength, lengthFieldOffset, lengthFieldLength, 0, 0);
    }

    public LengthField(byte[] prefix, int maxFrameLength, int lengthFieldOffset, int lengthFieldLength, int lengthAdjustment, int initialBytesToStrip) {
        checkPositive(maxFrameLength, "maxFrameLength_LengthField");
        checkPositiveOrZero(lengthFieldOffset, "lengthFieldOffset");
        checkPositiveOrZero(initialBytesToStrip, "initialBytesToStrip");
        if (lengthFieldOffset > maxFrameLength - lengthFieldLength) {
            throw new IllegalArgumentException("maxFrameLength_LengthField (" + maxFrameLength + ") must be equal to or greater than lengthFieldOffset (" + lengthFieldOffset + ") + lengthFieldLength (" + lengthFieldLength + ").");
        } else {
            this.prefix = prefix;
            this.lengthFieldMaxFrameLength = maxFrameLength;
            this.lengthFieldOffset = lengthFieldOffset;
            this.lengthFieldLength = lengthFieldLength;
            this.lengthAdjustment = lengthAdjustment;
            this.lengthFieldEndOffset = lengthFieldOffset + lengthFieldLength;
            this.initialBytesToStrip = initialBytesToStrip;
        }
    }

    public byte[] getPrefix() {
        return prefix;
    }

    public int getLengthFieldMaxFrameLength() {
        return lengthFieldMaxFrameLength;
    }

    public int getLengthFieldOffset() {
        return lengthFieldOffset;
    }

    public int getLengthFieldLength() {
        return lengthFieldLength;
    }

    public int getLengthFieldEndOffset() {
        return lengthFieldEndOffset;
    }

    public int getLengthAdjustment() {
        return lengthAdjustment;
    }

    public int getInitialBytesToStrip() {
        return initialBytesToStrip;
    }
}
