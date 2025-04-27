package com.fastbee.mqtt.service.impl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.mq.DeviceReportBo;
import com.fastbee.common.core.mq.MQSendMessageBo;
import com.fastbee.common.core.mq.message.DeviceData;
import com.fastbee.common.core.mq.message.DeviceDownMessage;
import com.fastbee.common.core.mq.message.InstructionsMessage;
import com.fastbee.common.core.mq.message.MqttBo;
import com.fastbee.common.core.mq.ota.OtaUpgradeBo;
import com.fastbee.common.core.protocol.modbus.ModbusCode;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.core.thingsModel.ThingsModelSimpleItem;
import com.fastbee.common.enums.DeviceStatus;
import com.fastbee.common.enums.FunctionReplyStatus;
import com.fastbee.common.enums.ServerType;
import com.fastbee.common.enums.TopicType;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.common.utils.gateway.CRC16Utils;
import com.fastbee.common.utils.gateway.mq.TopicsUtils;
import com.fastbee.common.utils.ip.IpUtils;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.domain.FunctionLog;
import com.fastbee.iot.domain.Product;
import com.fastbee.iot.model.NtpModel;
import com.fastbee.iot.model.ThingsModels.PropertyDto;
import com.fastbee.iot.ruleEngine.RuleProcess;
import com.fastbee.iot.service.IDeviceService;
import com.fastbee.iot.service.IFunctionLogService;
import com.fastbee.iot.service.IProductService;
import com.fastbee.iot.service.IThingsModelService;
import com.fastbee.iot.util.SnowflakeIdWorker;
import com.fastbee.json.JsonProtocolService;
import com.fastbee.mq.model.ReportDataBo;
import com.fastbee.mq.service.IDataHandler;
import com.fastbee.mq.service.IMqttMessagePublish;
import com.fastbee.mqtt.manager.MqttRemoteManager;
import com.fastbee.mqtt.model.PushMessageBo;
import com.fastbee.mqttclient.PubMqttClient;
import com.fastbee.ruleEngine.context.MsgContext;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

/**
 * 消息推送方法集合
 *
 * @author bill
 */
@Slf4j
@Service
public class MqttMessagePublishImpl implements IMqttMessagePublish {

    @Resource
    private IProductService productService;
    @Resource
    private PubMqttClient mqttClient;

    @Resource
    private PubMqttClient pubMqttClient;

    @Resource
    private TopicsUtils topicsUtils;
    @Resource
    private IDeviceService deviceService;
    @Resource
    private IFunctionLogService functionLogService;
    @Resource
    private MqttRemoteManager remoteManager;

    @Resource
    private IDataHandler dataHandler;
    @Resource
    private IThingsModelService thingsModelService;
    @Resource
    private JsonProtocolService jsonProtocolService;

    private SnowflakeIdWorker snowflakeIdWorker = new SnowflakeIdWorker(3);

    @Resource
    private RuleProcess ruleProcess;

    @Resource
    private RedisCache redisCache;

    @Override
    public InstructionsMessage buildMessage(DeviceDownMessage downMessage, TopicType type) {
        /*返回的组将数据*/
        InstructionsMessage message = new InstructionsMessage();
        /*根据设备编号查询产品信息*/
        if (StringUtils.isEmpty(downMessage.getProtocolCode())) {
            Product product = productService.getProductBySerialNumber(downMessage.getSerialNumber());
            Optional.ofNullable(product).orElseThrow(() -> new ServiceException("产品为空"));
            downMessage.setProtocolCode(product.getProtocolCode());
        }
        String serialNumber = downMessage.getSerialNumber() == null ? "" : downMessage.getSerialNumber();

        /*组建Topic*/
        String topicName = "";
        if (downMessage.getServerType().equals(ServerType.MQTT)) {
            topicName = topicsUtils.buildTopic(downMessage.getProductId(), serialNumber, type);
        }

        DeviceData encodeData = DeviceData.builder()
                .downMessage(downMessage)
                .serialNumber(serialNumber)
                .body(downMessage.getBody())
                .code(downMessage.getCode())
                .topicName(topicName).build();
        //根据协议编码后数据
        byte[] data = jsonProtocolService.encode(encodeData, null);
        message.setMessage(data);
        message.setSerialNumber(serialNumber);
        message.setTopicName(topicName);

        return message;
    }

