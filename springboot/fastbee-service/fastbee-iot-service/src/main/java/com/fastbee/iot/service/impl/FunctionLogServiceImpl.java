package com.fastbee.iot.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.model.DataCenterParam;
import com.fastbee.iot.model.FunctionLogVO;
import com.fastbee.iot.model.HistoryModel;
import com.fastbee.iot.model.ThingsModelLogCountVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fastbee.iot.mapper.FunctionLogMapper;
import com.fastbee.iot.domain.FunctionLog;
import com.fastbee.iot.service.IFunctionLogService;

/**
 * 设备服务下发日志Service业务层处理
 *
 * @author kerwincui
 * @date 2022-10-22
 */
@Service
public class FunctionLogServiceImpl implements IFunctionLogService
{
    @Autowired
    private FunctionLogMapper functionLogMapper;

    /**
     * 查询设备服务下发日志
     *
     * @param id 设备服务下发日志主键
     * @return 设备服务下发日志
     */
    @Override
    public FunctionLog selectFunctionLogById(Long id)
    {
        return functionLogMapper.selectFunctionLogById(id);
    }

    /**
     * 查询设备服务下发日志列表
     *
     * @param functionLog 设备服务下发日志
     * @return 设备服务下发日志
     */
    @Override
    public List<FunctionLog> selectFunctionLogList(FunctionLog functionLog)
    {
        return functionLogMapper.selectFunctionLogList(functionLog);
    }

    /**
     * 新增设备服务下发日志
     *
     * @param functionLog 设备服务下发日志
     * @return 结果
     */
    @Override
    public int insertFunctionLog(FunctionLog functionLog)
    {
        functionLog.setCreateTime(DateUtils.getNowDate());
        return functionLogMapper.insertFunctionLog(functionLog);
    }

    /**
     * 批量插入数据
     * @param list
     */
    @Override
    public void insertBatch(List<FunctionLog> list){
         functionLogMapper.insertBatch(list);
    }

    /**
     * 修改设备服务下发日志
     *
     * @param functionLog 设备服务下发日志
     * @return 结果
     */
    @Override
    public int updateFunctionLog(FunctionLog functionLog)
    {
        return functionLogMapper.updateFunctionLog(functionLog);
    }

    /**
     * 批量删除设备服务下发日志
     *
     * @param ids 需要删除的设备服务下发日志主键
     * @return 结果
     */
    @Override
    public int deleteFunctionLogByIds(Long[] ids)
    {
        return functionLogMapper.deleteFunctionLogByIds(ids);
    }

    /**
     * 删除设备服务下发日志信息
     *
     * @param id 设备服务下发日志主键
     * @return 结果
     */
    @Override
    public int deleteFunctionLogById(Long id)
    {
        return functionLogMapper.deleteFunctionLogById(id);
    }

    /**
     * 根据设备编号删除设备服务下发日志信息
     *
     * @param serialNumber 设备编号
     * @return 结果
     */
    @Override
    public int deleteFunctionLogByDeviceNumber(String serialNumber)
    {
        return functionLogMapper.deleteFunctionLogBySerialNumber(serialNumber);
    }

    /**
     * 批量更新日志状态值
     * @param log 参数
     */
    @Override
    public void updateFuncLogBatch(FunctionLog log){
        functionLogMapper.updateFuncLogBatch(log);
    }

    /**
     * 根据消息id更新指令下发状态
     * @param log
     */
    @Override
    public void updateByMessageId(FunctionLog log){
        functionLogMapper.updateByMessageId(log);
    }

    @Override
    public List<HistoryModel> listHistory(FunctionLogVO functionLogVO) {
        return functionLogMapper.listHistory(functionLogVO);
    }

    @Override
    public List<ThingsModelLogCountVO> countThingsModelInvoke(DataCenterParam dataCenterParam) {
        Date beginTime = null;
        Date endTime = null;
        if (dataCenterParam.getBeginTime() != null && dataCenterParam.getBeginTime() != "" && dataCenterParam.getEndTime() != null && dataCenterParam.getEndTime() != "") {
            beginTime = parseTime(dataCenterParam.getBeginTime());
            endTime = parseTime(dataCenterParam.getEndTime());
        }
        return functionLogMapper.countThingsModelInvoke(dataCenterParam, beginTime, endTime);
    }

    private Date parseTime(String time) {
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return format.parse(time);
        } catch (ParseException e) {
            throw new IllegalArgumentException("时间格式错误: " + time, e);
        }
    }
}
