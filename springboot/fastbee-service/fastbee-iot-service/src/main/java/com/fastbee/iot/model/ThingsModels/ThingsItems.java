package com.fastbee.iot.model.ThingsModels;

import lombok.Data;

import java.util.List;

/**
 * @author gsb
 * @date 2022/10/24 15:45
 */
@Data
public class ThingsItems {

    private List<String> ids;

    private Long productId;

    private Integer slaveId;
}
