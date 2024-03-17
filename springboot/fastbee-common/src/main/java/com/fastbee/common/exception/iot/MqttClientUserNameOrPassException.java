package com.fastbee.common.exception.iot;

import com.fastbee.common.exception.GlobalException;
import lombok.NoArgsConstructor;

/**
 * mqtt客户端校验 用户名或密码错误
 * @author gsb
 * @date 2022/10/8 14:15
 */
@NoArgsConstructor
public class MqttClientUserNameOrPassException extends GlobalException {

    public MqttClientUserNameOrPassException(String message){
        super(message);
    }
}
