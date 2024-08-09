package com.fastbee.iot.service.impl;

import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.SceneScript;
import com.fastbee.iot.mapper.SceneScriptMapper;
import com.fastbee.iot.service.ISceneScriptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 场景脚本Service业务层处理
 * 
 * @author kerwincui
 * @date 2023-12-27
 */
@Service
public class SceneScriptServiceImpl implements ISceneScriptService
{
    @Autowired
    private SceneScriptMapper sceneScriptMapper;

    /**
     * 查询场景脚本
     * 
     * @param scriptId 场景脚本主键
     * @return 场景脚本
     */
    @Override
    public SceneScript selectSceneScriptBySceneScriptId(String scriptId)
    {
        return sceneScriptMapper.selectSceneScriptBySceneScriptId(scriptId);
    }

    /**
     * 查询场景脚本列表
     * 
     * @param sceneScript 场景脚本
     * @return 场景脚本
     */
    @Override
    public List<SceneScript> selectSceneScriptList(SceneScript sceneScript)
    {
        return sceneScriptMapper.selectSceneScriptList(sceneScript);
    }

    /**
     * 新增场景脚本
     * 
     * @param sceneScript 场景脚本
     * @return 结果
     */
    @Override
    public int insertSceneScript(SceneScript sceneScript)
    {
        sceneScript.setCreateTime(DateUtils.getNowDate());
        return sceneScriptMapper.insertSceneScript(sceneScript);
    }

    /**
     * 修改场景脚本
     * 
     * @param sceneScript 场景脚本
     * @return 结果
     */
    @Override
    public int updateSceneScript(SceneScript sceneScript)
    {
        return sceneScriptMapper.updateSceneScript(sceneScript);
    }

    /**
     * 批量删除场景脚本
     * 
     * @param scriptIds 需要删除的场景脚本主键
     * @return 结果
     */
    @Override
    public int deleteSceneScriptBySceneScriptIds(String[] scriptIds)
    {
        return sceneScriptMapper.deleteSceneScriptBySceneScriptIds(scriptIds);
    }

    /**
     * 删除场景脚本信息
     * 
     * @param scriptId 场景脚本主键
     * @return 结果
     */
    @Override
    public int deleteSceneScriptBySceneScriptId(String scriptId)
    {
        return sceneScriptMapper.deleteSceneScriptBySceneScriptId(scriptId);
    }
}
