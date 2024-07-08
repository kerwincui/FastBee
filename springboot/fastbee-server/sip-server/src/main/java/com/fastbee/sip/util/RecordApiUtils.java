package com.fastbee.sip.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.stereotype.Component;

import javax.validation.constraints.NotNull;
import java.io.IOException;
import java.net.ConnectException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@Slf4j
@Component
public class RecordApiUtils {
    public interface RequestCallback {
        void run(JSONObject response);
    }

    private OkHttpClient getClient() {
        OkHttpClient.Builder httpClientBuilder = new OkHttpClient.Builder();
        return httpClientBuilder.build();
    }

    public JSONObject sendGet(String recoreUrl, String api, Map<String, Object> param, RequestCallback callback) {
        OkHttpClient client = getClient();
        StringBuilder stringBuffer = new StringBuilder();
        stringBuffer.append(String.format("%s/%s", recoreUrl, api));
        JSONObject responseJSON = null;
        if (param != null && param.keySet().size() > 0) {
            stringBuffer.append("?");
            int index = 1;
            for (String key : param.keySet()) {
                if (param.get(key) != null) {
                    stringBuffer.append(key).append("=").append(param.get(key));
                    if (index < param.size()) {
                        stringBuffer.append("&");
                    }
                }
                index++;
            }
        }
        String url = stringBuffer.toString();
        Request request = new Request.Builder()
                .get()
                .url(url)
                .build();
        if (callback == null) {
            try {
                Response response = client.newCall(request).execute();
                if (response.isSuccessful()) {
                    ResponseBody responseBody = response.body();
                    if (responseBody != null) {
                        String responseStr = responseBody.string();
                        responseJSON = JSON.parseObject(responseStr);
                    }
                } else {
                    response.close();
                    Objects.requireNonNull(response.body()).close();
                }
            } catch (ConnectException e) {
                log.error(String.format("连接Assist失败: %s, %s", e.getCause().getMessage(), e.getMessage()));
                log.error("请检查media配置并确认Assist已启动...");
            } catch (IOException e) {
                log.error(String.format("[ %s ]请求失败: %s", url, e.getMessage()));
            }
        } else {
            client.newCall(request).enqueue(new Callback() {
                @Override
                public void onResponse(@NotNull Call call, @NotNull Response response) {
                    if (response.isSuccessful()) {
                        try {
                            String responseStr = Objects.requireNonNull(response.body()).string();
                            callback.run(JSON.parseObject(responseStr));
                        } catch (IOException e) {
                            log.error(String.format("[ %s ]请求失败: %s", url, e.getMessage()));
                        }

                    } else {
                        response.close();
                        Objects.requireNonNull(response.body()).close();
                    }
                }

                @Override
                public void onFailure(@NotNull Call call, @NotNull IOException e) {
                    log.error(String.format("连接Assist失败: %s, %s", e.getCause().getMessage(), e.getMessage()));
                    log.info("请检查media配置并确认Assist已启动...");
                }
            });
        }
        return responseJSON;
    }

    public JSONObject fileDuration(String recoreUrl, String app, String stream, RequestCallback callback) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("stream", stream);
        param.put("recordIng", true);
        return sendGet(recoreUrl, "zlm/record//file/duration", param, callback);
    }

    public JSONObject getInfo(String recoreUrl, RequestCallback callback) {
        Map<String, Object> param = new HashMap<>();
        return sendGet(recoreUrl, "zlm/record//info", param, callback);
    }

    public JSONObject getRecordlist(String recoreUrl, Integer pageNum, Integer pageSize, RequestCallback callback) {
        Map<String, Object> param = new HashMap<>();
        param.put("pageNum", pageNum);
        param.put("pageSize", pageSize);
        return sendGet(recoreUrl, "zlm/record/list", param, callback);
    }

    public JSONObject getRecordDatelist(String recoreUrl, Integer year, Integer month, String app, String stream, RequestCallback callback) {
        Map<String, Object> param = new HashMap<>();
        if(year != null) {
            param.put("year", year);
        }
        if(year != null) {
            param.put("month", month);
        }
        param.put("app", app);
        param.put("stream", stream);
        return sendGet(recoreUrl, "zlm/record/date/list", param, callback);
    }

    public JSONObject getRecordStreamlist(String recoreUrl, Integer pageNum, Integer pageSize, String app, RequestCallback callback) {
        Map<String, Object> param = new HashMap<>();
        param.put("page", pageNum);
        param.put("count", pageSize);
        param.put("app", app);
        return sendGet(recoreUrl, "zlm/record/stream/list", param, callback);
    }

    public JSONObject getRecordApplist(String recoreUrl, Integer pageNum, Integer pageSize, RequestCallback callback) {
        Map<String, Object> param = new HashMap<>();
        param.put("page", pageNum);
        param.put("count", pageSize);
        return sendGet(recoreUrl, "zlm/record/app/list", param, callback);
    }

    public JSONObject getRecordFilelist(String recoreUrl, Integer pageNum, Integer pageSize, String app, String stream, String startTime, String endTime, RequestCallback callback) {
        Map<String, Object> param = new HashMap<>();
        param.put("page", pageNum);
        param.put("count", pageSize);
        param.put("app", app);
        param.put("stream", stream);
        param.put("startTime", startTime);
        param.put("endTime", endTime);
        return sendGet(recoreUrl, "zlm/record/file/list", param, callback);
    }

    public JSONObject addStreamCallInfo(String recoreUrl, String app, String stream, String callId, RequestCallback callback) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("stream", stream);
        param.put("callId", callId);
        return sendGet(recoreUrl, "zlm/record/addStreamCallInfo", param, callback);
    }

    public JSONObject uploadOss(String recoreUrl, String file, RequestCallback callback) {
        Map<String, Object> param = new HashMap<>();
        param.put("resourcePath", file);
        return sendGet(recoreUrl, "file/upload", param, callback);
    }
}
