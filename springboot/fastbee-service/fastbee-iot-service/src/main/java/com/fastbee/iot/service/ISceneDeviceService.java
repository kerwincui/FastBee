package com.fastbee.iot.service;

import com.fastbee.iot.domain.SceneDevice;

import java.util.List;

/**
 * 场景设备Service接口
 * 
 * @author kerwincui
 * @date 2023-12-28
 */
public interface ISceneDeviceService 
{
    /**
     * 查询场景设备
     * 
     * @param sceneDeviceId 场景设备主键
     * @return 场景设备
     */
    public SceneDevice selectSceneDeviceBySceneDeviceId(Long sceneDeviceId);

    /**
     * 查询场景设备列表
     * 
     * @param sceneDevice 场景设备
     * @return 场景设备集合
     */
    public List<SceneDevice> selectSceneDeviceList(SceneDevice sceneDevice);

    /**
     * 新增场景设备
     * 
     * @param sceneDevice 场景设备
     * @return 结果
     */
    public int insertSceneDevice(SceneDevice sceneDevice);

    /**
     * 修改场景设备
     * 
     * @param sceneDevice 场景设备
     * @return 结果
     */
    public int updateSceneDevice(SceneDevice sceneDevice);

    /**
     * 批量删除场景设备
     * 
     * @param sceneDeviceIds 需要删除的场景设备主键集合
     * @return 结果
     */
    public int deleteSceneDeviceBySceneDeviceIds(Long[] sceneDeviceIds);

    /**
     * 删除场景设备信息
     * 
     * @param sceneDeviceId 场景设备主键
     * @return 结果
     */
    public int deleteSceneDeviceBySceneDeviceId(Long sceneDeviceId);
}
