package com.fastbee.framework.mybatis.config;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.fastbee.common.core.domain.model.LoginUser;
import com.fastbee.common.utils.SecurityUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.util.ClassUtils;

import java.nio.charset.Charset;
import java.util.Date;

/**
 * MybatisPlus 自动填充配置
 *
 * @author admin
 */
@Slf4j
public class MybatisPlusMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        log.debug("mybatisPlus插入填充--------------");
        Date date = new Date();

        fillValIfNullByName("createTime", date, metaObject, false);
        fillValIfNullByName("updateTime", date, metaObject, false);
        fillValIfNullByName("createBy", getUserName(), metaObject, false);
        fillValIfNullByName("updateBy", getUserName(), metaObject, false);
        fillValIfNullByName("deleteFlag", "1", metaObject, false);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        log.debug("mybatisPlus更新填充--------------");
        fillValIfNullByName("updateTime", new Date(), metaObject, true);
        fillValIfNullByName("updateBy", getUserName(), metaObject, true);
    }

    /**
     * 填充值，先判断是否有手动设置，优先手动设置的值，例如：job必须手动设置
     * @param fieldName 属性名
     * @param fieldVal 属性值
     * @param metaObject MetaObject
     * @param isCover 是否覆盖原有值,避免更新操作手动入参
     */
    private static void fillValIfNullByName(String fieldName, Object fieldVal, MetaObject metaObject, boolean isCover) {
        // 1. 没有 get 方法
        if (!metaObject.hasSetter(fieldName)) {
            return;
        }
        // 2. 如果用户有手动设置的值
        Object userSetValue = metaObject.getValue(fieldName);
        String setValueStr = StrUtil.str(userSetValue, Charset.defaultCharset());
        if (StrUtil.isNotBlank(setValueStr) && !isCover) {
            return;
        }
        // 3. field 类型相同时设置
        Class<?> getterType = metaObject.getGetterType(fieldName);
        if (ClassUtils.isAssignableValue(getterType, fieldVal)) {
            metaObject.setValue(fieldName, fieldVal);
        }
    }

    /**
     * 获取 spring security 当前的用户名
     * @return 当前用户名
     */
    private String getUserName() {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        return loginUser.getUsername();
    }

}
