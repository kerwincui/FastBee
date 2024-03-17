package com.fastbee.mq.redischannel.producer;

import com.fastbee.common.core.mq.DeviceReportBo;
import com.fastbee.common.core.mq.DeviceStatusBo;
import com.fastbee.common.core.mq.MQSendMessageBo;
import com.fastbee.common.core.mq.ota.OtaUpgradeBo;
import com.fastbee.common.core.mq.message.DeviceDownMessage;
import com.fastbee.mq.redischannel.queue.*;

/**
 *设备消息生产者 ,设备的消息发送通道
 * @author bill
 */
public class MessageProducer {

    public static void sendOtherMsg(DeviceReportBo bo){
        DeviceOtherQueue.offer(bo);
    }

}
