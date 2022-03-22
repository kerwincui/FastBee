package com.ruoyi.iot.task;


import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "spring.task.execution.pool")
public class TaskExecutorConfig {


    private int coreSize;

    private int maxSize;

    private int queueCapacity;

    public int getCoreSize() {
        return coreSize;
    }

    public void setCoreSize(int coreSize) {
        this.coreSize = coreSize;
    }

    public int getMaxSize() {
        return maxSize;
    }

    public void setMaxSize(int maxSize) {
        this.maxSize = maxSize;
    }

    public int getQueueCapacity() {
        return queueCapacity;
    }

    public void setQueueCapacity(int queueCapacity) {
        this.queueCapacity = queueCapacity;
    }
}
