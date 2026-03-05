package com.fastbee.iot.mapper;

import java.util.Date;
import java.util.List;
import com.fastbee.iot.domain.FunctionLog;
import com.fastbee.iot.model.DataCenterParam;
import com.fastbee.iot.model.FunctionLogVO;
import com.fastbee.iot.model.HistoryModel;
import com.fastbee.iot.model.ThingsModelLogCountVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * 设备服务下发日志Mapper接口
 * 
 * @author kerwincui
 * @date 2022-10-22
 */
@Repository
public interface FunctionLogMapper 
{
    /**
     * 查询设备服务下发日志
     * 
     * @param id 设备服务下发日志主键
     * @return 设备服务下发日志
     */
    public FunctionLog selectFunctionLogById(Long id);

    /**
     * 查询设备服务下发日志列表
     * 
     * @param functionLog 设备服务下发日志
     * @return 设备服务下发日志集合
     */
    public List<FunctionLog> selectFunctionLogList(FunctionLog functionLog);

    /**
     * 新增设备服务下发日志
     * 
     * @param functionLog 设备服务下发日志
     * @return 结果
     */
    public int insertFunctionLog(FunctionLog functionLog);

    /**
     * 批量插入数据
     * @param list
     */
    public void insertBatch(List<FunctionLog> list);

    /**
     * 修改设备服务下发日志
     * 
     * @param functionLog 设备服务下发日志
     * @return 结果
     */
    public int updateFunctionLog(FunctionLog functionLog);

    /**
     * 删除设备服务下发日志
     * 
     * @param id 设备服务下发日志主键
     * @return 结果
     */
    public int deleteFunctionLogById(Long id);

    /**
     * 根据设备编号删除设备服务下发日志
     *
     * @param serialNumber 设备编号
     * @return 结果
     */
    public int deleteFunctionLogBySerialNumber(String serialNumber);

    /**
     * 根据标识符前缀和设备编号批量删除日志
     *
     * @param
     * @return 结果
     */
    public int deleteFunctionLogByPreIdentify(FunctionLog functionLog);

    /**
     * 批量删除设备服务下发日志
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFunctionLogByIds(Long[] ids);

    /**
     * 批量更新日志状态值
     * @param log 参数
     */
    public void updateFuncLogBatch(FunctionLog log);

    /**
     * 根据消息id更新指令下发状态
     * @param log
     */
    public void updateByMessageId(FunctionLog log);

    /**
     * 查询物模型历史数据
     * @param functionLogVO 功能日志
     * @return java.util.List<com.fastbee.iot.model.HistoryModel>
     */
    List<HistoryModel> listHistory(FunctionLogVO functionLogVO);

    /**
     * 统计设备物模型指令下发数量
     * @param dataCenterParam 传参
     * @return com.fastbee.common.core.domain.AjaxResult
     */
    List<ThingsModelLogCountVO> countThingsModelInvoke(@Param("dataCenterParam") DataCenterParam dataCenterParam, @Param("beginTime") Date beginTime, @Param("endTime") Date endTime);

}
