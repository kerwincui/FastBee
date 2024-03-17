package com.fastbee.iot.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.core.redis.RedisKeyBuilder;
import com.fastbee.common.enums.FunctionReplyStatus;
import com.fastbee.common.enums.ThingsModelType;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.domain.FunctionLog;
import com.fastbee.iot.model.Specs;
import com.fastbee.iot.service.IDeviceRuntimeService;
import com.fastbee.iot.service.IFunctionLogService;
import com.fastbee.iot.service.IThingsModelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 设备运行时数据
 *
 * @author gsb
 * @date 2023/2/1 15:11
 */
@Service
public class DeviceRuntimeServiceImpl implements IDeviceRuntimeService {

    @Autowired
    private RedisCache redisCache;
    @Resource
    private IFunctionLogService logService;
    @Resource
    private IThingsModelService thingsModelService;

    /**
     * 根据设备编号查询设备实时运行状态
     *
     * @param serialNumber 设备编号
     * @param type         物模型类型
     * @return 设备实时数据
     */
    @Override
    public List<DeviceLog> runtimeBySerialNumber(String serialNumber, ThingsModelType type, Long productId, Integer slaveId) {
        //获取redis中的物模型
        String thingsModel = thingsModelService.getCacheThingsModelByProductId(productId);
        JSONObject thingModelObject = JSONObject.parseObject(thingsModel);
        String key = type == ThingsModelType.PROP ? "properties" : "functions";
        String properties = thingModelObject.getString(key);
        /*在redis中查找实时数据*/
        String cacheKey = RedisKeyBuilder.buildDeviceRtCacheKey(serialNumber);
        /*物模型标识符 -- value*/
        Map<String, String> cacheMap = redisCache.getCacheMap(cacheKey);
        /*查询是否有计算公式参数*/
        String paramsKey = RedisKeyBuilder.buildDeviceRtParamsKey(serialNumber);
        Map<String, String> params = redisCache.getCacheMap(paramsKey);
        List<DeviceLog> results = new ArrayList<>();
        List<Specs> propList = JSONObject.parseArray(properties, Specs.class);
        for (Specs specs : propList) {
            if (specs.getSlaveId().equals(slaveId)) {
                DeviceLog log = new DeviceLog();
                log.setModelName(specs.getName());
                log.setLogType(type.getCode());
                log.setSpecs(JSONObject.toJSONString(specs.getDatatype()));
                log.setIdentity(specs.getId());
                log.setSerialNumber(serialNumber);
                log.setSlaveId(specs.getSlaveId());
                log.setIsMonitor(specs.getIsMonitor());
                log.setFormula(specs.getFormula());
                if (!CollectionUtils.isEmpty(cacheMap) && cacheMap.containsKey(specs.getId())) {
                    DeviceLog valueLog = JSONObject.parseObject(JSONObject.parse(cacheMap.get(specs.getId())).toString(), DeviceLog.class);
                    log.setLogValue(valueLog.getLogValue());
                    log.setUpdateTime(valueLog.getTs());
                    log.setTs(valueLog.getTs());
                    //if (log.getFormula() != null && !log.getFormula().equals("")) {
                    //    params.put("%s", log.getLogValue());
                    //    BigDecimal value = CaculateUtils.execute(log.getFormula(), params);
                    //    log.setLogValue(value.toString());
                    //}
                }
                results.add(log);
            }
        }
        List<DeviceLog> result = results.stream().
                filter(log -> log.getLogType() == type.getCode()).collect(Collectors.toList());
        for (DeviceLog log : result) {
            parseSpecs(log);
        }
        return result;
    }


    /**
     * 根据设备编号查询设备服务调用日志情况
     *
     * @param serialNumber 设备编号
     * @return 服务下发日志
     */
    @Override
    public List<FunctionLog> runtimeReply(String serialNumber) {
        FunctionLog log = new FunctionLog();
        log.setSerialNumber(serialNumber);
        // 1-服务下发
        log.setFunType(1);
        List<FunctionLog> logList = logService.selectFunctionLogList(log);
        for (FunctionLog l : logList) {
            if (l.getReplyTime() == null) {
                l.setReplyTime(DateUtils.getNowDate());
            }

            l.setShowValue(l.getResultMsg());
            //设备超过10s未回复，则认为下发失败
            if (l.getResultCode().equals(FunctionReplyStatus.NORELY.getCode()) && DateUtils.getTimestamp() - l.getCreateTime().getTime() >10000){
                l.setShowValue(FunctionReplyStatus.FAIl.getMessage());
                l.setResultCode(FunctionReplyStatus.FAIl.getCode());
            }
        }
        return logList;
    }

    /**
     * 定时任务，自动更新设备响应超时状态
     */
    private void autoUpdateFuncLogStatus() {
        FunctionLog functionLog = new FunctionLog();
        functionLog.setResultCode(FunctionReplyStatus.NORELY.getCode());
        List<FunctionLog> logList = logService.selectFunctionLogList(functionLog);
        List<Long> ids = new ArrayList<>();
        for (FunctionLog log : logList) {
            //如果设备回复超过20s，自动更新设备回复状态为设备超时
            if (DateUtils.getTimestamp() - log.getCreateTime().getTime() > 20000) {
                ids.add(log.getId());
            }
        }
        //更新状态为超时未回复
        if (!CollectionUtils.isEmpty(ids)) {
            FunctionLog log = new FunctionLog();
            log.setList(ids);
            log.setResultMsg(FunctionReplyStatus.UNKNOWN.getMessage());
            log.setResultCode(FunctionReplyStatus.UNKNOWN.getCode());
            log.setReplyTime(DateUtils.getNowDate());
            logService.updateFuncLogBatch(log);
        }
    }

    /**
     * 解析数据定义specs
     *
     * @param log
     */
    public void parseSpecs(DeviceLog log) {
        DeviceLog.DataType spesc = new DeviceLog.DataType();
        if (null != log.getSpecs() && !log.getSpecs().equals("null")) {
            DeviceLog.DataType dataType = JSONObject.parseObject(JSONObject.parse(log.getSpecs()).toString(), DeviceLog.DataType.class);
            log.setDataType(dataType);
        } else {
            spesc.setType("integer");
            log.setDataType(spesc);
        }
    }



}
