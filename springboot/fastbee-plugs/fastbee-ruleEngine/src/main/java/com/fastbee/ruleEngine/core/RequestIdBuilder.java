package com.fastbee.ruleEngine.core;


import cn.hutool.core.lang.Snowflake;
import cn.hutool.core.util.IdUtil;
import com.fastbee.ruleEngine.util.Constant;

public class RequestIdBuilder {
    public static String buildSnowflakeRequestId() {
        Snowflake snowflake = IdUtil.createSnowflake(1, 1);
        return Constant.REQUEST_ID_SNOWFLAKE_PREFIX + snowflake.nextId();
    }

    public static String buildDeviceRequestId(String serialNumber) {
        return Constant.REQUEST_ID_PREFIX + serialNumber;
    }

    public static String buildSceneRequestId(String sceneId) {
        return Constant.REQUEST_ID_PREFIX + sceneId;
    }

    public static String buildProductRequestId(Long product, String serialNumber) {
        return Constant.REQUEST_ID_PREFIX + product + Constant.REQUEST_ID_SPLIT + serialNumber;
    }

    public static String buildALLRequestId(String serialNumber, String product, String sceneId) {
        return Constant.REQUEST_ID_PREFIX + product + Constant.REQUEST_ID_SPLIT + serialNumber + Constant.REQUEST_ID_SPLIT + sceneId;
    }
}
