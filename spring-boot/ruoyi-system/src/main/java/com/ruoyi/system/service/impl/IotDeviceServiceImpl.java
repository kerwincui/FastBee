package com.ruoyi.system.service.impl;

import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.exception.CustomException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.*;
import com.ruoyi.system.domain.vo.IotDeviceListDto;
import com.ruoyi.system.mqtt.config.MqttPushClient;
import com.ruoyi.system.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.IotDeviceMapper;
import org.springframework.transaction.annotation.Transactional;

/**
 * 设备Service业务层处理
 *
 * @author kerwincui
 * @date 2021-05-06
 */
@Service
@Slf4j
public class IotDeviceServiceImpl implements IIotDeviceService {
    @Autowired
    private IotDeviceMapper iotDeviceMapper;
    @Autowired
    private MqttPushClient pushClient;

    @Autowired
    private ITUserAccountInfoService userAccountInfoService;

    @Autowired
    private IIotDeviceUserRelationService deviceUserRelationService;

    @Autowired
    private IIotDeviceSetService iotDeviceSetService;
    @Autowired
    private IIotDeviceStatusService iotDeviceStatusService;


    /**
     * 查询设备
     *
     * @param deviceId 设备ID
     * @return 设备
     */
    @Override
    public IotDevice selectIotDeviceById(Long deviceId) {
        return iotDeviceMapper.selectIotDeviceById(deviceId);
    }

    /**
     * 根据编号查询设备
     *
     * @param deviceNum 设备编号
     * @return 设备
     */
    @Override
    public IotDevice selectIotDeviceByNum(String deviceNum) {
        return iotDeviceMapper.selectIotDeviceByNum(deviceNum);
    }

    /**
     * 查询设备列表
     *
     * @param iotDevice 设备
     * @return 设备
     */
    @Override
    public List<IotDeviceListDto> selectIotDeviceList(IotDevice iotDevice) {
        return iotDeviceMapper.selectIotDeviceList(iotDevice);
    }

    /**
     * 新增设备
     *
     * @param iotDevice 设备
     * @return 结果
     */
    @Override
    public int insertIotDevice(IotDevice iotDevice) {
        iotDevice.setCreateTime(DateUtils.getNowDate());
        return iotDeviceMapper.insertIotDevice(iotDevice);
    }

    /**
     * 修改设备
     *
     * @param iotDevice 设备
     * @return 结果
     */
    @Override
    public int updateIotDevice(IotDevice iotDevice) {
        iotDevice.setUpdateTime(DateUtils.getNowDate());
        return iotDeviceMapper.updateIotDevice(iotDevice);
    }

    /**
     * 批量删除设备
     *
     * @param deviceIds 需要删除的设备ID
     * @return 结果
     */
    @Override
    public int deleteIotDeviceByIds(Long[] deviceIds) {
        return iotDeviceMapper.deleteIotDeviceByIds(deviceIds);
    }

    /**
     * 删除设备信息
     *
     * @param deviceId 设备ID
     * @return 结果
     */
    @Override
    public int deleteIotDeviceById(Long deviceId) {
        return iotDeviceMapper.deleteIotDeviceById(deviceId);
    }

