package com.fastbee.mq.service;

import com.fastbee.common.core.mq.InvokeReqDto;

import java.util.Map;

/**
 * 设备指令下发接口
 * @author gsb
 * @date 2022/12/5 11:03
 */
public interface IFunctionInvoke {


    /**
     * 服务调用,设备不响应
     * @param reqDto 服务下发对象
     * @return 消息id messageId
     */
    public String invokeNoReply(InvokeReqDto reqDto);
}
