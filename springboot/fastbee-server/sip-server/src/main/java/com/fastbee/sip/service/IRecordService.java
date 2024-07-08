package com.fastbee.sip.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fastbee.sip.model.RecordItem;
import com.fastbee.sip.model.RecordList;
import com.fastbee.sip.model.Stream;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface IRecordService {
    RecordList listDevRecord(String deviceId, String channelId, String startTime, String endTime);
    List<RecordItem> listRecord(String channelId, String sn);

    JSONObject listServerRecord(String recordApi, Integer pageNum, Integer pageSize);
    JSONArray listServerRecordByDate(String recordApi, Integer year, Integer month, String app, String stream);
    JSONObject listServerRecordByStream(String recordApi, Integer pageNum, Integer pageSize, String app);
    JSONObject listServerRecordByApp(String recordApi, Integer pageNum, Integer pageSize);
    JSONObject listServerRecordByFile(String recordApi, Integer pageNum, Integer pageSize, String app, String stream, String startTime, String endTime);
    JSONObject listServerRecordByDevice(Integer pageNum, Integer pageSize, String deviceId, String channelId, String startTime, String endTime);
    boolean startRecord(String stream);
    boolean stopRecord(String stream);
    boolean isRecording(String stream);
    JSONObject getMp4RecordFile(String stream,String period);
    Stream download(String deviceId, String channelId,
                    String startTime, String endTime, int downloadSpeed);

    Stream playRecord(String deviceId, String channelId);
}
