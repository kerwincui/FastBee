package com.fastbee.iot.service.impl;

import cn.hutool.core.lang.Snowflake;
import cn.hutool.core.util.IdUtil;
import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.core.domain.entity.SysRole;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.exception.job.TaskException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.iot.domain.*;
import com.fastbee.iot.mapper.SceneDeviceMapper;
import com.fastbee.iot.mapper.SceneMapper;
import com.fastbee.iot.mapper.SceneScriptMapper;
import com.fastbee.iot.mapper.ScriptMapper;
import com.fastbee.iot.model.ScriptTemplate;
import com.fastbee.iot.service.IDeviceJobService;
import com.fastbee.iot.service.ISceneService;
import com.fastbee.quartz.util.CronUtils;
import com.yomahub.liteflow.builder.LiteFlowNodeBuilder;
import com.yomahub.liteflow.builder.el.LiteFlowChainELBuilder;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang.StringEscapeUtils;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.fastbee.common.utils.SecurityUtils.getLoginUser;

/**
 * 场景联动Service业务层处理
 *
 * @author kerwincui
 * @date 2022-01-13
 */
@Service
public class SceneServiceImpl implements ISceneService {

    private static final Logger log = LoggerFactory.getLogger(SceneServiceImpl.class);

    @Autowired
    private Scheduler scheduler;

    @Autowired
    RedisCache redisCache;

    @Autowired
    private SceneMapper sceneMapper;

    @Autowired
    private IDeviceJobService jobService;

    @Autowired
    private ScriptMapper ruleScriptMapper;

    @Autowired
    private SceneScriptMapper sceneScriptMapper;

    @Autowired
    private SceneDeviceMapper sceneDeviceMapper;
//    @Resource
//    private IAlertService alertService;

    /**
     * 查询场景联动
     *
     * @param sceneId 场景联动主键
     * @return 场景联动
     */
    @Override
    public Scene selectSceneBySceneId(Long sceneId) {
        // 查询场景
        Scene scene = sceneMapper.selectSceneBySceneId(sceneId);
        // 查询场景脚本
        SceneScript scriptParam = new SceneScript();
        scriptParam.setSceneId(scene.getSceneId());
        List<SceneScript> sceneScripts = sceneScriptMapper.selectSceneScriptList(scriptParam);
        // 查询场景设备
        SceneDevice deviceParam = new SceneDevice();
        deviceParam.setSceneId(scene.getSceneId());
        List<SceneDevice> sceneDevices = sceneDeviceMapper.selectSceneDeviceList(deviceParam);
        // 构建场景设备列表，触发器和执行动作集合
        List<SceneScript> triggers = new ArrayList<>();
        List<SceneScript> actions = new ArrayList<>();
        for (SceneScript sceneScript : sceneScripts) {
            // 构建设备列表
            List<String> deviceList = new ArrayList<>();
            for (SceneDevice sceneDevice : sceneDevices) {
                if (sceneDevice.getScriptId().equals(sceneScript.getScriptId())) {
                    deviceList.add(sceneDevice.getSerialNumber());
                }
            }
            sceneScript.setDeviceNums(deviceList.toArray(new String[deviceList.size()]));
            if (sceneScript.getScriptPurpose() == 2) {
                triggers.add(sceneScript);
            } else if (sceneScript.getScriptPurpose() == 3) {
                actions.add(sceneScript);
            }
        }
        scene.setTriggers(triggers);
        scene.setActions(actions);
        return scene;
    }

    /**
     * 查询场景联动列表
     *
     * @param scene 场景联动
     * @return 场景联动
     */
    @Override
    public List<Scene> selectSceneList(Scene scene) {
        SysUser user = getLoginUser().getUser();
        List<SysRole> roles = user.getRoles();
        for (int i = 0; i < roles.size(); i++) {
            // 租户和用户，只查看自己分组
            if (roles.get(i).getRoleKey().equals("tenant") || roles.get(i).getRoleKey().equals("general")) {
                scene.setUserId(user.getUserId());
                break;
            }
        }
        List<Scene> sceneList = sceneMapper.selectSceneList(scene);
        if (CollectionUtils.isNotEmpty(sceneList)) {
            List<Long> sceneIdList = sceneList.stream().map(Scene::getSceneId).collect(Collectors.toList());
            List<SceneScript> sceneScriptList = sceneScriptMapper.listSceneScriptByPurpose(sceneIdList, 3);
            Map<Long, List<SceneScript>> map = sceneScriptList.stream().collect(Collectors.groupingBy(SceneScript::getSceneId));
            for (Scene updateScene : sceneList) {
                List<SceneScript> sceneScripts = map.get(updateScene.getSceneId());
                if (CollectionUtils.isNotEmpty(sceneScripts)) {
                    updateScene.setActionCount(sceneScripts.size());
                }
            }
        }
        return sceneList;
    }