    /**
     * 服务(指令)下发
     */
    @Override
    public void funcSend(MQSendMessageBo bo) {
        //如果协议编号为空，则获取
        if (StringUtils.isEmpty(bo.getProtocolCode())) {
            Product product = productService.selectProductByProductId(bo.getProductId());
            //bo.setType(ThingsModelType.SERVICE);
            bo.setProtocolCode(product.getProtocolCode());
            bo.setTransport(product.getTransport());
        }

        //处理设备影子模式
        if (null != bo.getIsShadow() && bo.getIsShadow()){
            List<ThingsModelSimpleItem> dataList = new ArrayList<>();
            bo.getValue().forEach((key,value) ->{
                ThingsModelSimpleItem item = new ThingsModelSimpleItem();
                item.setId(key);
                item.setValue(value+"");
                dataList.add(item);
            });
            ReportDataBo dataBo = new ReportDataBo();
            dataBo.setDataList(dataList);
            dataBo.setProductId(bo.getProductId());
            dataBo.setSerialNumber(bo.getSerialNumber());
            dataBo.setRuleEngine(false);
            dataBo.setShadow(true);
            dataBo.setSlaveId(bo.getSlaveId());
            dataBo.setType(bo.getType().getCode());
            dataHandler.reportData(dataBo);
            return;
        }

        /* 下发服务数据存储对象*/
        FunctionLog funcLog = new FunctionLog();
        funcLog.setCreateTime(DateUtils.getNowDate());
        funcLog.setFunValue(bo.getValue().get(bo.getIdentifier()).toString());
        funcLog.setMessageId(bo.getMessageId());
        funcLog.setSerialNumber(bo.getSerialNumber());
        funcLog.setIdentify(bo.getIdentifier());
        funcLog.setShowValue(bo.getShowValue());
        funcLog.setFunType(1);
        funcLog.setModelName(bo.getModelName());
        //兼容子设备
        if (null != bo.getSlaveId()) {
            PropertyDto thingModels = thingsModelService.getSingleThingModels(bo.getProductId(), bo.getIdentifier() + "#" + bo.getSlaveId());
            funcLog.setSerialNumber(bo.getSerialNumber() + "_" + bo.getSlaveId());
            bo.setCode(ModbusCode.Write06);
            if (!Objects.isNull(thingModels.getCode())){
                bo.setCode(ModbusCode.getInstance(Integer.parseInt(thingModels.getCode())));
            }
        }

        ServerType serverType = ServerType.explain(bo.getTransport());
        Optional.ofNullable(serverType).orElseThrow(() -> new ServiceException("产品的传输协议编码为空!"));
        /*下发服务数据处理对象*/
        DeviceDownMessage downMessage = DeviceDownMessage.builder()
                .messageId(bo.getMessageId())
                .body(bo.getValue())
                .serialNumber(bo.getSerialNumber())
                .productId(bo.getProductId())
                .timestamp(DateUtils.getTimestamp())
                .identifier(bo.getIdentifier())
                .slaveId(bo.getSlaveId())
                .code(bo.getCode() == ModbusCode.Read01 ? ModbusCode.Write05 : ModbusCode.Write06)
                .serverType(serverType)
                .build();
        switch (serverType) {
            case MQTT:
                //组建下发服务指令
                InstructionsMessage instruction = buildMessage(downMessage, TopicType.FUNCTION_GET);

                //  规则引擎脚本处理,完成后返回结果
                MsgContext context = ruleProcess.processRuleScript(bo.getSerialNumber(), 2,instruction.getTopicName(),new String(instruction.getMessage()));
                if (!Objects.isNull(context) && StringUtils.isNotEmpty(context.getPayload())
                        && StringUtils.isNotEmpty(context.getTopic())) {
                    instruction.setTopicName(context.getTopic());
                    instruction.setMessage(context.getPayload().getBytes());
                }

                publish(instruction.getTopicName(), instruction.getMessage(), funcLog);
                log.debug("=>服务下发,topic=[{}],指令=[{}]", instruction.getTopicName(),new String(instruction.getMessage()));
                break;

        }
    }
    public void publish(String topic, byte[] pushMessage, FunctionLog log) {
        try {
            redisCache.incr2(FastBeeConstant.REDIS.MESSAGE_SEND_TOTAL, -1L);
            redisCache.incr2(FastBeeConstant.REDIS.MESSAGE_SEND_TODAY, 60 * 60 * 24);
            mqttClient.publish(pushMessage, topic, false, 0);
            if (null != log) {
                //存储服务下发成功
                log.setResultMsg(FunctionReplyStatus.NORELY.getMessage());
                log.setResultCode(FunctionReplyStatus.NORELY.getCode());
                functionLogService.insertFunctionLog(log);
            }
        } catch (Exception e) {
            if (null != log) {
                //服务下发失败存储
                log.setResultMsg(FunctionReplyStatus.FAIl.getMessage() + "原因: " + e.getMessage());
                log.setResultCode(FunctionReplyStatus.FAIl.getCode());
                functionLogService.insertFunctionLog(log);
            }
        }
    }

