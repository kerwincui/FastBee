package com.fastbee.sip.util.result;

public enum CodeEnum {
    /**
     * CodeEnum
     */
    SUCCESS(200, "成功"),
    FAIL(500, "失败");

    private final int code;
    private final String msg;

    CodeEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