    /**
     * 新增场景联动
     *
     * @param scene 场景联动
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertScene(Scene scene) {
        if (scene.getTriggers().size() == 0 || scene.getActions().size() == 0) {
            log.error("场景中至少包含一个触发器或者执行动作，否则规则启动报错！");
            return 0;
        }

        // 保存场景联动
        SysUser user = getLoginUser().getUser();
        scene.setCreateBy(user.getUserName());
        scene.setCreateTime(DateUtils.getNowDate());
        scene.setUserId(user.getUserId());
        scene.setUserName(user.getUserName());
        // 延时不超过90秒
        if (scene.getExecuteDelay() > 90) {
            scene.setExecuteDelay(90);
        }
        // 设置规则名称,D=数据流，A=执行动作，T=触发器,C=规则链 雪花算法生成唯一数
        Snowflake snowflake = IdUtil.getSnowflake(1, 1);
        scene.setChainName("C" + String.valueOf(snowflake.nextId()));
        sceneMapper.insertScene(scene);

        // 构建EL和场景数据
        List<Script> ruleScripts = new ArrayList<>();
        List<SceneScript> sceneScripts = new ArrayList<>();
        List<SceneDevice> sceneDevices = new ArrayList<>();
        String elData = buildElData(scene, ruleScripts, sceneScripts, sceneDevices);

        // 更新场景联动规则脚本
        scene.setElData(elData);
        sceneMapper.updateScene(scene);
        // 保存规则脚本
        ruleScriptMapper.insertRuleScriptList(ruleScripts);
        // 保存场景脚本
        sceneScriptMapper.insertSceneScriptList(sceneScripts);
        // 保存场景设备
        if (sceneDevices.size() > 0) {
            sceneDeviceMapper.insertSceneDeviceList(sceneDevices);
        }

        // 动态构建规则链和脚本组件到内存中
        dynamicBuildRule(ruleScripts,scene);
        return 1;
    }

    /**
     * 修改场景联动
     *
     * @param scene 场景联动
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateScene(Scene scene) {
        if (scene.getTriggers().size() == 0 || scene.getActions().size() == 0) {
            log.error("场景中至少包含一个触发器或者执行动作，否则规则启动报错！");
            return 0;
        }

        // 批量删除规则脚本
        ruleScriptMapper.deleteRuleScriptBySceneIds(new Long[]{scene.getSceneId()});
        // 批量删除场景脚本
        sceneScriptMapper.deleteSceneScriptBySceneIds(new Long[]{scene.getSceneId()});
        // 批量删除场景设备
        sceneDeviceMapper.deleteSceneDeviceBySceneIds(new Long[]{scene.getSceneId()});
        // 批量删除定时任务
        try {
            jobService.deleteJobBySceneIds(new Long[]{scene.getSceneId()});
        } catch (SchedulerException e) {
            e.printStackTrace();
        }

        // 构建EL和场景数据
        List<Script> ruleScripts = new ArrayList<>();
        List<SceneScript> sceneScripts = new ArrayList<>();
        List<SceneDevice> sceneDevices = new ArrayList<>();
        String elData = buildElData(scene, ruleScripts, sceneScripts, sceneDevices);

        scene.setElData(elData);
        scene.setUpdateTime(DateUtils.getNowDate());
        sceneMapper.updateScene(scene);
        // 保存规则脚本
        ruleScriptMapper.insertRuleScriptList(ruleScripts);
        // 保存场景脚本
        sceneScriptMapper.insertSceneScriptList(sceneScripts);
        // 保存场景设备
        if (sceneDevices.size() > 0) {
            sceneDeviceMapper.insertSceneDeviceList(sceneDevices);
        }

        // 动态构建规则链和脚本组件到内存中
        dynamicBuildRule(ruleScripts,scene);
        return 1;
    }

    /**
     * 动态构建规则链和脚本组件
     * @param ruleScripts
     */
    private void dynamicBuildRule(List<Script> ruleScripts,Scene scene){
        for(Script ruleScript:ruleScripts){
            // 规则引擎构建脚本组件
            if(ruleScript.getScriptPurpose() == 2) {
                //脚本条件组件
                LiteFlowNodeBuilder.createScriptIfNode().setId(ruleScript.getScriptId())
                        .setName(ruleScript.getScriptName())
                        .setScript(ruleScript.getScriptData())
                        .build();
            }else if(ruleScript.getScriptPurpose() == 3){
                // 普通组件
                LiteFlowNodeBuilder.createScriptNode().setId(ruleScript.getScriptId())
                        .setName(ruleScript.getScriptName())
                        .setScript(ruleScript.getScriptData())
                        .build();
            }
        }
        // 构建规则链
        LiteFlowChainELBuilder.createChain().setChainName(scene.getChainName()).setEL(scene.getElData()).build();
    }

