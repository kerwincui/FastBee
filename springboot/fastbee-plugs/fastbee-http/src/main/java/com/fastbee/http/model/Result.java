package com.fastbee.http.model;

/**
 * @author gongjun
 * @since 2016-06-20
 */
public class Result<T> {

    private Integer status;

    private T data;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
