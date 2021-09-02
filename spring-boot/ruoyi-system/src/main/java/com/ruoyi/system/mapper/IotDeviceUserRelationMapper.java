package com.ruoyi.system.mapper;

import java.util.List;

import com.ruoyi.system.domain.IotDeviceUserRelation;
import org.springframework.stereotype.Repository;

/**
 * 【请填写功能名称】Mapper接口
 *
 * @author wxy
 * @date 2021-08-27
 */
@Repository
public interface IotDeviceUserRelationMapper {
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
     * 删除【请填写功能名称】
     *
     * @param id 【请填写功能名称】ID
     * @return 结果
     */
    public int deleteIotDeviceUserRelationById(Long id);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteIotDeviceUserRelationByIds(Long[] ids);
    }
