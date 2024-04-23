package com.fastbee.iot.service;

import com.fastbee.iot.domain.SceneScript;

import java.util.List;

/**
 * 场景脚本Service接口
 * 
 * @author kerwincui
 * @date 2023-12-27
 */
public interface ISceneScriptService 
{
    /**
     * 查询场景脚本
     * 
     * @param scriptId 场景脚本主键
     * @return 场景脚本
     */
    public SceneScript selectSceneScriptBySceneScriptId(String scriptId);

    /**
     * 查询场景脚本列表
     * 
     * @param sceneScript 场景脚本
     * @return 场景脚本集合
     */
    public List<SceneScript> selectSceneScriptList(SceneScript sceneScript);

    /**
     * 新增场景脚本
     * 
     * @param sceneScript 场景脚本
     * @return 结果
     */
    public int insertSceneScript(SceneScript sceneScript);

    /**
     * 修改场景脚本
     * 
     * @param sceneScript 场景脚本
     * @return 结果
     */
    public int updateSceneScript(SceneScript sceneScript);

    /**
     * 批量删除场景脚本
     * 
     * @param scriptIds 需要删除的场景脚本主键集合
     * @return 结果
     */
    public int deleteSceneScriptBySceneScriptIds(String[] scriptIds);

    /**
     * 删除场景脚本信息
     * 
     * @param scriptId 场景脚本主键
     * @return 结果
     */
    public int deleteSceneScriptBySceneScriptId(String scriptId);
}
