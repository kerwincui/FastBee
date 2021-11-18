package com.ruoyi.system.service.impl;

import java.util.List;
                                                                            import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
    import com.ruoyi.system.mapper.IotDeviceUserRelationMapper;
import com.ruoyi.system.domain.IotDeviceUserRelation;
import com.ruoyi.system.service.IIotDeviceUserRelationService;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @author wxy
 * @date 2021-08-27
 */
@Service
public class IotDeviceUserRelationServiceImpl implements IIotDeviceUserRelationService {
    @Autowired
    private IotDeviceUserRelationMapper iotDeviceUserRelationMapper;

    /**
     * 查询【请填写功能名称】
     *
     * @param id 【请填写功能名称】ID
     * @return 【请填写功能名称】
     */
    @Override
    public IotDeviceUserRelation selectIotDeviceUserRelationById(Long id) {
        return iotDeviceUserRelationMapper.selectIotDeviceUserRelationById(id);
    }

    /**
     * 查询【请填写功能名称】列表
     *
     * @param iotDeviceUserRelation 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<IotDeviceUserRelation> selectIotDeviceUserRelationList(IotDeviceUserRelation iotDeviceUserRelation) {
        return iotDeviceUserRelationMapper.selectIotDeviceUserRelationList(iotDeviceUserRelation);
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param iotDeviceUserRelation 【请填写功能名称】
     * @return 结果
     */
            @Override
    public int insertIotDeviceUserRelation(IotDeviceUserRelation iotDeviceUserRelation) {
                 return iotDeviceUserRelationMapper.insertIotDeviceUserRelation(iotDeviceUserRelation);
            }

    /**
     * 修改【请填写功能名称】
     *
     * @param iotDeviceUserRelation 【请填写功能名称】
     * @return 结果
     */
            @Override
    public int updateIotDeviceUserRelation(IotDeviceUserRelation iotDeviceUserRelation) {
            return iotDeviceUserRelationMapper.updateIotDeviceUserRelation(iotDeviceUserRelation);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param ids 需要删除的【请填写功能名称】ID
     * @return 结果
     */
            @Override
    public int deleteIotDeviceUserRelationByIds(Long[] ids) {
                return iotDeviceUserRelationMapper.deleteIotDeviceUserRelationByIds(ids);
    }

    /**
     * 删除【请填写功能名称】信息
     *
     * @param id 【请填写功能名称】ID
     * @return 结果
     */
    @Override
    public int deleteIotDeviceUserRelationById(Long id) {
                return iotDeviceUserRelationMapper.deleteIotDeviceUserRelationById(id);
    }

    @Override
    public List<IotDeviceUserRelation> selectIotDeviceUserRelationByDeviceId(Long deviceId) {
        IotDeviceUserRelation iotDeviceUserRelation = new IotDeviceUserRelation();
        iotDeviceUserRelation.setDeviceId(deviceId);
        return iotDeviceUserRelationMapper.selectIotDeviceUserRelationList(iotDeviceUserRelation);
    }

    @Override
    public List<IotDeviceUserRelation> selectIotDeviceUserRelationByUserId(Long userId) {
        IotDeviceUserRelation iotDeviceUserRelation = new IotDeviceUserRelation();
        iotDeviceUserRelation.setUserId(userId);
        return iotDeviceUserRelationMapper.selectIotDeviceUserRelationList(iotDeviceUserRelation);
    }

    @Override
    public IotDeviceUserRelation selectIotDeviceUserRelationByDeviceIdAndUserId(Long deviceId, Long userId) {
        IotDeviceUserRelation iotDeviceUserRelation = new IotDeviceUserRelation();
        iotDeviceUserRelation.setUserId(userId);
        iotDeviceUserRelation.setDeviceId(deviceId);
        List<IotDeviceUserRelation> iotDeviceUserRelations = iotDeviceUserRelationMapper.selectIotDeviceUserRelationList(iotDeviceUserRelation);
        if(iotDeviceUserRelations==null || iotDeviceUserRelations.size()==0)
        {
            return null;
        }
        return iotDeviceUserRelations.get(0);
    }

}
