package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.IotGroupMapper;
import com.ruoyi.system.domain.IotGroup;
import com.ruoyi.system.service.IIotGroupService;

/**
 * 分组Service业务层处理
 * 
 * @author kerwincui
 * @date 2021-05-18
 */
@Service
public class IotGroupServiceImpl implements IIotGroupService 
{
    @Autowired
    private IotGroupMapper iotGroupMapper;

    /**
     * 查询分组
     * 
     * @param groupId 分组ID
     * @return 分组
     */
    @Override
    public IotGroup selectIotGroupById(Long groupId)
    {
        return iotGroupMapper.selectIotGroupById(groupId);
    }

    /**
     * 查询分组列表
     * 
     * @param iotGroup 分组
     * @return 分组
     */
    @Override
    public List<IotGroup> selectIotGroupList(IotGroup iotGroup)
    {
        return iotGroupMapper.selectIotGroupList(iotGroup);
    }

    /**
     * 新增分组
     * 
     * @param iotGroup 分组
     * @return 结果
     */
    @Override
    public int insertIotGroup(IotGroup iotGroup)
    {
        iotGroup.setCreateTime(DateUtils.getNowDate());
        return iotGroupMapper.insertIotGroup(iotGroup);
    }

    /**
     * 修改分组
     * 
     * @param iotGroup 分组
     * @return 结果
     */
    @Override
    public int updateIotGroup(IotGroup iotGroup)
    {
        iotGroup.setUpdateTime(DateUtils.getNowDate());
        return iotGroupMapper.updateIotGroup(iotGroup);
    }

    /**
     * 批量删除分组
     * 
     * @param groupIds 需要删除的分组ID
     * @return 结果
     */
    @Override
    public int deleteIotGroupByIds(Long[] groupIds)
    {
        return iotGroupMapper.deleteIotGroupByIds(groupIds);
    }

    /**
     * 删除分组信息
     * 
     * @param groupId 分组ID
     * @return 结果
     */
    @Override
    public int deleteIotGroupById(Long groupId)
    {
        return iotGroupMapper.deleteIotGroupById(groupId);
    }
}
