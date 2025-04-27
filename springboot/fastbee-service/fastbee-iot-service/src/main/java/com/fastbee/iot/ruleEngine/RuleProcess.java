package com.fastbee.iot.ruleEngine;

import com.alibaba.fastjson2.JSON;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.core.redis.RedisKeyBuilder;
import com.fastbee.iot.model.ProductCode;
import com.fastbee.iot.model.ScriptCondition;
import com.fastbee.iot.service.IProductService;
import com.fastbee.iot.service.IScriptService;
import com.fastbee.ruleEngine.context.MsgContext;
import com.fastbee.ruleEngine.core.FlowLogExecutor;
import com.yomahub.liteflow.builder.el.LiteFlowChainELBuilder;
import com.yomahub.liteflow.flow.LiteflowResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import jakarta.annotation.Resource;
import java.util.Objects;

/**
 * 执行规则引擎
 *
 * @author gsb
 * @date 2024/2/3 16:07
 */
@Component
@Slf4j
public class RuleProcess {

    @Resource
    private FlowLogExecutor flowLogExecutor;
    @Resource
    private IScriptService scriptService;
    @Resource
    private RedisCache redisCache;
    @Resource
    private IProductService productService;

    /**
     * 规则引擎脚本处理
     *
     * @param topic
     * @param payload
     * @param event   1=设备上报 2=平台下发 3=设备上线 4=设备下线 （其他可以增加设备完成主题订阅之类）
     * @return
     */
    public MsgContext processRuleScript(String serialNumber, int event, String topic, String payload) {
        System.out.println("执行产品规则脚本...");
        ProductCode productCode = getDeviceDetail(serialNumber);
        if (Objects.isNull(productCode)){
            return new MsgContext();
        }
        // 查询数据流脚本组件
        ScriptCondition scriptCondition = new ScriptCondition();
        scriptCondition.setProductId(productCode.getProductId());
        scriptCondition.setScriptEvent(event);    // 事件 1=设备上报 2=平台下发 3=设备上线 4=设备下线
        scriptCondition.setScriptPurpose(1);  // 脚本用途：数据流=1
        String[] scriptIds = scriptService.selectRuleScriptIdArray(scriptCondition);
        MsgContext context = MsgContext.builder()
                .serialNumber(serialNumber)
                .productId(productCode.getProductId())
                .protocolCode(productCode.getProtocolCode())
                .payload(payload)
                .topic(topic)
                .build();
        //如果查询不到脚本，则认为是不用处理
        if (Objects.isNull(scriptIds) || scriptIds.length == 0) {
            return new MsgContext();
        }
        // 动态构造Chain和EL表达式
        for (String script : scriptIds) {
            String eChainName = "dataChain_" + script;
            String requestId = "script/" + script;
            String el = "THEN(" + script + ")";
            LiteFlowChainELBuilder.createChain().setChainName(eChainName).setEL(el).build();
            // 执行规则脚本
            LiteflowResponse response = flowLogExecutor.execute2RespWithRid(eChainName, null, requestId, context);
            if (!response.isSuccess()) {
                log.error("规则脚本执行发生错误：" + response.getMessage());
            }
        }
        return context;
    }


    /**
     * 查询产品id,协议编号，缓存到redis,后续查询协议的地方替换数据库查询
     *
     * @param serialNumber
     */
    public ProductCode getDeviceDetail(String serialNumber) {
        ProductCode productCode;
        String cacheKey = RedisKeyBuilder.buildDeviceMsgCacheKey(serialNumber);
        if (redisCache.containsKey(cacheKey)) {
            Object cacheObject = redisCache.getCacheObject(cacheKey);
            return JSON.parseObject(cacheObject.toString(), ProductCode.class);
        }
        productCode = productService.getProtocolBySerialNumber(serialNumber);
        String jsonString = JSON.toJSONString(productCode);
        redisCache.setCacheObject(cacheKey, jsonString);
        return productCode;
    }
}
