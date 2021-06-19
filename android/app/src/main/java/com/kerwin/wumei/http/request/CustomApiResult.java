/*
 * Copyright (C) 2018 xuexiangjys(xuexiangjys@163.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.kerwin.wumei.http.request;

import com.xuexiang.xhttp2.model.ApiResult;

/**
 * @author xuexiang
 * @since 2018/8/7 下午5:23
 */
public class CustomApiResult<T> extends ApiResult<T> {

    private int errorCode;
    private String errorInfo;
    private T result;
    private long timeStamp;

    public int getErrorCode() {
        return errorCode;
    }

    public CustomApiResult<T> setErrorCode(int errorCode) {
        this.errorCode = errorCode;
        return this;
    }

    public String getErrorInfo() {
        return errorInfo;
    }

    public CustomApiResult<T> setErrorInfo(String errorInfo) {
        this.errorInfo = errorInfo;
        return this;
    }

    public T getResult() {
        return result;
    }

    public CustomApiResult<T> setResult(T result) {
        this.result = result;
        return this;
    }

    public long getTimeStamp() {
        return timeStamp;
    }

    public CustomApiResult<T> setTimeStamp(long timeStamp) {
        this.timeStamp = timeStamp;
        return this;
    }

    @Override
    public int getCode() {
        return errorCode;
    }

    @Override
    public String getMsg() {
        return errorInfo;
    }

    @Override
    public boolean isSuccess() {
        return errorCode == 0;
    }

    @Override
    public T getData() {
        return result;
    }

    @Override
    public String toString() {
        return "ApiResult{" +
                "errorCode='" + errorCode + '\'' +
                ", errorInfo='" + errorInfo + '\'' +
                ", timeStamp='" + timeStamp + '\'' +
                ", result=" + result +
                '}';
    }
}