    /**
     * 构建EL数据
     *
     * @param scene        场景
     * @param ruleScripts  规则脚本集合
     * @param sceneScripts 场景脚本集合
     * @param sceneDevices 场景设备集合
     * @return
     */
    private String buildElData(Scene scene, List<Script> ruleScripts, List<SceneScript> sceneScripts, List<SceneDevice> sceneDevices) {
        // 排除定时后的触发器，等于0不生成规则数据，等于1移除AND和OR
        Long triggerNodeCount = scene.getTriggers().stream().filter(x -> x.getSource() != 2).count();
        Long triggerTimingCount = scene.getTriggers().stream().filter(x -> x.getSource() == 2).count();

        // 拼接规则数据，格式如：IF(AND(T1,T2,T3),THEN(A1,A2,A3))
        StringBuilder triggerBuilder = new StringBuilder();
        StringBuilder actionBuilder = new StringBuilder();
        if (0 == triggerNodeCount && triggerTimingCount != 0) {
            switch (scene.getExecuteMode()) {
                case 1:
                    actionBuilder.append("THEN(");
                    break;
                case 2:
                    actionBuilder.append("WHEN(");
                    break;
                default:
                    break;
            }
        } else {
            switch (scene.getCond()) {
                case 1:
                    triggerBuilder.append("IF(OR(");
                    break;
                case 2:
                    triggerBuilder.append("IF(AND(");
                    break;
                case 3:
                    triggerBuilder.append("IF(NOT(");
                    break;
                default:
                    break;
            }
            switch (scene.getExecuteMode()) {
                case 1:
                    actionBuilder.append(",THEN(");
                    break;
                case 2:
                    actionBuilder.append(",WHEN(");
                    break;
                default:
                    break;
            }
        }

        for (int i = 0; i < scene.getTriggers().size(); i++) {
            // 保存触发器和执行动作
            String scriptId = buildTriggerAction(scene.getTriggers().get(i), 2, scene, ruleScripts, sceneScripts, sceneDevices);
            // 构建触发器EL，排除定时触发器
            if (scene.getTriggers().get(i).getSource() != 2) {
                triggerBuilder.append(scriptId + ",");
            }
        }
        if (triggerNodeCount > 0) {
            triggerBuilder.deleteCharAt(triggerBuilder.lastIndexOf(","));
            triggerBuilder.append(")");
        }

        for (int i = 0; i < scene.getActions().size(); i++) {
            // 保存触发器和执行动作
            String scriptId = buildTriggerAction(scene.getActions().get(i), 3, scene, ruleScripts, sceneScripts, sceneDevices);
            // 构建执行动作EL
            actionBuilder.append(scriptId + ",");
        }
        if (scene.getActions().size() > 0) {
            actionBuilder.deleteCharAt(actionBuilder.lastIndexOf(","));
        }
        String elData;
        if (StringUtils.isEmpty(triggerBuilder)) {
            actionBuilder.append(")");
            elData = actionBuilder.toString();
        } else {
            actionBuilder.append("))");
            elData = triggerBuilder.append(actionBuilder).toString();
        }
        if (triggerNodeCount == 1) {
            // 移除AND和OR，它们必须包含两个以上组件
            if(elData.indexOf("AND(")!=-1){
                elData=elData.replace("AND(", "").replace("),", ",");
            }else if(elData.indexOf("OR(")!=-1){
                elData=elData.replace("OR(", "").replace("),", ",");
            }
        }
        return elData;
    }

