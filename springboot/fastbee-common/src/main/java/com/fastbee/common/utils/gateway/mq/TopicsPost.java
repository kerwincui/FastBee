package com.fastbee.common.utils.gateway.mq;

import lombok.Data;

/**
 * @author gsb
 * @date 2023/2/27 13:41
 */
@Data
public class TopicsPost {

    private String[] topics;
    private int[] qos;
}
