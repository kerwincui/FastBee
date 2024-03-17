package com.fastbee.iot.model.varTemp;

import com.fastbee.common.core.iot.response.IdentityAndName;
import com.fastbee.iot.domain.ThingsModel;
import lombok.Data;

import java.util.List;

/**
 * @author gsb
 * @date 2022/12/14 14:56
 */
@Data
public class DeviceSlavePoint {

    /**从机编号*/
    private Integer slaveId;
    /**从机对应采集点数据*/
    private List<IdentityAndName> pointList;
    /**轮询时间*/
    private Long timer;
    /**批量读取的个数*/
    private Integer packetLength;

    private Integer code;
}
