package com.fastbee.common.enums;

import com.fastbee.common.constant.HttpStatus;
import lombok.AllArgsConstructor;

/**
 * API返回对象
 */
@AllArgsConstructor
public enum ResultCode implements IErrorCode {

    SUCCESS(HttpStatus.SUCCESS,"请求成功"),
    FAILED(HttpStatus.ERROR,"系统内部错误"),
    ACCEPTED(HttpStatus.ACCEPTED,"请求已接收"),
    REDIRECT(HttpStatus.SEE_OTHER,"重定向"),
    UNAUTHORIZED(HttpStatus.UNAUTHORIZED,"暂未登录或token过期"),
    FORBIDDEN(HttpStatus.FORBIDDEN,"没有相关权限或授权过期"),
    NOT_FOUND(HttpStatus.NOT_FOUND,"资源未找到"),
    PARSE_MSG_EXCEPTION(4018, "解析协议异常"),
    TIMEOUT(502, "响应超时！"),
    FIRMWARE_VERSION_UNIQUE_ERROR(4022, "产品下已存在该版本固件"),
    FIRMWARE_SEQ_UNIQUE_ERROR(4023, "产品下已存在该升级序列号"),
    FIRMWARE_TASK_UNIQUE_ERROR(4024, "任务名已存在"),
    REPLY_TIMEOUT(4001, "超时未回执"),
    INVALID_USER_APP(4002, "用户信息不存在"),
    INVALID_MQTT_USER(1003, "内部mqtt服务用户异常"),
    DECODE_PROTOCOL_EXCEPTION(1000, "解析协议异常"),
    MQTT_TOPIC_INVALID(1001, "MQTT订阅topic格式非法");

    private int code;
    private String message;

    public int getCode(){return code;}

    public String getMessage(){return message;}

}
