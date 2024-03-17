package com.fastbee.mqtt.service.impl;

import com.alibaba.fastjson2.JSON;
import com.fastbee.common.enums.TopicType;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.gateway.mq.TopicsUtils;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.domain.EventLog;
import com.fastbee.common.core.thingsModel.ThingsModelSimpleItem;
import com.fastbee.common.core.thingsModel.ThingsModelValuesInput;
import com.fastbee.iot.service.IDeviceService;
import com.fastbee.iot.service.IEventLogService;
import com.fastbee.mq.model.ReportDataBo;
import com.fastbee.mq.mqttClient.PubMqttClient;
import com.fastbee.mq.service.IDataHandler;
import com.fastbee.mq.service.IMqttMessagePublish;
import com.fastbee.mqtt.manager.MqttRemoteManager;
import com.fastbee.mqtt.model.PushMessageBo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 上报数据处理方法集合
 * @author bill
 */
@Service
@Slf4j
public class DataHandlerImpl implements IDataHandler {


    @Resource
    private IDeviceService deviceService;
    @Resource
    private IEventLogService eventLogService;
    @Resource
    private IMqttMessagePublish messagePublish;

    @Resource
    private MqttRemoteManager remoteManager;
    @Resource
    private TopicsUtils topicsUtils;

    /**
     * 上报属性或功能处理
     *
     * @param bo 上报数据模型
     */
    @Override
    public void reportData(ReportDataBo bo) {
        try {
            List<ThingsModelSimpleItem> thingsModelSimpleItems = bo.getDataList();
            if (CollectionUtils.isEmpty(bo.getDataList()) || bo.getDataList().size() == 0) {
                thingsModelSimpleItems = JSON.parseArray(bo.getMessage(), ThingsModelSimpleItem.class);
            }
            ThingsModelValuesInput input = new ThingsModelValuesInput();
            input.setProductId(bo.getProductId());
            input.setDeviceNumber(bo.getSerialNumber().toUpperCase());
            input.setThingsModelValueRemarkItem(thingsModelSimpleItems);
            input.setSlaveId(bo.getSlaveId());
            List<ThingsModelSimpleItem> result = deviceService.reportDeviceThingsModelValue(input, bo.getType(), bo.isShadow());


        } catch (Exception e) {
            log.error("接收属性数据，解析数据时异常 message={},e={}", e.getMessage(),e);
        }
    }


    /**
     * 上报事件
     *
     * @param bo 上报数据模型
     */
    @Override
    public void reportEvent(ReportDataBo bo) {
        try {
            List<ThingsModelSimpleItem> thingsModelSimpleItems = JSON.parseArray(bo.getMessage(), ThingsModelSimpleItem.class);
            Device device = deviceService.selectDeviceBySerialNumber(bo.getSerialNumber());
            List<EventLog> results = new ArrayList<>();
            for (int i = 0; i < thingsModelSimpleItems.size(); i++) {
                // 添加到设备日志
                EventLog event = new EventLog();
                event.setDeviceId(device.getDeviceId());
                event.setDeviceName(device.getDeviceName());
                event.setLogValue(thingsModelSimpleItems.get(i).getValue());
                event.setRemark(thingsModelSimpleItems.get(i).getRemark());
                event.setSerialNumber(device.getSerialNumber());
                event.setIdentity(thingsModelSimpleItems.get(i).getId());
                event.setLogType(3);
                event.setIsMonitor(0);
                event.setUserId(device.getUserId());
                event.setUserName(device.getUserName());
                event.setTenantId(device.getTenantId());
                event.setTenantName(device.getTenantName());
                event.setCreateTime(DateUtils.getNowDate());
                // 1=影子模式，2=在线模式，3=其他
                event.setMode(2);
                results.add(event);
                //eventLogService.insertEventLog(event);
            }
            eventLogService.insertBatch(results);
        } catch (Exception e) {
            log.error("接收事件，解析数据时异常 message={}", e.getMessage());
        }
    }

    /**
     * 上报设备信息
     */
    public void reportDevice(ReportDataBo bo) {
        try {
            // 设备实体
            Device deviceEntity = deviceService.selectDeviceBySerialNumber(bo.getSerialNumber());
            // 上报设备信息
            Device device = JSON.parseObject(bo.getMessage(), Device.class);
            device.setProductId(bo.getProductId());
            device.setSerialNumber(bo.getSerialNumber());
            deviceService.reportDevice(device, deviceEntity);
            // 发布设备状态
            messagePublish.publishStatus(bo.getProductId(), bo.getSerialNumber(), 3, deviceEntity.getIsShadow(), device.getRssi());
        } catch (Exception e) {
            log.error("接收设备信息，解析数据时异常 message={}", e.getMessage());
            throw new ServiceException(e.getMessage(), 1);
        }
    }


}
