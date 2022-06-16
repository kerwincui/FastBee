package com.ruoyi.iot.service;

import java.util.List;
import com.ruoyi.iot.domain.Firmware;

/**
 * 产品固件Service接口
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public interface IFirmwareService 
{
    /**
     * 查询产品固件
     * 
     * @param firmwareId 产品固件主键
     * @return 产品固件
     */
    public Firmware selectFirmwareByFirmwareId(Long firmwareId);

    /**
     * 查询设备最新固件
     *
     * @param deviceId 产品固件主键
     * @return 产品固件
     */
    public Firmware selectLatestFirmware(Long deviceId);

    /**
     * 查询产品固件列表
     * 
     * @param firmware 产品固件
     * @return 产品固件集合
     */
    public List<Firmware> selectFirmwareList(Firmware firmware);

    /**
     * 新增产品固件
     * 
     * @param firmware 产品固件
     * @return 结果
     */
    public int insertFirmware(Firmware firmware);

    /**
     * 修改产品固件
     * 
     * @param firmware 产品固件
     * @return 结果
     */
    public int updateFirmware(Firmware firmware);

    /**
     * 批量删除产品固件
     * 
     * @param firmwareIds 需要删除的产品固件主键集合
     * @return 结果
     */
    public int deleteFirmwareByFirmwareIds(Long[] firmwareIds);

    /**
     * 删除产品固件信息
     * 
     * @param firmwareId 产品固件主键
     * @return 结果
     */
    public int deleteFirmwareByFirmwareId(Long firmwareId);
}
