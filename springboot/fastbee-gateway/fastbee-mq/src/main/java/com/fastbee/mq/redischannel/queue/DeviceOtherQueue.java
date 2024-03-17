package com.fastbee.mq.redischannel.queue;

import com.fastbee.common.core.mq.DeviceReportBo;
import lombok.SneakyThrows;

import java.util.concurrent.LinkedBlockingQueue;

/**
 * @author gsb
 * @date 2022/10/10 10:13
 */
public class DeviceOtherQueue {

    private static final LinkedBlockingQueue<DeviceReportBo> queue = new LinkedBlockingQueue<>();

    /*元素加入队列,最后*/
    public static void offer(DeviceReportBo dto){
        queue.offer(dto);
    }
    /*取出队列元素 先进先出*/
    @SneakyThrows
    public static DeviceReportBo take(){
        return queue.take();
    }
}
