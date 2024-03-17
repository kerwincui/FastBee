package com.fastbee.base.core.annotation;

import java.lang.annotation.*;

/**
 * 多线程异步处理设备数据，新建线程组处理
 *
 * @author bill
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AsyncBatch {

    /*批量处理的最大消息数*/
    int maxMessageSize() default 5000;

    /*线程数*/
    int poolSize() default 2;

    /*最大等待时间*/
    int maxWaitTime() default 1000;

    /*最小处理消息数*/
    int minMessageSize() default 100;

}
