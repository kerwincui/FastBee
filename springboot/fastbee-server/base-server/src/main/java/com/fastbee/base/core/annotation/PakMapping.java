package com.fastbee.base.core.annotation;

import java.lang.annotation.*;

/**
 * 字段映射
 * @author bill
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface PakMapping {

    int[] types();

    String desc() default "";
}
