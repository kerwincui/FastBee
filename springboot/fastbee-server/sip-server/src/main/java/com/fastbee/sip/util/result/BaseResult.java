package com.fastbee.sip.util.result;

import lombok.Data;

import java.io.Serializable;

@Data
public class BaseResult implements Serializable {
    private static final long serialVersionUID = 1383530376576722749L;
    private int code;
    private String msg;

    protected BaseResult() {
    }

    protected BaseResult(CodeEnum codeEnum) {
        this.code = codeEnum.getCode();
        this.msg = codeEnum.getMsg();
    }

    protected BaseResult(CodeEnum codeEnum, String msg) {
        this.code = codeEnum.getCode();
        this.msg = msg;
    }

    public static BaseResult out(CodeEnum codeEnum) {
        return new BaseResult(codeEnum);
    }

    public static BaseResult out(CodeEnum codeEnum, String msg) {
        return new BaseResult(codeEnum, msg);
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
