package com.fastbee.common.core.domain.model;

/**
 * 用户注册对象
 *
 * @author ruoyi
 */
public class BindRegisterBody extends RegisterBody {
    /**
     * 绑定id
     */
    private String bindId;

    public String getBindId() {
        return bindId;
    }

    public void setBindId(String bindId) {
        this.bindId = bindId;
    }
}
