package com.fastbee.mq.redischannel.consumer;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.mq.DeviceReportBo;
import com.fastbee.mq.service.impl.DeviceOtherMsgHandler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * @author gsb
 * @date 2023/2/27 14:33
 */
@Slf4j
@Component
public class DeviceOtherMsgConsumer {

    @Resource
    private DeviceOtherMsgHandler otherMsgHandler;

    @Async(FastBeeConstant.TASK.DEVICE_OTHER_TASK)
    public void consume(DeviceReportBo bo){
        try {
             //处理emq订阅的非 property/post 属性上报的消息 ，因为其他消息量小，放在一起处理
            otherMsgHandler.messageHandler(bo);
        }catch (Exception e){
            log.error("=>设备其他消息处理出错",e);
        }
    }

}
