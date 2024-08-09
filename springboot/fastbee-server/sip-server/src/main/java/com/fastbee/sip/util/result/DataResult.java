package com.fastbee.sip.util.result;

import java.io.Serializable;
import java.util.Objects;

public class DataResult<T> extends BaseResult implements Serializable {
    private static final long serialVersionUID = -633787910682534734L;
    private T data;

    private DataResult() {

    }

    private DataResult(CodeEnum codeEnum, T data) {
        super(codeEnum);
        this.data = data;
    }

    public static <T> DataResult<T> out(CodeEnum codeEnum, T data) {
        return new DataResult<>(codeEnum, data);
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        if (!super.equals(o)) {
            return false;
        }
        DataResult<?> that = (DataResult<?>) o;
        return Objects.equals(data, that.data);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), data);
    }
}
