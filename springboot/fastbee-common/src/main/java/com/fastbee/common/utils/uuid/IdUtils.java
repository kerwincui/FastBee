package com.fastbee.common.utils.uuid;

import lombok.extern.slf4j.Slf4j;
import com.fastbee.common.utils.Md5Utils;
import java.util.Random;

/**
 * ID生成器工具类
 * 
 * @author ruoyi
 */
@Slf4j
public class IdUtils
{
    private static long lastTimestamp = -1L;
    private long sequence = 0L;
    private final long workerId;
    private final long datacenterId;
    private static Integer startIndex=0;
    private static Integer endIndex=6;

    public IdUtils(long workerId, long datacenterId) {
        if(workerId <= 31L && workerId >= 0L) {
            this.workerId = workerId;
        } else {
            if(workerId != -1L) {
                throw new IllegalArgumentException("worker Id can't be greater than %d or less than 0");
            }

            this.workerId = (long)(new Random()).nextInt(31);
        }

        if(datacenterId <= 31L && datacenterId >= 0L) {
            this.datacenterId = datacenterId;
        } else {
            if(datacenterId != -1L) {
                throw new IllegalArgumentException("datacenter Id can't be greater than %d or less than 0");
            }

            this.datacenterId = (long)(new Random()).nextInt(31);
        }

    }

    public synchronized long nextId() {
        long timestamp = this.timeGen();
        if(timestamp < lastTimestamp) {
            try {
                throw new Exception("Clock moved backwards.  Refusing to generate id for " + (lastTimestamp - timestamp) + " milliseconds");
            } catch (Exception e) {
                log.warn("生成ID异常", e);
            }
        }

        if(lastTimestamp == timestamp) {
            this.sequence = this.sequence + 1L & 4095L;
            if(this.sequence == 0L) {
                timestamp = this.tilNextMillis(lastTimestamp);
            }
        } else {
            this.sequence = 0L;
        }

        lastTimestamp = timestamp;
        return timestamp - 1288834974657L << 22 | this.datacenterId << 17 | this.workerId << 12 | this.sequence;
    }

    private long tilNextMillis(long lastTimestamp) {
        long timestamp;
        for(timestamp = this.timeGen(); timestamp <= lastTimestamp; timestamp = this.timeGen()) {
            ;
        }
        return timestamp;
    }

    private long timeGen() {
        return System.currentTimeMillis();
    }

    public static String uuid() {
        return java.util.UUID.randomUUID().toString().replaceAll("-", "");
    }

    public static String getNextCode() {
        return Md5Utils.md5(IdUtils.uuid() + System.currentTimeMillis()).substring(startIndex,endIndex);
    }


    /**
     * 获取随机UUID
     * 
     * @return 随机UUID
     */
    public static String randomUUID()
    {
        return UUID.randomUUID().toString();
    }

    /**
     * 简化的UUID，去掉了横线
     * 
     * @return 简化的UUID，去掉了横线
     */
    public static String simpleUUID()
    {
        return UUID.randomUUID().toString(true);
    }

    /**
     * 获取随机UUID，使用性能更好的ThreadLocalRandom生成UUID
     * 
     * @return 随机UUID
     */
    public static String fastUUID()
    {
        return UUID.fastUUID().toString();
    }

    /**
     * 简化的UUID，去掉了横线，使用性能更好的ThreadLocalRandom生成UUID
     * 
     * @return 简化的UUID，去掉了横线
     */
    public static String fastSimpleUUID()
    {
        return UUID.fastUUID().toString(true);
    }
}
