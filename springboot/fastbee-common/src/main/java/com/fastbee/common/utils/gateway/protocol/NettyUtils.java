package com.fastbee.common.utils.gateway.protocol;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.ByteBufUtil;

/**
 * @author gsb
 * @date 2022/9/15 14:44
 */
public class NettyUtils {

    /**
     * ByteBuf转 byte[]
     * @param buf buffer
     * @return byte[]
     */
    public static byte[] readBytesFromByteBuf(ByteBuf buf){
        return ByteBufUtil.getBytes(buf);
    }


}
