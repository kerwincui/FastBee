package com.fastbee.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * OTA升级状态
 * @author gsb
 * @date 2022/10/24 17:29
 */
@AllArgsConstructor
@Getter
public enum OTAUpgrade {


    AWAIT(0, "等待升级","未推送固件到设备"),
    SEND(1, "已发送","已发送设备"),
    REPLY(2, "升级中","设备OTA升级中"),
    SUCCESS(3, "成功","升级成功"),
    FAILED(4, "失败","升级失败"),
    STOP(5, "停止","设备离线停止推送"),
    UNKNOWN(404, "未知","未知错误码");
    Integer status;
    String subMsg;
    String des;

    public static OTAUpgrade parse(Integer code){
        for (OTAUpgrade item: OTAUpgrade.values()){
            if(item.status.equals(code)){
                return item;
            }
        }

        return UNKNOWN;
    }

}
