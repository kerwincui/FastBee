package com.fastbee.iot.mapper;

import com.fastbee.iot.domain.Device;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.model.DeviceStatistic;
import com.fastbee.iot.model.HistoryModel;
import com.fastbee.iot.model.MonitorModel;
import com.fastbee.iot.tdengine.service.model.TdLogDto;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * 设备日志Mapper接口
 *
 * @author kerwincui
 * @date 2022-01-13
 */
@Repository
public interface DeviceLogMapper
{
    /**
     * 查询设备日志
     *
     * @param logId 设备日志主键
     * @return 设备日志
     */
    public DeviceLog selectDeviceLogByLogId(Long logId);

    /**
     * 查询日志分类总数
     *
     * @return 设备日志
     */
    public DeviceStatistic selectCategoryLogCount(Device device);

    /**
     * 查询设备监测数据
     *
     * @param deviceLog 设备日志
     * @return 设备日志集合
     */
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog);


    /**
     * 批量保存图片
     */
    public int saveBatch(@Param("list") List<DeviceLog> list);

    /**
     * 修改设备日志
     *
     * @param deviceLog 设备日志
     * @return 结果
     */
    public int updateDeviceLog(DeviceLog deviceLog);

    /**
     * 删除设备日志
     *
     * @param logId 设备日志主键
     * @return 结果
     */
    public int deleteDeviceLogByLogId(Long logId);

    /**
     * 批量删除设备日志
     *
     * @param logIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteDeviceLogByLogIds(Long[] logIds);

    /**
     * 根据设备Ids批量删除设备日志
     *
     * @param deviceNumber 需要删除的数据设备Id
     * @return 结果
     */
    public int deleteDeviceLogByDeviceNumber(String deviceNumber);


}
