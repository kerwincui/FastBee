package com.fastbee.json;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.annotation.SysProtocol;
import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.mq.DeviceReport;
import com.fastbee.common.core.mq.message.DeviceData;
import com.fastbee.common.core.thingsModel.ThingsModelSimpleItem;
import com.fastbee.common.core.thingsModel.ThingsModelValuesInput;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.model.ThingsModels.ValueItem;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

/**
 * @author gsb
 * @date 2022/10/10 16:55
 */
@Slf4j
@Component
@SysProtocol(name = "JSONArray解析协议",protocolCode = FastBeeConstant.PROTOCOL.JsonArray,description = "系统内置JSONArray解析协议")
public class JsonProtocolService   {


    public DeviceReport decode(DeviceData deviceData, String clientId) {
        try {
            DeviceReport reportMessage = new DeviceReport();
            // bytep[] 转String
            String data = new String(deviceData.getData(),StandardCharsets.UTF_8);
            List<ThingsModelSimpleItem> values = JSON.parseArray(data, ThingsModelSimpleItem.class);
            //上报数据时间
            for (ThingsModelSimpleItem value : values) {
                value.setTs(DateUtils.getNowDate());
            }
            ThingsModelValuesInput valuesInput = new ThingsModelValuesInput();
            valuesInput.setThingsModelValueRemarkItem(values);
            reportMessage.setValuesInput(valuesInput);
            reportMessage.setClientId(clientId);
            reportMessage.setSerialNumber(clientId);
            return reportMessage;
        }catch (Exception e){
            throw new ServiceException("数据解析异常"+e.getMessage());
        }
    }


    public byte[] encode(DeviceData message, String clientId) {
        try {
            JSONObject body = (JSONObject) message.getDownMessage().getBody();
            ValueItem valueItem = new ValueItem();
            for (Map.Entry<String, Object> entry : body.entrySet()) {
                valueItem.setId(entry.getKey());
                valueItem.setValue(entry.getValue()+"");
                valueItem.setRemark("");
            }
            String msg = "[" + JSONObject.toJSONString(valueItem) +"]";
            return msg.getBytes(StandardCharsets.UTF_8);
        }catch (Exception e){
            log.error("=>指令编码异常,device={},data={}",message.getSerialNumber(),
                    message.getDownMessage().getBody());
            return null;
        }
    }
}
