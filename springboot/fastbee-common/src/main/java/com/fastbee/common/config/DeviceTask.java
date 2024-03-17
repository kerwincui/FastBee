package com.fastbee.common.config;

import com.fastbee.common.constant.FastBeeConstant;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;
import java.util.concurrent.ThreadPoolExecutor;

/**
 * 设备报文处理线程池
 * @author bill
 */
@Configuration
@EnableAsync
@ConfigurationProperties(prefix = "spring.task.execution.pool")
@Data
public class DeviceTask {

    private int coreSize;

    private int maxSize;

    private int queueCapacity;

    private int  keepAlive;

    /*设备状态池*/
    @Bean(FastBeeConstant.TASK.DEVICE_STATUS_TASK)
    public Executor deviceStatusTaskExecutor() {
      return builder(FastBeeConstant.TASK.DEVICE_STATUS_TASK);
    }

    /*平台自动获取线程池(例如定时获取设备信息)*/
    @Bean(FastBeeConstant.TASK.DEVICE_FETCH_PROP_TASK)
    public Executor deviceFetchTaskExecutor() {
        return builder(FastBeeConstant.TASK.DEVICE_FETCH_PROP_TASK);
    }

    /*设备回调信息(下发指令(服务)设备应答信息)*/
    @Bean(FastBeeConstant.TASK.DEVICE_REPLY_MESSAGE_TASK)
    public Executor deviceReplyTaskExecutor() {
        return builder(FastBeeConstant.TASK.DEVICE_REPLY_MESSAGE_TASK);
    }

    /*设备主动上报(设备数据有变化主动上报)*/
    @Bean(FastBeeConstant.TASK.DEVICE_UP_MESSAGE_TASK)
    public Executor deviceUpMessageTaskExecutor() {
        return builder(FastBeeConstant.TASK.DEVICE_UP_MESSAGE_TASK);
    }

    /*指令下发(服务下发)*/
    @Bean(FastBeeConstant.TASK.FUNCTION_INVOKE_TASK)
    public Executor functionInvokeTaskExecutor() {
        return builder(FastBeeConstant.TASK.FUNCTION_INVOKE_TASK);
    }

    /*内部消费线程*/
    @Bean(FastBeeConstant.TASK.MESSAGE_CONSUME_TASK)
    public Executor messageConsumeTaskExecutor() {
        return builder(FastBeeConstant.TASK.MESSAGE_CONSUME_TASK);
    }

    @Bean(FastBeeConstant.TASK.MESSAGE_CONSUME_TASK_PUB)
    public Executor messageConsumePubTaskExecutor(){
        return builder(FastBeeConstant.TASK.MESSAGE_CONSUME_TASK_PUB);
    }

    @Bean(FastBeeConstant.TASK.MESSAGE_CONSUME_TASK_FETCH)
    public Executor messageConsumeFetchTaskExecutor(){
        return builder(FastBeeConstant.TASK.MESSAGE_CONSUME_TASK_FETCH);
    }

    @Bean(FastBeeConstant.TASK.DELAY_UPGRADE_TASK)
    public Executor delayedTaskExecutor(){
        return builder(FastBeeConstant.TASK.DELAY_UPGRADE_TASK);
    }

    /*设备其他消息处理*/
    @Bean(FastBeeConstant.TASK.DEVICE_OTHER_TASK)
    public Executor deviceOtherTaskExecutor(){
        return builder(FastBeeConstant.TASK.DEVICE_OTHER_TASK);
    }

    /*组装线程池*/
    private ThreadPoolTaskExecutor builder(String threadNamePrefix){
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(coreSize);
        executor.setMaxPoolSize(maxSize);
        executor.setKeepAliveSeconds(keepAlive);
        executor.setQueueCapacity(queueCapacity);
        // 线程池对拒绝任务的处理策略
        executor.setRejectedExecutionHandler(new ThreadPoolExecutor.DiscardOldestPolicy());
        //线程池名的前缀
        executor.setThreadNamePrefix(threadNamePrefix);
        executor.initialize();
        return executor;
    }

}
