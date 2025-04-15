package com.fastbee.iot.service.impl;

import cn.hutool.core.lang.Snowflake;
import cn.hutool.core.util.IdUtil;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.domain.entity.SysRole;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.Script;
import com.fastbee.iot.mapper.ScriptMapper;
import com.fastbee.iot.model.ScriptCondition;
import com.fastbee.iot.service.IScriptService;
import com.yomahub.liteflow.core.FlowExecutor;
import com.yomahub.liteflow.script.ScriptExecutorFactory;
import org.apache.commons.io.input.ReversedLinesFileReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.LoggerFactory;
import lombok.extern.slf4j.Slf4j;
import ch.qos.logback.classic.LoggerContext;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.fastbee.common.core.domain.AjaxResult.success;
import static com.fastbee.common.utils.SecurityUtils.getLoginUser;

/**
 * 规则引擎脚本Service业务层处理
 *
 * @author lizhuangpeng
 * @date 2023-07-01
 */
@Service
public class ScriptServiceImpl implements IScriptService
{
    @Autowired
    private ScriptMapper ruleScriptMapper;

    @Resource
    private FlowExecutor flowExecutor;

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
    public int insertRuleScript(Script ruleScript)
    {
        // 脚本中引用包替换为许可的包
        ruleScript.setScriptData(replaceAllowPackage(ruleScript.getScriptData()));
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
            ScriptExecutorFactory.loadInstance().getScriptExecutor(ruleScript.getScriptLanguage()).load(ruleScript.getScriptId(), ruleScript.getScriptData());
        }
        return result;
    }

    /**
     * 脚本中引用包替换为许可的包
     * @return
     */
    private String replaceAllowPackage(String scriptData){
        String header="import cn.hutool.json.JSONArray;\n" +
                "import cn.hutool.json.JSONObject;\n" +
                "import cn.hutool.json.JSONUtil;\n" +
                "import cn.hutool.core.util.NumberUtil;\n";
        // 正则替换import为许可的引用包
        String pattern = "import.*[;\\n\\s]";
        String data = scriptData.replaceAll(pattern, "");
        return header + data;
    }

    /**
     * 修改规则引擎脚本
     *
     * @param ruleScript 规则引擎脚本
     * @return 结果
     */
    @Override
    public int updateRuleScript(Script ruleScript)
    {
        // 脚本中引用包替换为许可的包
        ruleScript.setScriptData(replaceAllowPackage(ruleScript.getScriptData()));
        ruleScript.setUpdateTime(DateUtils.getNowDate());
        int result = ruleScriptMapper.updateRuleScript(ruleScript);
        // 动态刷新脚本
        if(result==1){
            ScriptExecutorFactory.loadInstance().getScriptExecutor(ruleScript.getScriptLanguage()).load(ruleScript.getScriptId(), ruleScript.getScriptData());
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
    public int deleteRuleScriptByIds(String[] ids)
    {
        return ruleScriptMapper.deleteRuleScriptByIds(ids);
    }

    /**
     * 删除规则引擎脚本信息
     *
     * @param id 规则引擎脚本主键
     * @return 结果
     */
    @Override
    public int deleteRuleScriptById(String id)
    {
        return ruleScriptMapper.deleteRuleScriptById(id);
    }

    /**
     * 验证脚本
     * ruleScript.scriptData 脚本数据
     * @return
     */
    @Override
    public AjaxResult validateScript(Script ruleScript){
        // 检查安全性检查
        String pattern  = ".*while|for\\s*\\(|InputStream|OutputStream|Reader|Writer|File|Socket.*";
        Pattern r = Pattern.compile(pattern);
        Matcher m = r.matcher(ruleScript.getScriptData());
        if(m.find()){
            return success("验证失败，错误信息：" + "不能包含关键词for、while、Reader、Write、File、Socket等",false);
        }
        // 热刷新脚本
        try {
            ScriptExecutorFactory.loadInstance().getScriptExecutor("groovy").load("validateScript", ruleScript.getScriptData());
        }catch(Exception e){
            return success("验证失败，错误信息：" + e.getMessage(),false);
        }
        return success("验证成功，脚本的实际执行情况可以查看后端日志文件",true);
    }
}
