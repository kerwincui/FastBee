package com.fastbee.data.controller.datacenter;

import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.utils.MessageUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.iot.model.DataCenterParam;
import com.fastbee.iot.model.DeviceHistoryParam;
import com.fastbee.iot.model.ThingsModelLogCountVO;
import com.fastbee.iot.service.DataCenterService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;




/**
 * @author fastb
 * @version 1.0
 * @description: 数据中心控制器
 * @date 2024-06-13 14:09
 */
@Api(tags = "数据中心管理")
@RestController
@RequestMapping("/data/center")
public class DataCenterController {

    @Resource
    private DataCenterService dataCenterService;

    /**
     * 查询设备物模型的历史数据
     * @param deviceHistoryParam 传参
     * @return com.fastbee.common.core.domain.AjaxResult
     */
    @ApiOperation("查询设备的历史数据")
    @PreAuthorize("@ss.hasPermi('dataCenter:history:list')")
    @PostMapping("/deviceHistory")
    public AjaxResult deviceHistory(@RequestBody DeviceHistoryParam deviceHistoryParam)
    {
        if (StringUtils.isEmpty(deviceHistoryParam.getSerialNumber())) {
            return AjaxResult.error(MessageUtils.message("please.select.device"));
        }
        List<JSONObject> jsonObject = dataCenterService.deviceHistory(deviceHistoryParam);
        return AjaxResult.success(jsonObject);
    }

    /**
     * 统计设备物模型指令下发数量
     * @param dataCenterParam 传参
     * @return com.fastbee.common.core.domain.AjaxResult
     */
    @ApiOperation("统计设备物模型指令下发数量")
    @PreAuthorize("@ss.hasPermi('dataCenter:analysis:list')")
    @GetMapping("/countThingsModelInvoke")
    public AjaxResult countThingsModelInvoke(DataCenterParam dataCenterParam)
    {
        if (StringUtils.isEmpty(dataCenterParam.getSerialNumber())) {
            return AjaxResult.error(MessageUtils.message("please.incoming.serialNumber"));
        }
        List<ThingsModelLogCountVO> list = dataCenterService.countThingsModelInvoke(dataCenterParam);
        return AjaxResult.success(list);
    }

}
