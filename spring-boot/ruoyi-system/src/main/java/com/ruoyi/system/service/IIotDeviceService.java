package com.ruoyi.system.service;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.ruoyi.system.domain.IotDevice;
import com.ruoyi.system.domain.vo.IotDeviceListDto;
import org.springframework.transaction.annotation.Transactional;

/**
 * 设备Service接口
 *
 * @author kerwincui
 * @date 2021-05-06
 */
public interface IIotDeviceService {
    /**
     * 查询设备
     *
     * @param deviceId 设备ID
     * @return 设备
     */
    public IotDevice selectIotDeviceById(Long deviceId);

    /**
     * 根据编号查询设备
     */
    public IotDevice selectIotDeviceByNum(String deviceNum);

    /**
     * 查询设备列表
     *
     * @param iotDevice 设备
     * @return 设备集合
     */
    public List<IotDeviceListDto> selectIotDeviceList(IotDevice iotDevice);

    /**
     * 新增设备
     *
     * @param iotDevice 设备
     * @return 结果
     */
    public int insertIotDevice(IotDevice iotDevice);

    /**
     * 修改设备
     *
     * @param iotDevice 设备
     * @return 结果
     */
    public int updateIotDevice(IotDevice iotDevice);

    /**
     * 批量删除设备
     *
     * @param deviceIds 需要删除的设备ID
     * @return 结果
     */
    public int deleteIotDeviceByIds(Long[] deviceIds);

    /**
     * 删除设备信息
     *
     * @param deviceId 设备ID
     * @return 结果
     */
    public int deleteIotDeviceById(Long deviceId);

    int controlDeviceByNum(String deviceNum, String cmd);

    int bindDevice(Long userId,String nickname,String deviceNum,String name,Long categoryId,String remark);

    List<IotDeviceListDto> selectMpIotDeviceList(IotDevice iotDevice);

    @Transactional
    int updateDeviceInfo(Long userId, String nickName, Long deviceId, String name, String remark);

    IotDevice selectIotDeviceByUserAndNum(Long userId, String deviceNum);

    int unBindDevice(Long userId,String username,Long deviceId);

    JSONObject getDeviceInfoByDeviceNum(Long userId,String nickName,String deviceNum);

    JSONObject getDeviceInfoByDeviceId(Long userId, String username, Long deviceId);
}

