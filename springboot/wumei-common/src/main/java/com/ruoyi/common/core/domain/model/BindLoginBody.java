package com.ruoyi.common.core.domain.model;

/**
 * 用户登录对象
 * 
 * @author ruoyi
 */
public class BindLoginBody extends LoginBody
{
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
