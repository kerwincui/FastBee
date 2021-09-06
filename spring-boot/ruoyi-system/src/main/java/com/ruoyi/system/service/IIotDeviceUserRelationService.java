package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.IotDeviceUserRelation;

/**
 * 【请填写功能名称】Service接口
 *
 * @author wxy
 * @date 2021-08-27
 */
public interface IIotDeviceUserRelationService {
    /**
     * 查询【请填写功能名称】
     *
     * @param id 【请填写功能名称】ID
     * @return 【请填写功能名称】
     */
    public IotDeviceUserRelation selectIotDeviceUserRelationById(Long id);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param iotDeviceUserRelation 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<IotDeviceUserRelation> selectIotDeviceUserRelationList(IotDeviceUserRelation iotDeviceUserRelation);

    /**
     * 新增【请填写功能名称】
     *
     * @param iotDeviceUserRelation 【请填写功能名称】
     * @return 结果
     */
    public int insertIotDeviceUserRelation(IotDeviceUserRelation iotDeviceUserRelation);

    /**
     * 修改【请填写功能名称】
     *
     * @param iotDeviceUserRelation 【请填写功能名称】
     * @return 结果
     */
    public int updateIotDeviceUserRelation(IotDeviceUserRelation iotDeviceUserRelation);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param ids 需要删除的【请填写功能名称】ID
     * @return 结果
     */
    public int deleteIotDeviceUserRelationByIds(Long[] ids);

    /**
     * 删除【请填写功能名称】信息
     *
     * @param id 【请填写功能名称】ID
     * @return 结果
     */
    public int deleteIotDeviceUserRelationById(Long id);

    List<IotDeviceUserRelation> selectIotDeviceUserRelationByDeviceId(Long deviceId);

    List<IotDeviceUserRelation> selectIotDeviceUserRelationByUserId(Long userId);

    IotDeviceUserRelation selectIotDeviceUserRelationByDeviceIdAndUserId(Long deviceId,Long userId);

}
