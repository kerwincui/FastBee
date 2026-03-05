package com.fastbee.iot.service;

import com.alibaba.fastjson2.JSONObject;
import com.fastbee.iot.model.DeviceHistoryParam;
import com.fastbee.iot.model.HistoryModel;
import com.fastbee.iot.model.DataCenterParam;
import com.fastbee.iot.model.ThingsModelLogCountVO;
import java.util.List;

/**
 * 数据中心服务类
 * @author fastb
 * @date 2024-06-13 15:29
 * @version 1.0
 */
public interface DataCenterService {

    /**
     * 查询设备物模型的历史数据
     * @param deviceHistoryParam 传参
     * @return com.fastbee.common.core.domain.AjaxResult
     */
    List<JSONObject> deviceHistory(DeviceHistoryParam deviceHistoryParam);


    /**
     * 统计设备物模型指令下发数量
     * @param dataCenterParam 传参
     * @return com.fastbee.common.core.domain.AjaxResult
     */
    List<ThingsModelLogCountVO> countThingsModelInvoke(DataCenterParam dataCenterParam);


    List<HistoryModel> queryDeviceHistory(DeviceHistoryParam deviceHistoryParam);

}