    /**
     * 构建场景中的触发器和执行动作
     *
     * @param sceneScript   场景脚本
     * @param scriptPurpose 脚本用途：1=数据流，2=触发器，3=执行动作
     * @param scene         场景
     * @return 返回规则脚本ID
     */
    private String buildTriggerAction(SceneScript sceneScript, int scriptPurpose, Scene scene, List<Script> ruleScripts, List<SceneScript> sceneScripts, List<SceneDevice> sceneDevices) {
        // 构建规则脚本
        Script ruleScript = new Script();
        // 设置脚本标识,D=数据流，A=执行动作，T=触发器,雪花算法生成唯一数
        Snowflake snowflake = IdUtil.getSnowflake(1, 1);
        String scriptId = String.valueOf(snowflake.nextId());
        if (scriptPurpose == 2) {
            scriptId = "T" + scriptId;
            ruleScript.setScriptType("if_script");
        } else if (scriptPurpose == 3) {
            scriptId = "A" + scriptId;
            ruleScript.setScriptType("script");
        }
        ruleScript.setScriptId(scriptId);
        ruleScript.setScriptName(scriptId);
        ruleScript.setApplicationName("fastbee");
        ruleScript.setScriptLanguage("groovy");
        SysUser user = getLoginUser().getUser();
        ruleScript.setUserId(user.getUserId());
        ruleScript.setUserName(user.getUserName());
        ruleScript.setScriptPurpose(scriptPurpose);
        ruleScript.setEnable(1);
        ruleScript.setScriptOrder(0);
        ruleScript.setScriptEvent(0);
        ruleScript.setScriptAction(0);
        ruleScript.setSceneId(scene.getSceneId());
        ruleScript.setCreateBy(user.getUserName());
        ruleScript.setCreateTime(DateUtils.getNowDate());
        // 构建脚本内容
        ScriptTemplate template=new ScriptTemplate(
                scene.getSceneId(),scriptId,sceneScript.getType(),sceneScript.getSource(),scene.getSilentPeriod(),
                scene.getExecuteDelay(), scene.getCond(),sceneScript.getScriptPurpose(),sceneScript.getId(),sceneScript.getValue(),
                StringUtils.isEmpty(sceneScript.getOperator())?"=":sceneScript.getOperator(),String.join(",", sceneScript.getDeviceNums()),sceneScript.getProductId()
        );
        String data = String.format("String json =\"%s\";\n" +
                "sceneContext.process(json);", StringEscapeUtils.escapeJava(JSONObject.toJSONString(template)));
        ruleScript.setScriptData(data);
        // 构建脚本集合,规则脚本不需要存储定时触发器
        if (sceneScript.getSource() != 2) {
            ruleScripts.add(ruleScript);
        }

        if (scriptPurpose == 2) {
            // 触发器
            if (sceneScript.getSource() == 1) {
                // 构建场景设备集合
                for (int j = 0; j < sceneScript.getDeviceNums().length; j++) {
                    SceneDevice sceneDevice = new SceneDevice();
                    sceneDevice.setSceneId(scene.getSceneId());
                    sceneDevice.setScriptId(scriptId);
                    sceneDevice.setSource(sceneScript.getSource());
                    sceneDevice.setSerialNumber(sceneScript.getDeviceNums()[j]);
                    sceneDevice.setProductId(0L);
                    sceneDevice.setProductName("");
                    sceneDevice.setType(scriptPurpose);
                    sceneDevices.add(sceneDevice);
                }
            }else if (sceneScript.getSource() == 2) {
                // 创建告警定时任务
                createSceneTask(scene, sceneScript);
            }else if (sceneScript.getSource() == 3) {
                // 构建场景设备集合
                SceneDevice sceneDevice = new SceneDevice();
                sceneDevice.setSceneId(scene.getSceneId());
                sceneDevice.setScriptId(scriptId);
                sceneDevice.setSource(sceneScript.getSource());
                sceneDevice.setSerialNumber("");
                sceneDevice.setProductId(sceneScript.getProductId());
                sceneDevice.setProductName(sceneScript.getProductName());
                sceneDevice.setType(scriptPurpose);
                sceneDevices.add(sceneDevice);
            }
        } else if (scriptPurpose == 3) {
            if (sceneScript.getSource() == 1) {
                // 构建场景设备集合
                for (int j = 0; j < sceneScript.getDeviceNums().length; j++) {
                    SceneDevice sceneDevice = new SceneDevice();
                    sceneDevice.setSceneId(scene.getSceneId());
                    sceneDevice.setScriptId(scriptId);
                    sceneDevice.setSource(sceneScript.getSource());
                    sceneDevice.setSerialNumber(sceneScript.getDeviceNums()[j]);
                    sceneDevice.setProductId(0L);
                    sceneDevice.setProductName("");
                    sceneDevice.setType(scriptPurpose);
                    sceneDevices.add(sceneDevice);
                }
            } else if (sceneScript.getSource() == 3) {
                // 构建场景设备集合
                SceneDevice sceneDevice = new SceneDevice();
                sceneDevice.setSceneId(scene.getSceneId());
                sceneDevice.setScriptId(scriptId);
                sceneDevice.setSource(sceneScript.getSource());
                sceneDevice.setSerialNumber("");
                sceneDevice.setProductId(sceneScript.getProductId());
                sceneDevice.setProductName(sceneScript.getProductName());
                sceneDevice.setType(scriptPurpose);
                sceneDevices.add(sceneDevice);
            }
        }

        // 构建场景脚本集合
        sceneScript.setSceneId(scene.getSceneId());
        sceneScript.setScriptId(scriptId);
        sceneScript.setCreateTime(DateUtils.getNowDate());
        sceneScript.setCreateBy(user.getUserName());
        sceneScript.setOperator(StringUtils.isEmpty(sceneScript.getOperator())?"=":sceneScript.getOperator());
        sceneScripts.add(sceneScript);
        // 返回脚本ID
        return scriptId;
    }

