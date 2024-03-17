package com.fastbee.iot.service.impl;

import com.fastbee.common.core.domain.entity.SysRole;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.Group;
import com.fastbee.iot.mapper.GroupMapper;
import com.fastbee.iot.model.DeviceGroupInput;
import com.fastbee.iot.model.IdOutput;
import com.fastbee.iot.service.IGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.fastbee.common.utils.SecurityUtils.getLoginUser;

/**
 * 设备分组Service业务层处理
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@Service
public class GroupServiceImpl implements IGroupService 
{
    @Autowired
    private GroupMapper groupMapper;

    /**
     * 查询设备分组
     * 
     * @param groupId 设备分组主键
     * @return 设备分组
     */
    @Override
    public Group selectGroupByGroupId(Long groupId)
    {
        return groupMapper.selectGroupByGroupId(groupId);
    }

    /**
     * 通过分组ID查询关联的设备ID数组
     * @param groupId
     * @return
     */
    @Override
    public Long[]  selectDeviceIdsByGroupId(Long groupId){
        List<IdOutput> list=groupMapper.selectDeviceIdsByGroupId(groupId);
        Long[] ids=new Long[list.size()];
        for(int i=0;i<list.size();i++){
            ids[i]=list.get(i).getId();
        }
        return ids;
    }

    /**
     * 查询设备分组列表
     * 
     * @param group 设备分组
     * @return 设备分组
     */
    @Override
    public List<Group> selectGroupList(Group group)
    {
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles=user.getRoles();
        if(group.getUserId()!=null && group.getUserId()!=0){
            // 筛选自己分组（主要针对管理员）
            group.setUserId(group.getUserId());
        }else {
            for (int i = 0; i < roles.size(); i++) {
                // 租户和用户，只查看自己分组
                if (roles.get(i).getRoleKey().equals("tenant") || roles.get(i).getRoleKey().equals("general")) {
                    group.setUserId(user.getUserId());
                    break;
                }
            }
        }
        return groupMapper.selectGroupList(group);
    }

    /**
     * 新增设备分组
     * 
     * @param group 设备分组
     * @return 结果
     */
    @Override
    public int insertGroup(Group group)
    {
        SysUser user = getLoginUser().getUser();
        group.setUserId(user.getUserId());
        group.setUserName(user.getUserName());
        group.setCreateTime(DateUtils.getNowDate());
        return groupMapper.insertGroup(group);
    }

    /**
     * 修改设备分组
     * 
     * @param group 设备分组
     * @return 结果
     */
    @Override
    public int updateGroup(Group group)
    {
        group.setUpdateTime(DateUtils.getNowDate());
        return groupMapper.updateGroup(group);
    }

    /**
     * 分组下批量添加设备分组
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int updateDeviceGroups(DeviceGroupInput input){
        //删除分组下的所有关联设备
        groupMapper.deleteDeviceGroupByGroupIds(new Long[]{input.getGroupId()});
        // 分组下添加关联设备
        if(input.getDeviceIds().length>0){
            groupMapper.insertDeviceGroups(input);
        }
        return 1;
    }

    /**
     * 批量删除分组和设备分组
     * 
     * @param groupIds 需要删除的设备分组主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteGroupByGroupIds(Long[] groupIds)
    {
        // 删除设备分组
        groupMapper.deleteDeviceGroupByGroupIds(groupIds);
        // 删除分组
        return groupMapper.deleteGroupByGroupIds(groupIds);
    }

    /**
     * 删除分组信息
     * 
     * @param groupId 设备分组主键
     * @return 结果
     */
    @Override
    public int deleteGroupByGroupId(Long groupId)
    {

        return groupMapper.deleteGroupByGroupId(groupId);
    }

}
