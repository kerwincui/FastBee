package com.fastbee.iot.service.impl;

import cn.hutool.core.lang.Snowflake;
import cn.hutool.core.util.IdUtil;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.domain.entity.SysRole;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.iot.domain.Script;
import com.fastbee.iot.mapper.ScriptMapper;
import com.fastbee.iot.model.ScriptCondition;
import com.fastbee.iot.ruleEngine.security.ScriptSecurityValidator;
import com.fastbee.iot.service.IScriptService;
import com.yomahub.liteflow.core.FlowExecutor;
import com.yomahub.liteflow.builder.LiteFlowNodeBuilder;
import com.yomahub.liteflow.enums.NodeTypeEnum;
import com.yomahub.liteflow.flow.FlowBus;
import com.yomahub.liteflow.flow.element.Node;
import com.yomahub.liteflow.script.ScriptExecutorFactory;
import org.apache.commons.io.input.ReversedLinesFileReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import com.fastbee.ruleEngine.security.SecureGroovyScriptExecutor;
import org.slf4j.LoggerFactory;
import lombok.extern.slf4j.Slf4j;
import ch.qos.logback.classic.LoggerContext;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static com.fastbee.common.core.domain.AjaxResult.success;
import static com.fastbee.common.utils.SecurityUtils.getLoginUser;

/**
 * 规则引擎脚本Service业务层处理
 *
 * @author lizhuangpeng
 * @date 2023-07-01
 */
@Slf4j
@Service
public class ScriptServiceImpl implements IScriptService
{
    @Autowired
    private ScriptMapper ruleScriptMapper;

    @Resource
    private FlowExecutor flowExecutor;

    @Resource
    private ScriptSecurityValidator scriptSecurityValidator;

    /**
     * 查询规则引擎脚本
     *
     * @param scriptId 规则引擎脚本主键
     * @return 规则引擎脚本
     */
    @Override
    public Script selectRuleScriptById(String scriptId)
    {
        return ruleScriptMapper.selectRuleScriptById(scriptId);
    }

    /**
     * 查询规则引擎脚本日志
     *
     * @param id 规则引擎脚本主键
     * @return 规则引擎脚本
     */

    @Override
    public String selectRuleScriptLog(String type, String id) {
        // 获取日志存储路径
        LoggerContext loggerContext = (LoggerContext) LoggerFactory.getILoggerFactory();
        String path = loggerContext.getProperty("log.path");

        // 倒叙读取500条日志
        try {
            List<String> lines = new ArrayList<>();
            ReversedLinesFileReader reader = new ReversedLinesFileReader(new File(path + "/rule/" + type + ".log"));
            String line = "";
            while ((line = reader.readLine()) != null && lines.size() < 500) {
                String requestId = type + "/" + id;
                if (line.contains(requestId)) {
                    lines.add(line);
                }
            }
            Collections.reverse(lines);
            return String.join("\n", lines);
        } catch (IOException e) {
            return "暂无日志,详情如下：\n" + e.toString();
        }
    }


    /**
     * 查询规则引擎脚本列表
     *
     * @param ruleScript 规则引擎脚本
     * @return 规则引擎脚本
     */
    @Override
    public List<Script> selectRuleScriptList(Script ruleScript)
    {
        SysUser sysUser = getLoginUser().getUser();
        List<SysRole> roles = sysUser.getRoles();
        for (SysRole role : roles) {
            if (role.getRoleKey().equals("general") || role.getRoleKey().equals("tenant")) {
                // 用户和租户只能查看自己的规则脚本
                ruleScript.setUserId(sysUser.getUserId());
                break;
            }
        }
        return ruleScriptMapper.selectRuleScriptList(ruleScript);
    }

    /**
     * 查询规则引擎脚本标识数组（设备用户和租户的脚本）
     *
     * @return 规则引擎脚本
     */
    @Override
    public String[] selectRuleScriptIdArray(ScriptCondition scriptCondition)
    {
        return ruleScriptMapper.selectRuleScriptIdArray(scriptCondition);
    }

