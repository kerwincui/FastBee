package com.fastbee.data.controller.media;

import com.fastbee.common.core.controller.BaseController;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.sip.model.RecordList;
import com.fastbee.sip.service.IRecordService;
import com.fastbee.sip.util.WebAsyncUtil;
import com.fastbee.sip.util.result.BaseResult;
import com.fastbee.sip.util.result.CodeEnum;
import com.fastbee.sip.util.result.DataResult;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.async.WebAsyncTask;

@Slf4j
@RestController
@RequestMapping("/sip/record")
public class RecordController extends BaseController {

    @Autowired
    private IRecordService recordService;

    @Qualifier("taskExecutor")
    @Autowired
    private ThreadPoolTaskExecutor taskExecutor;
    @ApiOperation("设备录像查询")
    @PreAuthorize("@ss.hasPermi('iot:video:list')")
    @GetMapping("/devquery/{deviceId}/{channelId}")
    public WebAsyncTask<Object> devquery(@PathVariable String deviceId,
                                         @PathVariable String channelId, String start, String end) {
        return WebAsyncUtil.init(taskExecutor, () -> {
            try {
                RecordList result = recordService.listDevRecord(deviceId, channelId, start, end);
                return DataResult.out(CodeEnum.SUCCESS, result);
            } catch (Exception e) {
                log.error("", e);
                return BaseResult.out(CodeEnum.FAIL, e.getMessage());
            }
        });
    }
    @ApiOperation("设备录像缓存查询")
    @PreAuthorize("@ss.hasPermi('iot:video:list')")
    @GetMapping("/query/{channelId}/{sn}")
    public AjaxResult list(@PathVariable String channelId,
                           @PathVariable String sn) {
        return AjaxResult.success("success!", recordService.listRecord(channelId, sn));
    }

    @ApiOperation("指定流ID开始录像")
    @PreAuthorize("@ss.hasPermi('iot:video:list')")
    @GetMapping("/start/{stream}")
    public AjaxResult startRecord(@PathVariable String stream) {
        boolean result = recordService.startRecord(stream);
        if (result) {
            return AjaxResult.success("success!");
        } else {
            return AjaxResult.error("error!");
        }
    }

    @ApiOperation("指定流ID停止录像")
    @PreAuthorize("@ss.hasPermi('iot:video:list')")
    @GetMapping("/stop/{stream}")
    public AjaxResult stopRecord(@PathVariable String stream) {
        boolean result = recordService.stopRecord(stream);
        if (result) {
            return AjaxResult.success("success!");
        } else {
            return AjaxResult.error("error!");
        }
    }

    @ApiOperation("获取流对应的录像文件列表")
    @PreAuthorize("@ss.hasPermi('iot:video:list')")
    @GetMapping("/file/{stream}/{period}")
    public AjaxResult getMp4RecordFile(@PathVariable String stream,
                                       @PathVariable String period) {
        return AjaxResult.success("success!", recordService.getMp4RecordFile(stream, period));
    }

    @ApiOperation("直播录像")
    @GetMapping("/play/{deviceId}/{channelId}")
    public AjaxResult playRecord(@PathVariable String deviceId, @PathVariable String channelId) {
        logger.debug(String.format("直播录像 API调用，deviceId：%s，channelId：%s", deviceId, channelId));
        return AjaxResult.success("success!", recordService.playRecord(deviceId, channelId));
    }

    @PreAuthorize("@ss.hasPermi('iot:sip:record:download')")
    @ApiOperation("设备录像下载")
    @GetMapping("/download/{deviceId}/{channelId}")
    public AjaxResult download(@PathVariable String deviceId, @PathVariable String channelId,
                               String startTime, String endTime, String speed) {
        logger.debug(String.format("设备录像下载 API调用，deviceId：%s，channelId：%s，downloadSpeed：%s", deviceId, channelId, speed));
        return AjaxResult.success("success!", recordService.download(deviceId, channelId, startTime, endTime, Integer.parseInt(speed)));
    }



    @ApiOperation("查询服务端录像列表")
    @PreAuthorize("@ss.hasPermi('iot:sip:record:list')")
    @GetMapping("/serverRecord/list")
    public AjaxResult listServerRecord(@RequestParam Integer pageNum,
                                       @RequestParam Integer pageSize, @RequestParam String recordApi) {
        try{
            Object data = recordService.listServerRecord(recordApi, pageNum, pageSize);
            return AjaxResult.success("success!", data);
        }catch(Exception e){
            return AjaxResult.error("连接超时或发生错误，未获取到数据!");
        }
    }
    @ApiOperation("通过日期查询服务端录像列表")
    @PreAuthorize("@ss.hasPermi('iot:sip:record:list')")
    @GetMapping("/serverRecord/date/list")
    public AjaxResult listServerRecordByDate(@RequestParam(required = false) Integer year,
                                             @RequestParam(required = false) Integer month, @RequestParam String app, @RequestParam String stream, @RequestParam String recordApi) {
        return AjaxResult.success("success!", recordService.listServerRecordByDate(recordApi, year, month, app, stream));
    }
    @ApiOperation("通过流ID查询服务端录像列表")
    @PreAuthorize("@ss.hasPermi('iot:sip:record:list')")
    @GetMapping("/serverRecord/stream/list")
    public AjaxResult listServerRecordByStream(@RequestParam Integer pageNum,
                                               @RequestParam Integer pageSize, @RequestParam String app, @RequestParam String recordApi) {
        return AjaxResult.success("success!", recordService.listServerRecordByStream(recordApi, pageNum, pageSize, app));
    }
    @ApiOperation("通过应用名查询服务端录像列表")
    @PreAuthorize("@ss.hasPermi('iot:sip:record:list')")
    @GetMapping("/serverRecord/app/list")
    public AjaxResult listServerRecordByApp(@RequestParam Integer pageNum,
                                            @RequestParam Integer pageSize, @RequestParam String recordApi) {
        return AjaxResult.success("success!", recordService.listServerRecordByApp(recordApi, pageNum, pageSize));
    }
    @ApiOperation("通过文件名查询服务端录像列表")
    @PreAuthorize("@ss.hasPermi('iot:sip:record:list')")
    @GetMapping("/serverRecord/file/list")
    public AjaxResult listServerRecordByFile(@RequestParam Integer pageNum, @RequestParam Integer pageSize,
                                             @RequestParam String app, @RequestParam String stream,
                                             @RequestParam String startTime, @RequestParam String endTime, @RequestParam String recordApi) {
        return AjaxResult.success("success!", recordService.listServerRecordByFile(recordApi, pageNum, pageSize, app, stream, startTime, endTime));
    }

    @ApiOperation("通过设备信息查询服务端录像列表")
    @PreAuthorize("@ss.hasPermi('iot:sip:record:list')")
    @GetMapping("/serverRecord/device/list")
    public AjaxResult getServerRecordByDevice(@RequestParam Integer pageNum, @RequestParam Integer pageSize,
                                             @RequestParam String deviceId, @RequestParam String channelId,
                                             @RequestParam String startTime, @RequestParam String endTime) {
        return AjaxResult.success("success!", recordService.listServerRecordByDevice(pageNum, pageSize, deviceId, channelId, startTime, endTime));
    }

}
