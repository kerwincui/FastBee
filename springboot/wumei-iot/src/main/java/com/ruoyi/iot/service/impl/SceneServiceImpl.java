package com.ruoyi.iot.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.iot.mapper.SceneMapper;
import com.ruoyi.iot.domain.Scene;
import com.ruoyi.iot.service.ISceneService;

/**
 * 场景联动Service业务层处理
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
@Service
public class SceneServiceImpl implements ISceneService 
{
    @Autowired
    private SceneMapper sceneMapper;

    /**
     * 查询场景联动
     * 
     * @param sceneId 场景联动主键
     * @return 场景联动
     */
    @Override
    public Scene selectSceneBySceneId(Long sceneId)
    {
        return sceneMapper.selectSceneBySceneId(sceneId);
    }

    /**
     * 查询场景联动列表
     * 
     * @param scene 场景联动
     * @return 场景联动
     */
    @Override
    public List<Scene> selectSceneList(Scene scene)
    {
        return sceneMapper.selectSceneList(scene);
    }

    /**
     * 新增场景联动
     * 
     * @param scene 场景联动
     * @return 结果
     */
    @Override
    public int insertScene(Scene scene)
    {
        scene.setCreateTime(DateUtils.getNowDate());
        return sceneMapper.insertScene(scene);
    }

    /**
     * 修改场景联动
     * 
     * @param scene 场景联动
     * @return 结果
     */
    @Override
    public int updateScene(Scene scene)
    {
        scene.setUpdateTime(DateUtils.getNowDate());
        return sceneMapper.updateScene(scene);
    }

    /**
     * 批量删除场景联动
     * 
     * @param sceneIds 需要删除的场景联动主键
     * @return 结果
     */
    @Override
    public int deleteSceneBySceneIds(Long[] sceneIds)
    {
        return sceneMapper.deleteSceneBySceneIds(sceneIds);
    }

    /**
     * 删除场景联动信息
     * 
     * @param sceneId 场景联动主键
     * @return 结果
     */
    @Override
    public int deleteSceneBySceneId(Long sceneId)
    {
        return sceneMapper.deleteSceneBySceneId(sceneId);
    }
}
