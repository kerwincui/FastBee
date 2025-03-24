package com.fastbee.data.controller.media;

import com.alibaba.fastjson.JSONObject;
import com.fastbee.sip.service.IZmlHookService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@Api(tags = "流媒体Hook")
@RestController
@RequestMapping("/zlmhook")
public class ZmlHookController
{

    @Autowired
    private IZmlHookService zmlHookService;
    @ApiOperation("访问流媒体服务器上的文件时触发回调")
    @ResponseBody
    @PostMapping(value = "/on_http_access", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onHttpAccess(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onHttpAccess(json).toString(), HttpStatus.OK);
    }
    @ApiOperation("播放器鉴权事件回调")
    @ResponseBody
    @PostMapping(value = "/on_play", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onPlay(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onPlay(json).toString(), HttpStatus.OK);
    }
    @ApiOperation("rtsp/rtmp/rtp推流鉴权事件回调")
    @ResponseBody
    @PostMapping(value = "/on_publish", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onPublish(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onPublish(json).toString(),HttpStatus.OK);
    }
    @ApiOperation("流无人观看时事件回调")
    @ResponseBody
    @PostMapping(value = "/on_stream_none_reader", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onStreamNoneReader(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onStreamNoneReader(json).toString(),HttpStatus.OK);
    }
    @ApiOperation("流未找到事件回调")
    @ResponseBody
    @PostMapping(value = "/on_stream_not_found", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onStreamNotFound(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onStreamNotFound(json).toString(),HttpStatus.OK);
    }
    @ApiOperation("流注册或注销时触发此事件回调")
    @ResponseBody
    @PostMapping(value = "/on_stream_changed", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onStreamChanged(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onStreamChanged(json).toString(),HttpStatus.OK);
    }
    @ApiOperation("流量统计事件回调")
    @ResponseBody
    @PostMapping(value = "/on_flow_report", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onFlowReport(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onFlowReport(json).toString(),HttpStatus.OK);
    }
    @ApiOperation("rtp服务器长时间未收到数据超时回调")
    @ResponseBody
    @PostMapping(value = "/on_rtp_server_timeout", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onRtpServerTimeout(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onRtpServerTimeout(json).toString(),HttpStatus.OK);
    }

    @ApiOperation("rtp发送停止回调")
    @ResponseBody
    @PostMapping(value = "/on_send_rtp_stopped", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onSendRtpStopped(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onSendRtpStopped(json).toString(),HttpStatus.OK);
    }

    @ApiOperation("录制mp4完成后通知事件回调")
    @ResponseBody
    @PostMapping(value = "/on_record_mp4", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onRecordMp4(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onRecordMp4(json).toString(),HttpStatus.OK);
    }

    @ApiOperation("流媒体服务器启动回调")
    @ResponseBody
    @PostMapping(value = "/on_server_started", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onServerStarted(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onServerStarted(json).toString(),HttpStatus.OK);
    }

    @ApiOperation("流媒体服务器心跳回调")
    @ResponseBody
    @PostMapping(value = "/on_server_keepalive", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onServerKeepalive(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onServerKeepalive(json).toString(),HttpStatus.OK);
    }

    @ApiOperation("流媒体服务器存活回调")
    @ResponseBody
    @PostMapping(value = "/on_server_exited", produces = "application/json;charset=UTF-8")
    public ResponseEntity<String> onServerExited(@RequestBody JSONObject json){
        return new ResponseEntity<String>(zmlHookService.onServerExited(json).toString(),HttpStatus.OK);
    }


}
