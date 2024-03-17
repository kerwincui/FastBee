package com.fastbee.common.exception.iot;

import com.fastbee.common.exception.GlobalException;
import lombok.NoArgsConstructor;

/**
 * mqtt客户端权限校验异常
 * @author gsb
 * @date 2022/10/8 14:11
 */
@NoArgsConstructor
public class MqttAuthorizationException extends GlobalException {

    public MqttAuthorizationException(String messageId){
        super(messageId);
    }
}