    @Override
    public int controlDeviceByNum(String deviceNum, String cmd) {
        IotDevice iotDevice = iotDeviceMapper.selectIotDeviceByNum(deviceNum);
        if(iotDevice==null)
        {
            throw new CustomException("设备不存在");
        }
        Long deviceId = iotDevice.getDeviceId();



//        IotDeviceStatus status = iotDeviceStatusService.selectIotDeviceStatusByDeviceId(iotDeviceSet.getDeviceId());
//        if (status == null || status.getIsOnline() == 0) {
//            return AjaxResult.error("设备已离线，不能更新状态。");
//        }
//        // 存储
//        iotDeviceSetService.updateIotDeviceSet(iotDeviceSet);
//
//        //mqtt发布
//        IotDeviceSet set = iotDeviceSetService.selectIotDeviceSetByDeviceId(iotDeviceSet.getDeviceId());
//        if (iotDeviceSet.getIsRadar() != null) {
//            set.setIsRadar(iotDeviceSet.getIsRadar());
//        }
//        if (iotDeviceSet.getIsAlarm() != null) {
//            set.setIsAlarm(iotDeviceSet.getIsAlarm());
//        }
//        if (iotDeviceSet.getRadarInterval() != null) {
//            set.setRadarInterval(iotDeviceSet.getRadarInterval());
//        }
//        if (iotDeviceSet.getIsRfControl() != null) {
//            set.setIsRfControl(iotDeviceSet.getIsRfControl());
//        }
//        if (iotDeviceSet.getRfOneFunc() != null) {
//            set.setRfOneFunc(iotDeviceSet.getRfOneFunc());
//        }
//        if (iotDeviceSet.getRfTwoFunc() != null) {
//            set.setRfTwoFunc(iotDeviceSet.getRfTwoFunc());
//        }
//        if (iotDeviceSet.getRfThreeFunc() != null) {
//            set.setRfThreeFunc(iotDeviceSet.getRfThreeFunc());
//        }
//        if (iotDeviceSet.getRfFourFunc() != null) {
//            set.setRfFourFunc(iotDeviceSet.getRfFourFunc());
//        }
//        if (iotDeviceSet.getIsRfLearn() != null) {
//            set.setIsRfLearn(iotDeviceSet.getIsRfLearn());
//        }
//        if (iotDeviceSet.getIsRfClear() != null) {
//            set.setIsRfClear(iotDeviceSet.getIsRfClear());
//        }
//        if (iotDeviceSet.getIsAp() != null) {
//            set.setIsAp(iotDeviceSet.getIsAp());
//        }
//        if (iotDeviceSet.getIsReset() != null) {
//            set.setIsReset(iotDeviceSet.getIsReset());
//        }
//        String content = JSON.toJSONString(set);

//        String topic = "xiaoyi/swtich/devices/"+deviceNum;
        IotDeviceStatus iotDeviceStatus = new IotDeviceStatus();
        iotDeviceStatus.setDeviceId(deviceId);
        if("on".equalsIgnoreCase(cmd))
        {
            iotDeviceStatus.setRelayStatus(1);
        }else{
            iotDeviceStatus.setRelayStatus(0);
        }

        String topic = "status/set/" + deviceNum;
        String content = JSON.toJSONString(iotDeviceStatus);
//        content="{\"deviceId\":\"4\",\"params\":{},\"relayStatus\":\"1\"}";
        System.out.println("topic:"+topic);
        System.out.println("content:"+content);
        boolean publish = pushClient.publish(2, true, topic, content);
        if(publish)
        {
            return 1;
        }else{
            throw new CustomException("指令发送失败");
        }
    }

    /**
    * @Method
    * @Description 用户添加设备
    * @Param null
    * @return
    * @date 2021-08-27,0027 11:33
    * @author admin
    *
    */
    @Override
    @Transactional
    public int bindDevice(Long userId,String nickName, String deviceNum, String name, Long categoryId, String remark) {
        IotDevice iotDevice = iotDeviceMapper.selectIotDeviceByNum(deviceNum);
        if(iotDevice==null)
        {
            throw  new CustomException("设备【"+deviceNum+"】不存在");
        }

        Long deviceId = iotDevice.getDeviceId();
        IotDeviceUserRelation iotDeviceUserRelation = deviceUserRelationService.selectIotDeviceUserRelationByDeviceIdAndUserId(deviceId, userId);

        if(iotDeviceUserRelation!=null)
        {
            throw  new CustomException("该设备已被绑定！");
//            throw  new CustomException("设备【"+deviceNum+"】已经绑定，请换其他设备！");
        }

        log.info("用户: "+nickName+"，添加设备【"+deviceNum+"】,名称为："+name);
//        iotDevice.setDeviceName(name);
        iotDevice.setRemark(remark);
        if("未激活".equals(iotDevice.getStatus()))
        {
            throw  new CustomException("该设备未激活不能绑定！");
        }
        iotDeviceMapper.updateIotDevice(iotDevice);

        //保存设备用户关联
        IotDeviceUserRelation iotDeviceUserRelation1 = new IotDeviceUserRelation();
        iotDeviceUserRelation1.setDeviceId(deviceId);
        iotDeviceUserRelation1.setDeviceNum(deviceNum);
        iotDeviceUserRelation1.setUserId(userId);
        iotDeviceUserRelation1.setDeviceName(name);
        return deviceUserRelationService.insertIotDeviceUserRelation(iotDeviceUserRelation1);
    }

