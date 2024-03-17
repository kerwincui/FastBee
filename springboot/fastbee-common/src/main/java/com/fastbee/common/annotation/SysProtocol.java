package com.fastbee.common.annotation;

import java.lang.annotation.*;

/**
 * 表示系统内部协议解析器
 * @author gsb
 * @date 2022/10/24 10:33
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface SysProtocol {

    /*协议名*/
    String name() default "";
    /*协议编码*/
    String protocolCode() default "";
    //协议描述
    String description() default "";
}
