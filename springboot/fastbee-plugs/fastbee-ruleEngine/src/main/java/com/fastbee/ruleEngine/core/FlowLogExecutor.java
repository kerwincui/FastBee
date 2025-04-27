package com.fastbee.ruleEngine.core;

import com.fastbee.ruleEngine.context.MsgContext;
import com.yomahub.liteflow.core.FlowExecutor;
import com.yomahub.liteflow.flow.LiteflowResponse;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import jakarta.annotation.Resource;
import java.util.Objects;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

@Component
@Slf4j
public class FlowLogExecutor {
    private static final Logger script_logger = LoggerFactory.getLogger("script");
    private static final Logger scene_logger = LoggerFactory.getLogger("scene");
    @Resource
    private FlowExecutor flowExecutor;


    public LiteflowResponse execute2Resp(String chainId, Object param, Object... contextBeanArray) {
        printContextBean(contextBeanArray);
        LiteflowResponse response = flowExecutor.execute2Resp(chainId, param, contextBeanArray);
        printResponse(response);
        return response;
    }

    public LiteflowResponse execute2RespWithRid(String chainId, Object param, String requestId, Object... contextBeanArray) {
        printContextBeanWithRid(requestId, contextBeanArray);
        LiteflowResponse response = flowExecutor.execute2RespWithRid(chainId, param, requestId, contextBeanArray);
        printResponseWithRid(requestId, response);
        return response;
    }

    public LiteflowResponse execute2Future(String chainId, Object param, Object... contextBeanArray) throws ExecutionException, InterruptedException {
        printContextBean(contextBeanArray);
        Future<LiteflowResponse> future = flowExecutor.execute2Future(chainId, param, contextBeanArray);
        LiteflowResponse response = future.get();
        printResponse(response);
        return response;
    }

    public LiteflowResponse execute2FutureWithRid(String chainId, Object param, String requestId, Object... contextBeanArray) throws ExecutionException, InterruptedException {
        printContextBeanWithRid(requestId, contextBeanArray);
        Future<LiteflowResponse> future = flowExecutor.execute2FutureWithRid(chainId, param, requestId, contextBeanArray);
        LiteflowResponse response = future.get();
        printResponseWithRid(requestId, response);
        return response;
    }

    public void printContextBean(Object... contextBeanArray) {
        log.info("=====+>规则引擎执行前，上下文变量值");
        for (Object contextBean : contextBeanArray) {
            log.info("上下文数值：{}", contextBean);
        }
        log.info("=====+>规则引擎正在执行......");
    }

    public void printContextBeanWithRid(String requestId, Object... contextBeanArray) {
        Logger ruleLogger;
        String[] parts = requestId.split("/");
        if (parts.length >= 2) {
            if (Objects.equals(parts[0], "script")) {
                ruleLogger = script_logger;
            } else if (Objects.equals(parts[0], "scene")) {
                ruleLogger = scene_logger;
            } else {
                ruleLogger = log;
            }
            ruleLogger.info("[{}]=====+>规则引擎执行前，上下文变量值", requestId);
            for (Object contextBean : contextBeanArray) {
                ruleLogger.info("[{}]=====+>上下文数值：{}", requestId, contextBean);
            }
            ruleLogger.info("[{}]=====+>规则引擎正在执行......", requestId);
        }
    }

    public void printResponse(LiteflowResponse response) {
        if (!response.isSuccess()) {
            Exception e = response.getCause();
            log.error("=====+>报错信息：{}", e.getMessage(), e);
        } else {
            //步骤详情
//            Map<String, List<CmpStep>> stepMap = response.getExecuteSteps();
//            stepMap.forEach((k, v) -> {
//                v.forEach((step) -> {
//                    log.info("步骤：{}({})，执行时间：{}", step.getNodeId(), step.getNodeName(), step.getTimeSpent());
//                });
//            });
            //每各步骤执行时间
            String stepStr = response.getExecuteStepStrWithTime();
            log.info("=====+>步骤：{}", stepStr);
        }
    }

    public void printResponseWithRid(String requestId, LiteflowResponse response) {
        Logger ruleLogger;
        String[] parts = requestId.split("/");
        if (parts.length >= 2) {
            if (Objects.equals(parts[0], "script")) {
                ruleLogger = script_logger;
                MsgContext msgContext = response.getContextBean(MsgContext.class);
                if (msgContext != null) {
                    ruleLogger.info("[{}]=====+>执行后，msgContext：{}", requestId, msgContext);
                }
            } else if (Objects.equals(parts[0], "scene")) {
                ruleLogger = scene_logger;
            } else {
                ruleLogger = log;
            }
            if (!response.isSuccess()) {
                Exception e = response.getCause();
                ruleLogger.error("[{}]=====+>报错信息：{}", requestId, e.toString());
            } else {
                //每各步骤执行时间
                String stepStr = response.getExecuteStepStrWithTime();
                ruleLogger.info("[{}]=====+>步骤：{}", requestId, stepStr);
                ruleLogger.info("[{}]=====+>执行完成！", requestId);
            }
        }
    }
}
