package com.ruoyi.iot.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;
import java.util.concurrent.ThreadPoolExecutor;

@Configuration
@ComponentScan("com.ruoyi.iot")
//注解开启异步任务支持
@EnableAsync
public class TaskConfigurer implements AsyncConfigurer {

    private static final Logger logger = LoggerFactory.getLogger(TaskConfigurer.class);

    @Autowired
    private TaskExecutorConfig config;

    @Bean
    TaskExecutorConfig config(){
        return new TaskExecutorConfig();
    }

    @Override
    public Executor getAsyncExecutor() {

        ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor();
        taskExecutor.setCorePoolSize(config.getCoreSize());
        taskExecutor.setMaxPoolSize(config.getMaxSize());
        taskExecutor.setQueueCapacity(config.getQueueCapacity());
        taskExecutor.setThreadNamePrefix("iot-mqtt-");
        taskExecutor.setRejectedExecutionHandler(new ThreadPoolExecutor.AbortPolicy());
        taskExecutor.initialize(); //数据初始化
        logger.debug("=====>>>>taskExecutor init");
        return taskExecutor;
    }

    @Override
    public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler() {
        return AsyncConfigurer.super.getAsyncUncaughtExceptionHandler();
    }
}