    @Override
    public List<IotDeviceListDto> selectMpIotDeviceList(IotDevice iotDevice) {
        return iotDeviceMapper.selectMpIotDeviceList(iotDevice);
    }

    @Override
    @Transactional
    public int updateDeviceInfo(Long userId, String nickName, Long deviceId, String name, String remark) {
        IotDevice iotDevice = iotDeviceMapper.selectIotDeviceById(deviceId);
        if(iotDevice==null)
        {
            throw  new CustomException("设备不存在");
        }

        IotDeviceUserRelation iotDeviceUserRelation = deviceUserRelationService.selectIotDeviceUserRelationByDeviceIdAndUserId(deviceId, userId);

        if(iotDeviceUserRelation==null)
        {
            throw  new CustomException("设备不存在！");
        }
        String deviceNum=iotDevice.getDeviceNum();
        log.info("用户: "+nickName+"，修改设备【"+deviceNum+"】名称为："+name);

//        iotDeviceMapper.updateIotDevice(iotDevice);

        //保存设备用户关联
        IotDeviceUserRelation iotDeviceUserRelation1 = new IotDeviceUserRelation();
        iotDeviceUserRelation1.setId(iotDeviceUserRelation.getId());
        iotDeviceUserRelation1.setDeviceId(deviceId);
        iotDeviceUserRelation1.setDeviceNum(deviceNum);
        iotDeviceUserRelation1.setUserId(userId);
        iotDeviceUserRelation1.setDeviceName(name);
        iotDeviceUserRelation1.setRemark(remark);
        return deviceUserRelationService.updateIotDeviceUserRelation(iotDeviceUserRelation1);
    }

    @Override
    public IotDevice selectIotDeviceByUserAndNum(Long userId, String deviceNum) {
        IotDevice iotDevice = iotDeviceMapper.selectIotDeviceByNum(deviceNum);
        if(iotDevice==null)
        {
            throw  new CustomException("设备不存在");
        }
        Long deviceId = iotDevice.getDeviceId();
        IotDeviceUserRelation iotDeviceUserRelation = deviceUserRelationService.selectIotDeviceUserRelationByDeviceIdAndUserId(deviceId, userId);

        if(iotDeviceUserRelation==null)
        {
            throw  new CustomException("设备不存在！");
        }
        iotDevice.setDeviceName(iotDeviceUserRelation.getDeviceName());
        iotDevice.setRemark(iotDeviceUserRelation.getRemark());
        return iotDevice;
    }

    @Override
    public int unBindDevice(Long userId, String nickName, Long deviceId) {
        IotDevice iotDevice = iotDeviceMapper.selectIotDeviceById(deviceId);
        if(iotDevice==null)
        {
            throw  new CustomException("设备不存在");
        }

        IotDeviceUserRelation iotDeviceUserRelation = deviceUserRelationService.selectIotDeviceUserRelationByDeviceIdAndUserId(deviceId, userId);

        if(iotDeviceUserRelation==null)
        {
            throw  new CustomException("设备不存在,或已解绑！");
        }
        String deviceNum = iotDevice.getDeviceNum();
        log.info("用户: "+nickName+"，解绑设备【"+deviceNum+"】");

        return deviceUserRelationService.deleteIotDeviceUserRelationById(iotDeviceUserRelation.getId());
    }

    @Override
    public JSONObject getDeviceInfoByDeviceNum(Long userId, String nickname,String deviceNum) {
        return iotDeviceMapper.getDeviceInfoByDeviceNum(userId,deviceNum);
    }

    @Override
    public JSONObject getDeviceInfoByDeviceId(Long userId, String nickname,Long deviceId) {
        return iotDeviceMapper.getDeviceInfoByDeviceId(userId,deviceId);
    }
}
