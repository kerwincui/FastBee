package com.fastbee.common.core.redis;

import com.fastbee.common.constant.FastBeeConstant;

/**
 * 缓存key生成器
 *
 * @author bill
 */
public class RedisKeyBuilder {

    /**设备在线列表缓存key*/
    public static String buildDeviceOnlineListKey(){
       return FastBeeConstant.REDIS.DEVICE_ONLINE_LIST;
    }

    /**设备实时数据key*/
    public static String buildDeviceRtCacheKey(String serialNumber){
        return FastBeeConstant.REDIS.DEVICE_RUNTIME_DATA + serialNumber;
    }

    /**
     * 设备通讯协议参数
     */
    public static String buildDeviceRtParamsKey(String serialNumber){
        return FastBeeConstant.REDIS.DEVICE_PROTOCOL_PARAM + serialNumber;
    }

    /**固件版本缓存key*/
    public static String buildFirmwareCachedKey(Long firmwareId){
       return FastBeeConstant.REDIS.FIRMWARE_VERSION + firmwareId;
    }

    /**属性读取回调缓存key*/
    public static String buildPropReadCacheKey(String serialNumber){
        return FastBeeConstant.REDIS.PROP_READ_STORE + serialNumber;
    }

    /**
     * 物模型值命名缓存key
     * Key：TSLV:{productId}_{deviceNumber}   HKey:{identity#V/identity#S/identity#M/identity#N}
     */
    public static String buildTSLVCacheKey(Long productId,String serialNumber){
        return FastBeeConstant.REDIS.DEVICE_PRE_KEY + productId + "_" + serialNumber.toUpperCase();
    }

    /**
     * 物模型缓存key
     * 物模型命名空间：Key:TSL:{productId}  hkey: identity  value: thingsModel
     */
    public static String buildTSLCacheKey(Long productId){
        return FastBeeConstant.REDIS.TSL_PRE_KEY + productId;
    }

    /**录像缓存key*/
    public static String buildSipRecordinfoCacheKey(String recordKey){
        return FastBeeConstant.REDIS.RECORDINFO_KEY + recordKey;
    }

    /**设备id缓存key*/
    public static String buildSipDeviceidCacheKey(String id){
        return FastBeeConstant.REDIS.DEVICEID_KEY + id;
    }
    /**ipCSEQ缓存key*/
    public static String buildStreamCacheKey(String steamId){
        return FastBeeConstant.REDIS.STREAM_KEY + steamId;
    }

    /**ipCSEQ缓存key*/
    public static String buildSipCSEQCacheKey(String CSEQ){
        return FastBeeConstant.REDIS.SIP_CSEQ_PREFIX + CSEQ;
    }

    /**modbus指令缓存可以*/
    public static String buildModbusCacheKey(Long productId){
        return FastBeeConstant.REDIS.POLL_MODBUS_KEY + productId;
    }

    /*缓存设备下发指令消息ID*/
    public static String buildDownMessageIdCacheKey(String serialNumber){
        return FastBeeConstant.REDIS.DEVICE_MESSAGE_ID;
    }

}
