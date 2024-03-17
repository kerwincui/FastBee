package com.fastbee.base.model;

import com.fastbee.base.session.Session;

/**
 * @author gsb
 * @date 2023/3/9 10:03
 */
public enum SessionKey {

    DeviceMsg;

    public static DeviceMsg getDeviceMsg(Session session){
       return (DeviceMsg)session.getAttribute(SessionKey.DeviceMsg);
    }
}
