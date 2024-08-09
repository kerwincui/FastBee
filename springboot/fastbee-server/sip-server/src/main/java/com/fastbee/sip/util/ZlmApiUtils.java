package com.fastbee.sip.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fastbee.common.utils.file.FileUploadUtils;
import com.fastbee.sip.domain.MediaServer;
import com.fastbee.sip.model.ZlmMediaServer;
import com.fastbee.sip.service.IMediaServerService;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.ConnectException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;


@Slf4j
@Component
public class ZlmApiUtils {
    @Autowired
    private IMediaServerService mediaServerService;

    private final int[] udpPortRangeArray = new int[2];
    private OkHttpClient client;
    private int currentPort = 0;

    private OkHttpClient getClient() {
        if (client == null) {
            OkHttpClient.Builder httpClientBuilder = new OkHttpClient.Builder();
            // 设置连接超时时间
            httpClientBuilder.connectTimeout(5, TimeUnit.SECONDS);
            // 设置读取超时时间
            httpClientBuilder.readTimeout(10, TimeUnit.SECONDS);
            // 设置连接池
            httpClientBuilder.connectionPool(new ConnectionPool(16, 5, TimeUnit.MINUTES));
            client = httpClientBuilder.build();
        }
        return client;

    }

    public JSONObject sendPost(MediaServer media, String api, Map<String, Object> param) {
        JSONObject responseJSON = null;
        if (media != null) {
            OkHttpClient client = getClient();
            String url = String.format("http://%s:%s/index/api/%s", media.getIp(), media.getPortHttp(), api);
            log.debug(url);

            FormBody.Builder builder = new FormBody.Builder();
            builder.add("secret", media.getSecret());
            if (param != null) {
                for (String key : param.keySet()) {
                    builder.add(key, param.get(key).toString());
                }
            }

            FormBody body = builder.build();
            Request request = new Request.Builder().post(body).url(url).build();
            try {
                Response response = client.newCall(request).execute();
                if (response.isSuccessful()) {
                    assert response.body() != null;
                    String responseStr = response.body().string();
                    responseJSON = JSON.parseObject(responseStr);
                }
            } catch (ConnectException e) {
                log.error(String.format("连接ZLM失败: %s, %s", e.getCause().getMessage(), e.getMessage()));
                log.info("请检查media配置并确认ZLM已启动...");
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        return responseJSON;
    }

    //config
    public ZlmMediaServer getMediaServerConfig(MediaServer media) {
        JSONObject responseJSON = sendPost(media, "getServerConfig", null);
        ZlmMediaServer mediaServer = null;
        if (responseJSON != null) {
            JSONArray data = responseJSON.getJSONArray("data");
            if (data != null && data.size() > 0) {
                log.info("流媒体服务配置:{}}", data);
                mediaServer = JSON.parseObject(JSON.toJSONString(data.get(0)), ZlmMediaServer.class);
            }
        } else {
            log.error("获取流媒体服务配置失败！");
        }
        return mediaServer;
    }

    public JSONObject setServerConfig(MediaServer media, Map<String, Object> param) {
        return sendPost(media, "setServerConfig", param);
    }

    public JSONObject restartServer(MediaServer media) {
        return sendPost(media, "restartServer", null);
    }

    public JSONObject getMediaList(MediaServer media, String app, String schema, String stream) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("vhost", "__defaultVhost__");
        if (stream != null) {
            param.put("stream", stream);
        }
        if (schema != null) {
            param.put("schema", schema);
        }
        return sendPost(media, "getMediaInfo", param);
    }

    //Record
    public JSONObject startRecord(MediaServer media, String type, String app, String stream) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("type", type); //0为hls，1为mp4
        param.put("stream", stream);
        param.put("vhost", "__defaultVhost__");
        //可选 customized_path 录像保存目录
        //可选 max_second mp4录像切片时间大小,单位秒，置0则采用配置项
        return sendPost(media, "startRecord", param);
    }

