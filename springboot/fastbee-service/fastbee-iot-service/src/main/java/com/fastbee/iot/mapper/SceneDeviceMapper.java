package com.fastbee.iot.mapper;

import com.fastbee.iot.domain.Scene;
import com.fastbee.iot.domain.SceneDevice;
import com.fastbee.iot.model.SceneDeviceBindVO;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 场景设备Mapper接口
 * 
 * @author kerwincui
 * @date 2023-12-28
 */
@Repository
public interface SceneDeviceMapper 
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
     * 删除场景设备
     * 
     * @param sceneDeviceId 场景设备主键
     * @return 结果
     */
    public int deleteSceneDeviceBySceneDeviceId(Long sceneDeviceId);

    /**
     * 批量删除场景设备
     * 
     * @param sceneDeviceIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSceneDeviceBySceneDeviceIds(Long[] sceneDeviceIds);

    /**
     * 批量删除场景设备
     *
     * @param sceneIds 需要删除的数据场景ID集合
     * @return 结果
     */
    public int deleteSceneDeviceBySceneIds(Long[] sceneIds);

    /**
     * 批量新增场景脚本
     *
     * @param sceneDeviceList 场景联动触发器集合
     * @return 结果
     */
    public int insertSceneDeviceList(List<SceneDevice> sceneDeviceList);

    /**
     * 查询设备关联的场景列表
     *
     * @param sceneDevice 场景设备
     * @return 场景设备集合
     */
    public List<Scene> selectTriggerDeviceRelateScenes(SceneDevice sceneDevice);

    /**
     * 查询场景联动绑定产品
     * @param productIds 产品id数组
     * @return java.util.List<com.fastbee.iot.model.SceneDeviceBindVO>
     */
    List<SceneDeviceBindVO> listSceneProductBind(Long[] productIds);

    /**
     * 查询场景联动绑定设备
     * @param serialNumber 设备编号
     * @return java.util.List<com.fastbee.iot.model.SceneDeviceBindVO>
     */
    List<SceneDeviceBindVO> listSceneDeviceBind(String serialNumber);
}
