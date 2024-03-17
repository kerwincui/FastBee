package com.fastbee.base.core.annotation;

import java.lang.annotation.*;

/**
 * 异步处理设备数据
 *
 * @author bill
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Async {

}