    public JSONObject stopRecord(MediaServer media, String type, String app, String stream) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("type", type); //0为hls，1为mp4
        param.put("stream", stream);
        param.put("vhost", "__defaultVhost__");
        return sendPost(media, "stopRecord", param);
    }

    public JSONObject isRecording(MediaServer media, String type, String app, String stream) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("type", type); //0为hls，1为mp4
        param.put("stream", stream);
        param.put("vhost", "__defaultVhost__");
        return sendPost(media, "isRecording", param);
    }

    public JSONObject getMp4RecordFile(MediaServer media, String period, String app, String stream) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("period", period); //示例值：2020-05-26
        param.put("stream", stream);
        param.put("vhost", "__defaultVhost__");
        //可选 customized_path 自定义搜索路径，与startRecord方法中的customized_path一样，默认为配置文件的路径
        return sendPost(media, "getMp4RecordFile", param);
    }

    public JSONObject setRecordSpeed(MediaServer media, String speed, String app, String stream) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("speed", speed); //要设置的录像倍速
        param.put("stream", stream);
        param.put("vhost", "__defaultVhost__");
        return sendPost(media, "setRecordSpeed", param);
    }

    public JSONObject seekRecordStamp(MediaServer media, String stamp, String app, String stream) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("stamp", stamp); //要设置的录像播放位置
        param.put("stream", stream);
        param.put("vhost", "__defaultVhost__");
        return sendPost(media, "seekRecordStamp", param);
    }

    //Rtp
    public JSONObject getRtpInfo(MediaServer media, String stream_id) {
        Map<String, Object> param = new HashMap<>();
        param.put("stream_id", stream_id);
        return sendPost(media, "getRtpInfo", param);
    }

    public JSONObject openRtpServer(MediaServer media, Map<String, Object> param) {
        return sendPost(media, "openRtpServer", param);
    }

    public JSONObject closeRtpServer(MediaServer media, Map<String, Object> param) {
        return sendPost(media, "closeRtpServer", param);
    }

    public JSONObject listRtpServer(MediaServer media) {
        Map<String, Object> param = new HashMap<>();
        return sendPost(media, "listRtpServer", null);
    }

    public JSONObject startSendRtp(MediaServer media, String app, String stream, String ssrc, String dst_url, String dst_port, String is_udp) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("vhost", "__defaultVhost__");
        param.put("stream", stream);
        param.put("ssrc", ssrc); //rtp推流的ssrc，ssrc不同时，可以推流到多个上级服务器
        param.put("dst_url", dst_url); // 目标ip或域名
        param.put("dst_port", dst_port); //`目标端口
        param.put("is_udp", is_udp); //是否udp方式
        // 可选参数 src_port 使用的本机端口，为0或不传时默认为随机端口
        // 可选参数 pt 发送时，rtp的pt（uint8_t）,不传时默认为96
        // 可选参数 use_ps 发送时，rtp的负载类型。为1时，负载为ps；为0时，为es；不传时默认为1
        // 可选参数 only_audio 当use_ps 为0时，有效。为1时，发送音频；为0时，发送视频；不传时默认为0
        return sendPost(media, "seekRecordStamp", param);
    }

    public JSONObject startSendRtpPassive(MediaServer media, String ssrc, String app, String stream) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("stream", stream);
        param.put("vhost", "__defaultVhost__");
        param.put("ssrc", ssrc); //rtp推流的ssrc，ssrc不同时，可以推流到多个上级服务器
        // 可选参数 src_port 使用的本机端口，为0或不传时默认为随机端口
        // 可选参数 pt 发送时，rtp的pt（uint8_t）,不传时默认为96
        // 可选参数 use_ps 发送时，rtp的负载类型。为1时，负载为ps；为0时，为es；不传时默认为1
        // 可选参数 only_audio 当use_ps 为0时，有效。为1时，发送音频；为0时，发送视频；不传时默认为0
        return sendPost(media, "seekRecordStamp", param);
    }

    public JSONObject stopSendRtp(MediaServer media, String ssrc, String app, String stream) {
        Map<String, Object> param = new HashMap<>();
        param.put("app", app);
        param.put("stream", stream);
        param.put("vhost", "__defaultVhost__");
        param.put("ssrc", ssrc); //可选参数 根据ssrc关停某路rtp推流，置空时关闭所有流
        return sendPost(media, "seekRecordStamp", param);
    }

    public int createRTPServer(MediaServer media, String streamId, String ssrc, Boolean onlyAuto, Boolean reUsePort, Integer tcpMode) {
        int result = -1;
        // 查询此rtp server 是否已经存在
        JSONObject rtpInfo = getRtpInfo(media, streamId);
        log.info(JSONObject.toJSONString(rtpInfo));
        if (rtpInfo.getInteger("code") == 0) {
            if (rtpInfo.getBoolean("exist")) {
                result = rtpInfo.getInteger("local_port");
                if (result == 0) {
                    // 此时说明rtpServer已经创建但是流还没有推上来
                    // 此时重新打开rtpServer
                    Map<String, Object> param = new HashMap<>();
                    param.put("stream_id", streamId);
                    JSONObject jsonObject = closeRtpServer(media, param);
                    if (jsonObject != null) {
                        if (jsonObject.getInteger("code") == 0) {
                            return createRTPServer(media, streamId, ssrc, onlyAuto, reUsePort, tcpMode);
                        } else {
                            log.warn("[开启rtpServer], 重启RtpServer错误");
                        }
                    }
                }
                return result;
            }
        } else if (rtpInfo.getInteger("code") == -2) {
            return result;
        }

        if (media != null) {
            Map<String, Object> param = new HashMap<>();
            // 推流端口设置0则使用随机端口
            param.put("port", 0);
            if (tcpMode == null) {
                tcpMode = 0;
            }
            //0 udp 模式，1 tcp 被动模式, 2 tcp 主动模式。 (兼容enable_tcp 为0/1)
            param.put("tcp_mode", tcpMode);
            param.put("stream_id", streamId);
            if (reUsePort != null) {
                param.put("re_use_port", reUsePort ? "1" : "0");
            }
            if (onlyAuto != null) {
                param.put("only_audio", onlyAuto ? "1" : "0");
            }
            if (ssrc != null) {
                param.put("ssrc", ssrc);
            }
            JSONObject jsonObject = openRtpServer(media, param);
            log.warn("param:{},createRTPServer:{}", param, jsonObject);
            if (jsonObject != null) {
                if (jsonObject.getInteger("code") == 0) {
                    result = jsonObject.getInteger("port");
                } else {
                    log.error("创建RTP Server 失败 {}: ", jsonObject.getString("msg"));
                }
            } else {
                log.error("创建RTP Server 失败: 请检查ZLM服务");
            }
        }
        return result;
    }

    public boolean closeRTPServer(MediaServer media, String streamId) {
        boolean result = false;
        Map<String, Object> param = new HashMap<>();
        param.put("stream_id", streamId);
        JSONObject jsonObject = closeRtpServer(media, param);
        if (jsonObject != null) {
            if (jsonObject.getInteger("code") == 0) {
                result = jsonObject.getInteger("hit") == 1;
            } else {
                log.error("关闭RTP Server 失败: " + jsonObject.getString("msg"));
            }
        } else {
            //  检查ZLM状态
            log.error("关闭RTP Server 失败: 请检查ZLM服务");
        }
        return result;
    }

    private int getPortFromUdpPortRange(String udpPortRange) {
        if (currentPort == 0) {
            String[] udpPortRangeStrArray = udpPortRange.split(",");
            udpPortRangeArray[0] = Integer.parseInt(udpPortRangeStrArray[0]);
            udpPortRangeArray[1] = Integer.parseInt(udpPortRangeStrArray[1]);
        }

        if (currentPort == 0 || currentPort++ > udpPortRangeArray[1]) {
            currentPort = udpPortRangeArray[0];
            return udpPortRangeArray[0];
        } else {
            if (currentPort % 2 == 1) {
                currentPort++;
            }
            return currentPort++;
        }
    }

    //获取截图
    public void getSnap(MediaServer media, String streamUrl, int timeout_sec, int expire_sec, String fileName) {
        Map<String, Object> param = new HashMap<>(3);
        param.put("url", streamUrl);
        param.put("timeout_sec", timeout_sec);
        param.put("expire_sec", expire_sec);
        sendGetForImg(media, "getSnap", param, fileName);
    }

    public void sendGetForImg(MediaServer media, String api, Map<String, Object> params, String fileName) {
        String url = String.format("http://%s:%s/index/api/%s", media.getIp(), media.getPortHttp(), api);
        HttpUrl parseUrl = HttpUrl.parse(url);
        if (parseUrl == null) {
            return;
        }
        HttpUrl.Builder httpBuilder = parseUrl.newBuilder();
        httpBuilder.addQueryParameter("secret", media.getSecret());
        if (params != null) {
            for (Map.Entry<String, Object> param : params.entrySet()) {
                httpBuilder.addQueryParameter(param.getKey(), param.getValue().toString());
            }
        }
        Request request = new Request.Builder()
                .url(httpBuilder.build())
                .build();
        try {
            OkHttpClient client = getClient();
            Response response = client.newCall(request).execute();
            if (response.isSuccessful()) {
                File snapFolder = new File(FileUploadUtils.getDefaultBaseDir() + File.separator + "snap");
                if (!snapFolder.exists()) {
                    if (!snapFolder.mkdirs()) {
                        log.warn("{}路径创建失败", snapFolder.getAbsolutePath());
                    }
                }
                File snapFile = new File(snapFolder.getAbsolutePath() + File.separator + fileName);
                log.info("截图成功：{}", snapFile.getAbsolutePath());
                FileOutputStream outStream = new FileOutputStream(snapFile);
                outStream.write(Objects.requireNonNull(response.body()).bytes());
                outStream.flush();
                outStream.close();
                Objects.requireNonNull(response.body()).close();
            } else {
                log.error(String.format("[ %s ]请求失败: %s %s", url, response.code(), response.message()));
            }
        } catch (ConnectException e) {
            log.error(String.format("连接ZLM失败: %s, %s", e.getCause().getMessage(), e.getMessage()));
            log.info("请检查media配置并确认ZLM已启动...");
        } catch (IOException e) {
            log.error(String.format("[ %s ]请求失败: %s", url, e.getMessage()));
        }
    }
}