    /**
     * OTA升级下发
     *
     * @param bo
     */
    @Override
    public void upGradeOTA(OtaUpgradeBo bo) {

    }

    @Override
    public void sendFunctionMessage(DeviceReportBo bo) {
        log.warn("=>功能指令下发,sendFunctionMessage bo=[{}]", bo);
        Device device = deviceService.selectDeviceBySerialNumber(bo.getSerialNumber());
        Optional.ofNullable(device).orElseThrow(()->new ServiceException("服务下发的设备:["+bo.getSerialNumber()+"]不存在"));

        Product product = productService.selectProductByProductId(topicsUtils.parseProductId(bo.getTopicName()));
        ServerType serverType = ServerType.explain(product.getTransport());
        Optional.ofNullable(serverType).orElseThrow(() -> new ServiceException("产品的传输协议编码为空!"));

        switch (serverType) {
            case GB28181:
                break;
        }
    }

    /**
     * 1.发布设备状态
     */
    @Override
    public void publishStatus(Long productId, String deviceNum, int deviceStatus, int isShadow, int rssi) {
        String message = "{\"status\":" + deviceStatus + ",\"isShadow\":" + isShadow + ",\"rssi\":" + rssi + "}";
        String topic = topicsUtils.buildTopic(productId, deviceNum, TopicType.STATUS_POST);
        mqttClient.publish(1, false, topic, message);
    }


    /**
     * 2.发布设备信息
     */
    @Override
    public void publishInfo(Long productId, String deviceNum) {
        String topic = topicsUtils.buildTopic(productId, deviceNum, TopicType.INFO_GET);
        mqttClient.publish(1, false, topic, "");
    }

    /**
     * 3.发布时钟同步信息
     *
     * @param bo 数据模型
     */
    public void publishNtp(ReportDataBo bo) {
        NtpModel ntpModel = JSON.parseObject(bo.getMessage(), NtpModel.class);
        ntpModel.setServerRecvTime(System.currentTimeMillis());
        ntpModel.setServerSendTime(System.currentTimeMillis());
        String topic = topicsUtils.buildTopic(bo.getProductId(), bo.getSerialNumber(), TopicType.NTP_GET);
        mqttClient.publish(1, false, topic, JSON.toJSONString(ntpModel));
    }

