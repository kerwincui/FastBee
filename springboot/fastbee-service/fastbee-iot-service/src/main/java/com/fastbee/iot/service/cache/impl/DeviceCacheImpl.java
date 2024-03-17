package com.fastbee.iot.service.cache.impl;

import com.fastbee.common.core.mq.DeviceStatusBo;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.core.redis.RedisKeyBuilder;
import com.fastbee.common.enums.DeviceStatus;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.service.IDeviceService;
import com.fastbee.iot.service.cache.IDeviceCache;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * @author bill
 */
@Service
@Slf4j
public class DeviceCacheImpl implements IDeviceCache {

    @Value("${server.device.platform.expried:120}")
    private Integer expireTime;

    @Autowired
    private RedisCache redisCache;
    @Autowired
    private IDeviceService deviceService;


    /**
     * 更新设备状态
     * 如果设备状态保持不变，更新redis设备最新在线时间
     * 如果设备状态更改，更新redis同时，更新MySQL数据库设备状态
     *
     * @param dto dto
     */
    @Override
    public Device updateDeviceStatusCache(DeviceStatusBo dto) {

        Device device = deviceService.selectDeviceBySerialNumber(dto.getSerialNumber());
        if (dto.getStatus() == DeviceStatus.ONLINE) {
            /*redis设备在线列表*/
            redisCache.zSetAdd(RedisKeyBuilder.buildDeviceOnlineListKey(), dto.getSerialNumber(), DateUtils.getTimestampSeconds());
            //更新mysql的设备状态为在线，延时500ms解决状态同步问题
            try {
                Thread.sleep(500); // 延迟一秒
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            device.setStatus(DeviceStatus.ONLINE.getType());
        } else {
            /*在redis设备在线列表移除设备*/
            redisCache.zRem(RedisKeyBuilder.buildDeviceOnlineListKey(), dto.getSerialNumber());
            //更新一下mysql的设备状态为离线
            device.setStatus(DeviceStatus.OFFLINE.getType());
        }
        device.setUpdateTime(DateUtils.getNowDate());
        deviceService.updateDeviceStatusAndLocation(device, dto.getIp());
        return device;
    }


    /**
     * 批量更新redis缓存设备状态
     *
     * @param serialNumbers 设备列表
     * @param status        状态
     */
    @Override
    public void updateBatchDeviceStatusCache(List<String> serialNumbers, DeviceStatus status) {
        if (CollectionUtils.isEmpty(serialNumbers)) {
            return;
        }
        for (String serialNumber : serialNumbers) {
            DeviceStatusBo statusBo = new DeviceStatusBo();
            statusBo.setStatus(status);
            statusBo.setSerialNumber(serialNumber);
            this.updateDeviceStatusCache(statusBo);
        }
    }



}
