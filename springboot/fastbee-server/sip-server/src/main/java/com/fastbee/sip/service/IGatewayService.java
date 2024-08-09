package com.fastbee.sip.service;

import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.core.thingsModel.ThingsModelSimpleItem;

import java.util.List;

public interface IGatewayService {
    void sendFunction(String deviceID,List<ThingsModelSimpleItem> functinos);
    void sendFunction(String deviceID,String identifier,String value);
}