    /**
     * 4.发布属性
     * delay 延时，秒为单位
     */
    @Override
    public void publishProperty(Long productId, String deviceNum, List<ThingsModelSimpleItem> thingsList, int delay) {
        String pre = "";
        if (delay > 0) {
            pre = "$delayed/" + String.valueOf(delay) + "/";
        }
        String topic = topicsUtils.buildTopic(productId, deviceNum, TopicType.FUNCTION_GET);
        if (thingsList == null) {
            mqttClient.publish(1, true, topic, "");
        } else {
            mqttClient.publish(1, true, topic, JSON.toJSONString(thingsList));
        }
    }

    /**
     * 5.发布功能
     * delay 延时，秒为单位
     */
    @Override
    public void publishFunction(Long productId, String deviceNum, List<ThingsModelSimpleItem> thingsList, int delay) {
        String pre = "";
        if (delay > 0) {
            pre = "$delayed/" + String.valueOf(delay) + "/";
        }
        String topic = topicsUtils.buildTopic(productId, deviceNum, TopicType.FUNCTION_GET);
        if (thingsList == null) {
            mqttClient.publish(1, true,  topic, "");
        } else {
            mqttClient.publish(1, true,  topic, JSON.toJSONString(thingsList));
        }

    }

    /**
     * 设备数据同步
     *
     * @param deviceNumber 设备编号
     * @return 设备
     */
    public Device deviceSynchronization(String deviceNumber) {
        Device device = deviceService.selectDeviceBySerialNumber(deviceNumber);
        // 1-未激活，2-禁用，3-在线，4-离线
        if (device.getStatus() == 3) {
            device.setStatus(4);
            deviceService.updateDeviceStatus(device);
            // 发布设备信息
            publishInfo(device.getProductId(), device.getSerialNumber());
        }
        return device;
    }


    /**
     * 发送模拟设备到WS
     */
    public void sendSimulationWs(MqttBo send ,MqttBo receive,String topic){
        PushMessageBo messageBo = new PushMessageBo();
        messageBo.setTopic(topic);
        JSONArray array = new JSONArray();
        send.setDirection("send");
        send.setTs(DateUtils.getNowDate());
        receive.setTs(DateUtils.getNowDate());
        receive.setDirection("receive");
        array.add(send);
        array.add(receive);
        messageBo.setMessage(array.toJSONString());
        remoteManager.pushCommon(messageBo);
    }

    public byte[] CRC(byte[] source) {
        source[2] = (byte)((int) source[2] * 2);
        byte[] result = new byte[source.length + 2];
        byte[] crc16Byte = CRC16Utils.getCrc16Byte(source);
        System.arraycopy(source, 0, result, 0, source.length);
        System.arraycopy(crc16Byte, 0, result, result.length - 2, 2);
        return result;
    }

    /**
     * 推送设备状态
     *
     * @param device 设备
     * @param status       状态
     */
    public void pushDeviceStatus(Device device, DeviceStatus status) {
        String message = "{\"status\":" + status.getType() + ",\"isShadow\":" + device.getIsShadow() + ",\"rssi\":" + device.getRssi() + "}";
        String topic = topicsUtils.buildTopic(device.getProductId(), device.getSerialNumber(), TopicType.STATUS_POST);
        pubMqttClient.publish(0, false, topic, message);
    }


    /**
     * 搭建消息
     *
     * @param bo
     * @return
     */
    private DeviceDownMessage buildMessage(OtaUpgradeBo bo) {
        String messageId = String.valueOf(snowflakeIdWorker.nextId());
        bo.setMessageId(messageId);
        bo.setOtaUrl("http://" + IpUtils.getHostIp()+bo.getOtaUrl());
        return DeviceDownMessage.builder()
                .productId(bo.getProductId())
                .serialNumber(bo.getSerialNumber())
                .body(JSON.toJSON(bo))
                .timestamp(DateUtils.getTimestamp())
                .messageId(messageId)
                .build();

    }

}
