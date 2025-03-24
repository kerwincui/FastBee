package com.fastbee.data.controller.media;

import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.sip.enums.Direct;
import com.fastbee.sip.model.PtzDirectionInput;
import com.fastbee.sip.model.PtzscaleInput;
import com.fastbee.sip.service.IPtzCmdService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@Api(tags = "云台控制")
@RequestMapping("/sip/ptz")
public class PtzController {
    @Autowired
    private IPtzCmdService ptzCmdService;
    @ApiOperation("云台方向控制")
    @PreAuthorize("@ss.hasPermi('iot:video:list')")
    @PostMapping("/direction/{deviceId}/{channelId}")
    public AjaxResult direction(@PathVariable String deviceId, @PathVariable String channelId, @RequestBody PtzDirectionInput ptzDirectionInput) {
        Direct direct = null;
        int leftRight = ptzDirectionInput.getLeftRight();
        int upDown = ptzDirectionInput.getUpDown();
        if (leftRight == 1) {
            direct = Direct.RIGHT;
        } else if (leftRight == 2) {
            direct = Direct.LEFT;
        } else if (upDown == 1) {
            direct = Direct.UP;
        } else if (upDown == 2) {
            direct = Direct.DOWN;
        } else {
            direct = Direct.STOP;
        }
        Integer speed = ptzDirectionInput.getMoveSpeed();
        return AjaxResult.success("success!", ptzCmdService.directPtzCmd(deviceId, channelId, direct, speed));
    }
    @ApiOperation("云台缩放控制")
    @PreAuthorize("@ss.hasPermi('iot:video:list')")
    @PostMapping("/scale/{deviceId}/{channelId}")
    public AjaxResult scale(@PathVariable String deviceId, @PathVariable String channelId, @RequestBody PtzscaleInput ptzscaleInput) {
        Direct direct = null;
        if (ptzscaleInput.getInOut() == 1) {
            direct = Direct.ZOOM_IN;
        } else if (ptzscaleInput.getInOut() == 2) {
            direct = Direct.ZOOM_OUT;
        } else {
            direct = Direct.STOP;
        }
        Integer speed = ptzscaleInput.getScaleSpeed();
        return AjaxResult.success("success!", ptzCmdService.directPtzCmd(deviceId, channelId, direct, speed));
    }
    @ApiOperation("云台ptz控制")
    @PostMapping("/ptz/{deviceId}/{channelId}/{direct}/{speed}")
    @PreAuthorize("@ss.hasPermi('iot:video:list')")
    public AjaxResult ptzControl(@PathVariable String deviceId,
                                 @PathVariable String channelId,
                                 @PathVariable Direct direct,
                                 @PathVariable Integer speed) {
        return AjaxResult.success("success!", ptzCmdService.directPtzCmd(deviceId, channelId, direct, speed));
    }
    @ApiOperation("云台停止控制")
    @PostMapping("/ptz/{deviceId}/{channelId}/STOP")
    @PreAuthorize("@ss.hasPermi('iot:video:list')")
    public AjaxResult ptzControlStop(@PathVariable String deviceId,
                                     @PathVariable String channelId) {
        return AjaxResult.success("success!", ptzCmdService.directPtzCmd(deviceId, channelId, Direct.STOP, 0));
    }

}
