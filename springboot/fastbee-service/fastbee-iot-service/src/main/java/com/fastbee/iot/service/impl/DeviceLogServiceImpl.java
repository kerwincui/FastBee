package com.fastbee.iot.service.impl;

import com.fastbee.common.core.domain.model.LoginUser;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.SecurityUtils;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.model.DataCenterParam;
import com.fastbee.iot.model.HistoryModel;
import com.fastbee.iot.model.ThingsModelLogCountVO;
import com.fastbee.iot.tsdb.service.ILogService;
import com.fastbee.iot.model.MonitorModel;
import com.fastbee.iot.service.IDeviceLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 设备日志Service业务层处理
 *
 * @author kerwincui
 * @date 2022-01-13
 */
@Service
public class DeviceLogServiceImpl implements IDeviceLogService
{

    @Autowired
    private ILogService logService;

    /**
     * 查询设备监测数据
     *
     * @param deviceLog 设备日志
     * @return 设备日志
     */
    @Override
    public List<MonitorModel> selectMonitorList(DeviceLog deviceLog)
    {
        return logService.selectMonitorList(deviceLog);
    }

    /**
     * 查询设备日志列表
     *
     * @param deviceLog 设备日志
     * @return 设备日志
     */
    @Override
    public List<DeviceLog> selectDeviceLogList(DeviceLog deviceLog)
    {
        if(deviceLog.getIsMonitor()==null){
            deviceLog.setIsMonitor(0);
        }
        return logService.selectDeviceLogList(deviceLog);
    }

    /**
     * 新增设备日志
     *
     * @param deviceLog 设备日志
     * @return 结果
     */
    @Override
    public int insertDeviceLog(DeviceLog deviceLog) {
        deviceLog.setCreateTime(DateUtils.getNowDate());
        LoginUser loginUser = SecurityUtils.getLoginUser();
        deviceLog.setTenantId(loginUser.getDeptUserId());
        deviceLog.setUserId(loginUser.getUserId());
        deviceLog.setCreateBy(loginUser.getUsername());
        return logService.saveDeviceLog(deviceLog);
    }

    @Override
    public List<HistoryModel> listHistory(DeviceLog deviceLog) {
        return logService.listHistory(deviceLog);
    }

    @Override
    public List<ThingsModelLogCountVO> countThingsModelInvoke(DataCenterParam dataCenterParam) {
        return logService.countThingsModelInvoke(dataCenterParam);
    }
}
