package com.fastbee.mqtt.service.impl;

import com.fastbee.common.core.mq.DeviceReport;
import com.fastbee.common.core.mq.DeviceReportBo;
import com.fastbee.common.core.mq.message.DeviceData;
import com.fastbee.common.enums.ServerType;
import com.fastbee.common.enums.ThingsModelType;
import com.fastbee.common.enums.TopicType;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.gateway.mq.TopicsUtils;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.service.IDeviceService;
import com.fastbee.json.JsonProtocolService;
import com.fastbee.mq.model.ReportDataBo;
import com.fastbee.mq.service.IDataHandler;
import com.fastbee.mq.service.IDeviceReportMessageService;
import io.netty.buffer.Unpooled;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Optional;

/**
 * 处理类 处理设备主动上报和设备回调信息
 *
 * @author bill
 */
@Service
@Slf4j
public class DeviceReportMessageServiceImpl implements IDeviceReportMessageService {

    @Autowired
    private IDeviceService deviceService;
    @Autowired
    private JsonProtocolService jsonProtocolService;
    @Resource
    private TopicsUtils topicsUtils;
    @Resource
    private IDataHandler dataHandler;


    /**
     * 处理设备主动上报数据
     */
    @Override
    public void parseReportMsg(DeviceReportBo bo) {
        if (bo.getServerType() == ServerType.MQTT) {
            //构建消息
            Device report = buildReport(bo);
            /*获取协议处理器*/
            DeviceData data = DeviceData.builder()
                    .serialNumber(bo.getSerialNumber())
                    .topicName(bo.getTopicName())
                    .productId(report.getProductId())
                    .data(bo.getData())
                    .prop(bo.getProp())
                    .buf(Unpooled.wrappedBuffer(bo.getData()))
                    .build();
            /*根据协议解析后的数据*/
            DeviceReport reportMessage = jsonProtocolService.decode(data, null);

            reportMessage.setSerialNumber(bo.getSerialNumber());
            reportMessage.setProductId(bo.getProductId());
            reportMessage.setPlatformDate(bo.getPlatformDate());
            reportMessage.setServerType(bo.getServerType());
            reportMessage.setUserId(report.getUserId());
            reportMessage.setUserName(report.getUserName());
            reportMessage.setDeviceName(report.getDeviceName());
            processNoSub(reportMessage, bo.getTopicName());
        }
    }

    /**
     * 构建消息
     *
     * @param bo
     */
    @Override
    public Device buildReport(DeviceReportBo bo) {
        String serialNumber = topicsUtils.parseSerialNumber(bo.getTopicName());
        Device device = deviceService.selectDeviceBySerialNumber(serialNumber);
        Optional.ofNullable(device).orElseThrow(() -> new ServiceException("设备不存在"));
        //设置物模型
        String thingsModel = topicsUtils.getThingsModel(bo.getTopicName());
        ThingsModelType thingsModelType = ThingsModelType.getType(thingsModel);
        bo.setType(thingsModelType);
        //产品id
        bo.setProductId(device.getProductId());
        //设备编号
        bo.setSerialNumber(serialNumber);
        return device;
    }


    /**
     * 处理网关设备
     *
     * @param message
     * @param topicName
     */
    private void processNoSub(DeviceReport message, String topicName) {
        //处理设备上报数据
        handlerReportMessage(message, topicName);
    }


    /**
     * 处理设备主动上报属性
     *
     * @param topicName
     * @param message
     */
    public void handlerReportMessage(DeviceReport message, String topicName) {

        if (message.getServerType().equals(ServerType.MQTT)){
            //处理topic以prop结尾上报的数据 (属性)
            if (message.getServerType().equals(ServerType.MQTT)) {
                if (!topicName.endsWith(TopicType.PROPERTY_POST.getTopicSuffix())
                        && !topicName.endsWith(TopicType.PROPERTY_POST_SIMULATE.getTopicSuffix())) {
                    return;
                }
            }
        }

        ReportDataBo report = new ReportDataBo();
        report.setSerialNumber(message.getSerialNumber());
        report.setProductId(message.getProductId());
        report.setDataList(message.getValuesInput().getThingsModelValueRemarkItem());
        report.setType(1);
        report.setSlaveId(message.getSlaveId());
        report.setUserId(message.getUserId());
        report.setUserName(message.getUserName());
        report.setDeviceName(message.getDeviceName());
        //属性上报执行规则引擎
        report.setRuleEngine(true);
        dataHandler.reportData(report);
    }

}
