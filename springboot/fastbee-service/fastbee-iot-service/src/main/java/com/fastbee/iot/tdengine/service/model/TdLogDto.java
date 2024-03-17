package com.fastbee.iot.tdengine.service.model;

import com.fastbee.iot.domain.DeviceLog;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author gsb
 * @date 2023/6/5 8:37
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TdLogDto {

    /**
     * 设备编号
     */
    private String serialNumber;
    /**
     * 设备日志列表
     */
    private List<DeviceLog> list;
}
