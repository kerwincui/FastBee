package com.fastbee.base.core;

import com.fastbee.base.core.annotation.Node;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import java.util.Map;

/**
 *
 * @author bill
 */
public class SpringHandlerMapping extends AbstractHandlerMapping implements ApplicationContextAware {

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        Map<String, Object> endpoints = applicationContext.getBeansWithAnnotation(Node.class);
        for (Object bean : endpoints.values()) {
            super.registerHandlers(bean);
        }
    }
}