    /**
     * 新增规则引擎脚本
     *
     * @param ruleScript 规则引擎脚本
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertRuleScript(Script ruleScript)
    {
        // 保留原始源码；默认导入和安全限制由统一编译器处理
        ruleScript.setScriptData(replaceAllowPackage(ruleScript.getScriptData()));
        // 统一受限编译校验，成功后才允许入库
        assertScriptSafe(ruleScript);
        if (ruleScript.getEnable() == null) ruleScript.setEnable(1);
        Class<? extends groovy.lang.Script> compiled = SecureGroovyScriptExecutor.compileSource(ruleScript.getScriptData());
        // 设置脚本标识,D=数据流，A=执行动作，T=触发器,雪花算法生成唯一数
        Snowflake snowflake = IdUtil.createSnowflake(1,1);
        ruleScript.setScriptId("D"+snowflake.nextId());
        SysUser sysUser = getLoginUser().getUser();
        ruleScript.setUserId(sysUser.getUserId());
        ruleScript.setUserName(sysUser.getUserName());
        ruleScript.setCreateTime(DateUtils.getNowDate());
        int result = ruleScriptMapper.insertRuleScript(ruleScript);
        // 动态刷新脚本
        if(result==1){
            publishAfterCommit(ruleScript, compiled);
        }
        return result;
    }

    /**
     * 脚本安全校验，未通过时直接抛出业务异常，阻止脚本入库与热加载
     */
    private void assertScriptSafe(Script ruleScript) {
        if (ruleScript.getScriptLanguage() != null) {
            ruleScript.setScriptLanguage(ruleScript.getScriptLanguage().trim().toLowerCase(java.util.Locale.ROOT));
        }
        String error = scriptSecurityValidator.validateLanguage(ruleScript.getScriptLanguage());
        if (error != null) {
            throw new ServiceException(error);
        }
        if (StringUtils.isEmpty(ruleScript.getScriptType())) {
            ruleScript.setScriptType(Integer.valueOf(2).equals(ruleScript.getScriptPurpose()) ? "boolean_script" : "script");
        }
        NodeTypeEnum nodeType = NodeTypeEnum.getEnumByCode(ruleScript.getScriptType());
        if (nodeType == null || !nodeType.isScript()) {
            throw new ServiceException("不支持的规则脚本类型：" + ruleScript.getScriptType());
        }
        error = scriptSecurityValidator.validateScriptData(ruleScript.getScriptData());
        if (error != null) {
            throw new ServiceException(error);
        }
    }

    /**
     * 脚本中引用包替换为许可的包
     * @return
     */
    private String replaceAllowPackage(String scriptData) {
        // Preserve imports and multiline strings; the safe compiler supplies default imports.
        return scriptData;
    }

