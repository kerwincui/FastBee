package com.fastbee.iot.model.varTemp;

import lombok.Data;

import java.util.List;

/**
 * @author bill
 */
@Data
public class SyncModel {

    private List<Long> productIds;
    private Long templateId;
}
