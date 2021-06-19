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

package com.kerwin.wumei.http.interceptor;

import com.xuexiang.xhttp2.interceptor.HttpLoggingInterceptor;
import com.xuexiang.xhttp2.utils.HttpUtils;

import java.io.IOException;

import okhttp3.Connection;
import okhttp3.Protocol;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.ResponseBody;
import okhttp3.internal.http.HttpHeaders;

/**
 * 自定义日志拦截器【简单打印入参和出参】
 *
 * @author xuexiang
 * @since 2018/8/6 上午11:53
 */
public class CustomLoggingInterceptor extends HttpLoggingInterceptor {

    public CustomLoggingInterceptor() {
        super("custom");
        setLevel(Level.PARAM);
    }

    @Override
    protected void logForRequest(Request request, Connection connection) throws IOException {
        RequestBody requestBody = request.body();
        boolean hasRequestBody = requestBody != null;
        Protocol protocol = connection != null ? connection.protocol() : Protocol.HTTP_1_1;

        StringBuilder logBuilder = new StringBuilder();
        try {
            logBuilder.append("--> ")
                    .append(request.method())
                    .append(' ')
                    .append(request.url())
                    .append(' ')
                    .append(protocol)
                    .append("\r\n");
            if (hasRequestBody) {
                logBuilder.append("入参:");
                if (HttpUtils.isPlaintext(requestBody.contentType())) {
                    logBuilder.append(bodyToString(request));
                } else {
                    logBuilder.append("maybe [file part] , too large too print , ignored!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        log(logBuilder.toString());
    }

    @Override
    protected Response logForResponse(Response response, long tookMs) {
        Response clone = response.newBuilder().build();
        ResponseBody responseBody = clone.body();
        log("<-- " + clone.code() + ' ' + clone.message() + ' ' + clone.request().url() + " (" + tookMs + "ms）");
        try {
            if (HttpHeaders.hasBody(clone)) {
                if (responseBody == null) {
                    return response;
                }
                if (HttpUtils.isPlaintext(responseBody.contentType())) {
                    String body = responseBody.string();
                    log("\t出参:" + body);
                    responseBody = ResponseBody.create(responseBody.contentType(), body);
                    return response.newBuilder().body(responseBody).build();
                } else {
                    log("\t出参: maybe [file part] , too large too print , ignored!");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return response;
    }

}
