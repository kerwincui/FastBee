package com.fastbee.data.controller.media;

import com.fastbee.common.core.controller.BaseController;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.sip.service.IPlayService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@Api(tags = "播放器")
@RestController
@RequestMapping("/sip/player")
public class PlayerController extends BaseController {
    @Autowired
    private IPlayService playService;

    @GetMapping("/getBigScreenUrl/{deviceId}/{channelId}")
    public AjaxResult getBigScreenUrl(@PathVariable String deviceId, @PathVariable String channelId) {
        return AjaxResult.success("success!", playService.play(deviceId, channelId,false).getHttps_fmp4());
    }

    @ApiOperation("直播播放")
    @GetMapping("/play/{deviceId}/{channelId}")
    public AjaxResult play(@PathVariable String deviceId, @PathVariable String channelId) {
        return AjaxResult.success("success!", playService.play(deviceId, channelId,false));
    }

    @ApiOperation("停止推流")
    @GetMapping("/closeStream/{deviceId}/{channelId}/{streamId}")
    public AjaxResult closeStream(@PathVariable String deviceId, @PathVariable String channelId, @PathVariable String streamId) {
        return AjaxResult.success("success!", playService.closeStream(deviceId, channelId, streamId));
    }
}