    /**
     * 创建场景定时任务
     *
     * @param scene
     * @param sceneScript
     */
    private void createSceneTask(Scene scene, SceneScript sceneScript) {
        // 创建定时任务
        try {
            if (!CronUtils.isValid(sceneScript.getCronExpression())) {
                log.error("新增场景联动定时任务失败，Cron表达式不正确");
                throw new Exception("新增场景联动定时任务失败，Cron表达式不正确");
            }
            DeviceJob deviceJob = new DeviceJob();
            deviceJob.setJobName("场景联动定时触发");
            deviceJob.setJobType(3);
            deviceJob.setJobGroup("DEFAULT");
            deviceJob.setConcurrent("1");
            deviceJob.setMisfirePolicy("2");
            deviceJob.setStatus(scene.getEnable() == 1 ? "0" : "1");
            deviceJob.setCronExpression(sceneScript.getCronExpression());
            deviceJob.setIsAdvance(sceneScript.getIsAdvance());
            deviceJob.setSceneId(scene.getSceneId());
            deviceJob.setDeviceName("场景联动定时触发");
            jobService.insertJob(deviceJob);
        } catch (SchedulerException e) {
            e.printStackTrace();
        } catch (TaskException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 批量删除场景联动
     *
     * @param sceneIds 需要删除的场景联动主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteSceneBySceneIds(Long[] sceneIds) {
        // 批量删除规则脚本
        ruleScriptMapper.deleteRuleScriptBySceneIds(sceneIds);
        // 批量删除场景脚本
        sceneScriptMapper.deleteSceneScriptBySceneIds(sceneIds);
        // 批量删除场景设备
        sceneDeviceMapper.deleteSceneDeviceBySceneIds(sceneIds);
        // 批量删除定时任务
        try {
            jobService.deleteJobBySceneIds(sceneIds);
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
        // 删除告警关联的场景
//        alertService.deleteAlertByAlertIds(sceneIds);
        // 删除缓存静默时间
        for(Long sceneId:sceneIds){
            String key = "silent:" + "scene_" + sceneId;
            redisCache.deleteObject(key);
        }
        return sceneMapper.deleteSceneBySceneIds(sceneIds);
    }

    /**
     * 删除场景联动信息
     *
     * @param sceneId 场景联动主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteSceneBySceneId(Long sceneId) {
        // 批量删除规则脚本
        ruleScriptMapper.deleteRuleScriptBySceneIds(new Long[]{sceneId});
        // 批量删除场景脚本
        sceneScriptMapper.deleteSceneScriptBySceneIds(new Long[]{sceneId});
        // 批量删除场景设备
        sceneDeviceMapper.deleteSceneDeviceBySceneIds(new Long[]{sceneId});
        // 批量删除定时任务
        try {
            jobService.deleteJobBySceneIds(new Long[]{sceneId});
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
        // 删除告警关联的场景
//        alertService.deleteAlertByAlertIds(new Long[]{sceneId});
        // 删除缓存静默时间
        String key = "silent:" + "scene_" + sceneId;
        redisCache.deleteObject(key);
        return sceneMapper.deleteSceneBySceneId(sceneId);
    }

    @Override
    public int updateStatus(Scene scene) {
        Integer enable = scene.getEnable();
        // 更新定时任务状态
        List<DeviceJob> deviceJobList = jobService.listShortJobBySceneId(new Long[]{scene.getSceneId()});
        try {
            for (DeviceJob job : deviceJobList) {
                DeviceJob deviceJob = new DeviceJob();
                deviceJob.setJobId(job.getJobId());
                deviceJob.setJobGroup(job.getJobGroup());
                deviceJob.setActions(enable == 1 ? "0" : "1");
                jobService.changeStatus(deviceJob);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        Scene updateScene = new Scene();
        updateScene.setSceneId(scene.getSceneId());
        updateScene.setEnable(enable);
        return sceneMapper.updateScene(updateScene);
    }

}
