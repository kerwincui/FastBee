package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.IotGroup;

/**
 * 分组Mapper接口
 * 
 * @author kerwincui
 * @date 2021-05-18
 */
public interface IotGroupMapper 
{
    /**
     * 查询分组
     * 
     * @param groupId 分组ID
     * @return 分组
     */
    public IotGroup selectIotGroupById(Long groupId);

    /**
     * 查询分组列表
     * 
     * @param iotGroup 分组
     * @return 分组集合
     */
    public List<IotGroup> selectIotGroupList(IotGroup iotGroup);

    /**
     * 新增分组
     * 
     * @param iotGroup 分组
     * @return 结果
     */
    public int insertIotGroup(IotGroup iotGroup);

    /**
     * 修改分组
     * 
     * @param iotGroup 分组
     * @return 结果
     */
    public int updateIotGroup(IotGroup iotGroup);

    /**
     * 删除分组
     * 
     * @param groupId 分组ID
     * @return 结果
     */
    public int deleteIotGroupById(Long groupId);

    /**
     * 批量删除分组
     * 
     * @param groupIds 需要删除的数据ID
     * @return 结果
     */
    public int deleteIotGroupByIds(Long[] groupIds);
}