    /**
     * 修改规则引擎脚本
     *
     * @param ruleScript 规则引擎脚本
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateRuleScript(Script ruleScript)
    {
        SysUser sysUser = getLoginUser().getUser();
        Script existing = ruleScriptMapper.selectRuleScriptById(ruleScript.getScriptId());
        if (existing == null) {
            throw new ServiceException("规则脚本不存在：" + ruleScript.getScriptId());
        }
        // 越权校验：非管理员只能修改自己创建的脚本
        if (!sysUser.isAdmin() && !sysUser.getUserId().equals(existing.getUserId())) {
            throw new ServiceException("无权修改他人创建的规则脚本");
        }
        // 脚本中引用包替换为许可的包
        if (ruleScript.getScriptData() == null) ruleScript.setScriptData(existing.getScriptData());
        if (ruleScript.getScriptLanguage() == null) ruleScript.setScriptLanguage(existing.getScriptLanguage());
        if (ruleScript.getEnable() == null) ruleScript.setEnable(existing.getEnable());
        if (ruleScript.getScriptType() == null) ruleScript.setScriptType(existing.getScriptType());
        if (ruleScript.getScriptPurpose() == null) ruleScript.setScriptPurpose(existing.getScriptPurpose());
        if (ruleScript.getScriptName() == null) ruleScript.setScriptName(existing.getScriptName());
        ruleScript.setScriptData(replaceAllowPackage(ruleScript.getScriptData()));
        // 统一受限编译校验，成功后才允许入库
        assertScriptSafe(ruleScript);
        Class<? extends groovy.lang.Script> compiled = SecureGroovyScriptExecutor.compileSource(ruleScript.getScriptData());
        // 归属与主键不允许通过请求体改写，避免把脚本转移给他人或改写到别的组件标识上
        ruleScript.setScriptId(existing.getScriptId());
        ruleScript.setUserId(null);
        ruleScript.setUserName(null);
        ruleScript.setUpdateTime(DateUtils.getNowDate());
        int result = ruleScriptMapper.updateRuleScript(ruleScript);
        // 动态刷新脚本
        if(result==1){
            publishAfterCommit(ruleScript, compiled);
        }
        return result;
    }

    /**
     * 批量删除规则引擎脚本
     *
     * @param ids 需要删除的规则引擎脚本主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteRuleScriptByIds(String[] ids)
    {
        SysUser user = getLoginUser().getUser();
        for (String id : ids) {
            Script script = ruleScriptMapper.selectRuleScriptById(id);
            if (script == null || !user.isAdmin() && !user.getUserId().equals(script.getUserId()))
                throw new ServiceException("无权删除该规则脚本");
        }
        int result = ruleScriptMapper.deleteRuleScriptByIds(ids);
        if (result > 0) afterCommit(() -> {
            for (String id : ids) ScriptExecutorFactory.loadInstance().getScriptExecutor("groovy").unLoad(id);
        });
        return result;
    }

    /**
     * 删除规则引擎脚本信息
     *
     * @param id 规则引擎脚本主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteRuleScriptById(String id)
    {
        return deleteRuleScriptByIds(new String[]{id});
    }

    private void publishAfterCommit(Script script, Class<? extends groovy.lang.Script> compiled) {
        SecureGroovyScriptExecutor executor = (SecureGroovyScriptExecutor) ScriptExecutorFactory.loadInstance().getScriptExecutor("groovy");
        final String id = script.getScriptId();
        final boolean enabled = Integer.valueOf(1).equals(script.getEnable());
        final String source = script.getScriptData();
        final String name = script.getScriptName();
        final NodeTypeEnum type = NodeTypeEnum.getEnumByCode(script.getScriptType());
        afterCommit(() -> {
            if (!enabled) {
                executor.unLoad(id);
                return;
            }
            Node node = FlowBus.getNode(id);
            if (node == null || node.getType() != type) {
                // A compiled cache entry alone is not a LiteFlow node. Register new nodes
                // only after commit, through the same restricted compiler/SPI.
                LiteFlowNodeBuilder.createNode().setType(type).setId(id).setName(name)
                        .setLanguage("groovy").setScript(source).build();
            } else {
                // Keep source metadata aligned so a later rule reload cannot restore old code.
                node.setScript(source);
                node.setLanguage("groovy");
                if (name != null) node.setName(name);
            }
            executor.install(id, compiled);
        });
    }

    private void afterCommit(Runnable action) {
        if (TransactionSynchronizationManager.isSynchronizationActive()) {
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
                @Override public void afterCommit() { action.run(); }
            });
        } else action.run();
    }

    /**
     * 验证脚本
     * ruleScript.scriptData 脚本数据
     * @return
     */
    @Override
    public AjaxResult validateScript(Script ruleScript){
        // 与保存路径使用同一编译器；验证不执行脚本，也不发布到全局节点缓存
        String scriptData = replaceAllowPackage(ruleScript.getScriptData());
        String language = StringUtils.isEmpty(ruleScript.getScriptLanguage()) ? "groovy" : ruleScript.getScriptLanguage();
        String error = scriptSecurityValidator.validateLanguage(language);
        if (error == null) {
            error = scriptSecurityValidator.validateScriptData(scriptData);
        }
        if (error != null) {
            return success("验证失败，错误信息：" + error, false);
        }
        // 只做编译校验，不再 load 到执行器：load 会以固定节点名覆盖全局组件注册表，
        // 使任意登录用户都能往内存里塞入未落库的脚本组件
        return success("验证成功，脚本的实际执行情况可以查看后端日志文件", true);
    }
}
