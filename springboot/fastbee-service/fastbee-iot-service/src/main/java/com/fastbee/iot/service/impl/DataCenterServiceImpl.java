package com.fastbee.iot.service.impl;


import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.DeviceLog;
import com.fastbee.iot.model.*;
import com.fastbee.iot.model.ThingsModelItem.ThingsModel;
import com.fastbee.iot.service.*;
import com.fastbee.iot.tsdb.service.ILogService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * @author fastb
 * @version 1.0
 * @description: 数据中心服务类
 * @date 2024-06-13 15:29
 */
@Service
public class DataCenterServiceImpl implements DataCenterService {

    @Resource
    private IDeviceLogService deviceLogService;
    @Resource
    private IFunctionLogService functionLogService;
    @Resource
    private ILogService logService;
    @Resource
    private IDeviceService deviceService;



    @Override
    public List<JSONObject> deviceHistory(DeviceHistoryParam deviceHistoryParam) {
        List<JSONObject> resultList = new ArrayList<>();
        List<DeviceHistoryParam.IdentifierVO> identifierVOList = new ArrayList<>();
        if (CollectionUtils.isEmpty(deviceHistoryParam.getIdentifierList())) {
            List<ThingsModel> list = deviceService.listThingsModel(deviceHistoryParam.getDeviceId());
            for (ThingsModel thingsModel : list) {
                DeviceHistoryParam.IdentifierVO identifierVO = new DeviceHistoryParam.IdentifierVO();
                identifierVO.setIdentifier(thingsModel.getId());
                identifierVO.setType(thingsModel.getType());
                identifierVOList.add(identifierVO);
            }
        } else {
            identifierVOList = deviceHistoryParam.getIdentifierList();
        }
        if (CollectionUtils.isEmpty(identifierVOList)) {
            return resultList;
        }
        List<String> identifierList = identifierVOList.stream().map(DeviceHistoryParam.IdentifierVO::getIdentifier).collect(Collectors.toList());
        deviceHistoryParam.setIdentifierList(identifierVOList);
        List<HistoryModel> historyModelList = this.queryDeviceHistory(deviceHistoryParam);
        historyModelList.sort(Comparator.comparing(HistoryModel::getTime));
        return this.handleData(identifierList, historyModelList);
    }

    @Override
    public List<HistoryModel> queryDeviceHistory(DeviceHistoryParam deviceHistoryParam) {
        List<HistoryModel> historyModelList = new ArrayList<>();
        List<DeviceHistoryParam.IdentifierVO> identifierVOList = deviceHistoryParam.getIdentifierList();
        List<String> propertyIdentifierList = identifierVOList.stream().filter(t -> 1 == t.getType()).map(DeviceHistoryParam.IdentifierVO::getIdentifier).collect(Collectors.toList());
        if (CollectionUtils.isNotEmpty(propertyIdentifierList)) {
            DeviceLog deviceLog = new DeviceLog();
            deviceLog.setIdentityList(propertyIdentifierList);
            deviceLog.setSerialNumber(deviceHistoryParam.getSerialNumber());
            deviceLog.setBeginTime(deviceHistoryParam.getBeginTime());
            deviceLog.setEndTime(deviceHistoryParam.getEndTime());
            List<HistoryModel> historyModelList1 = deviceLogService.listHistory(deviceLog);
            historyModelList.addAll(historyModelList1);
        }
        List<String> functionIdentifierList = identifierVOList.stream().filter(t -> 2 == t.getType()).map(DeviceHistoryParam.IdentifierVO::getIdentifier).collect(Collectors.toList());
        if (CollectionUtils.isNotEmpty(functionIdentifierList)) {
            FunctionLogVO functionLogVO = new FunctionLogVO();
            functionLogVO.setIdentifyList(functionIdentifierList);
            functionLogVO.setSerialNumber(deviceHistoryParam.getSerialNumber());
            functionLogVO.setBeginTime(DateUtils.dateTime(DateUtils.YY_MM_DD_HH_MM_SS, deviceHistoryParam.getBeginTime()));
            functionLogVO.setEndTime(DateUtils.dateTime(DateUtils.YY_MM_DD_HH_MM_SS, deviceHistoryParam.getEndTime()));
            historyModelList.addAll(functionLogService.listHistory(functionLogVO));
        }
        List<String> eventIdentifierList = identifierVOList.stream().filter(t -> 3 == t.getType()).map(DeviceHistoryParam.IdentifierVO::getIdentifier).collect(Collectors.toList());
        if (CollectionUtils.isNotEmpty(eventIdentifierList)) {
            DeviceLog eventLog = new DeviceLog();
            eventLog.setIdentityList(eventIdentifierList);
            eventLog.setSerialNumber(deviceHistoryParam.getSerialNumber());
            eventLog.setBeginTime(deviceHistoryParam.getBeginTime());
            eventLog.setEndTime(deviceHistoryParam.getEndTime());
            historyModelList.addAll(logService.listHistory(eventLog));
        }
        return historyModelList;
    }

    private List<JSONObject> handleData(List<String> identifierList, List<HistoryModel> historyModelList) {
        List<JSONObject> resultList = new ArrayList<>();
        if (CollectionUtils.isEmpty(historyModelList)) {
            return resultList;
        }
        LinkedHashMap<Date, List<HistoryModel>> map = historyModelList.stream()
                .collect(Collectors.groupingBy(HistoryModel::getTime, LinkedHashMap::new, Collectors.toList()));
//        Map<String, HistoryModel> oldHistoryModelMap = new HashMap<>(2);
        for (Map.Entry<Date, List<HistoryModel>> entry : map.entrySet()) {
            JSONObject jsonObject = new JSONObject();
            List<HistoryModel> value = entry.getValue();
            Map<String, HistoryModel> historyModelMap = value.stream().collect(Collectors.toMap(HistoryModel::getIdentify, Function.identity(), (o, n) -> n));
            List<JSONObject> jsonObjectList = new ArrayList<>();
            for (String identifier : identifierList) {
                JSONObject jsonObject1 = new JSONObject();
                HistoryModel historyModel = historyModelMap.get(identifier);
                if (null != historyModel) {
//                    oldHistoryModelMap.put(identifier, historyModel);
                    jsonObject1.put(historyModel.getIdentify(), historyModel.getValue());
                } else {
//                    HistoryModel oldHistoryModel = oldHistoryModelMap.get(identifier);
//                    if (null != oldHistoryModel) {
//                        jsonObject1.put(identifier, oldHistoryModel.getValue());
//                    } else {
//                        jsonObject1.put(identifier, null);
//                    }
                    jsonObject1.put(identifier, null);
                }
                jsonObjectList.add(jsonObject1);
            }
            jsonObject.put(DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD_HH_MM_SS, entry.getKey()), jsonObjectList);
            resultList.add(jsonObject);
        }
        return resultList;
    }


    @Override
    public List<ThingsModelLogCountVO> countThingsModelInvoke(DataCenterParam dataCenterParam) {
        List<ThingsModelLogCountVO> resultList = new ArrayList<>();
        resultList.addAll(deviceLogService.countThingsModelInvoke(dataCenterParam));
        resultList.addAll(functionLogService.countThingsModelInvoke(dataCenterParam));
        return resultList;
    }



}
