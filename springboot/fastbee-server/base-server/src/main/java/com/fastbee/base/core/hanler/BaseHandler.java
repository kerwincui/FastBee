package com.fastbee.base.core.hanler;

import com.fastbee.common.core.protocol.Message;
import com.fastbee.base.session.Session;

import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Collection;

/**
 * 基础处理类
 *
 * @author bill
 */
public abstract class BaseHandler {

    public static final int MESSAGE = 0;
    public static final int SESSION = 1;

    public final Object targetObject;
    public final Method targetMethod;
    public final int[] parameterTypes;
    public final boolean returnVoid;
    public final boolean async;
    public final String desc;

    public BaseHandler(Object target, Method targetMethod, String desc) {
        this(target, targetMethod, desc, false);
    }

    public BaseHandler(Object targetObject, Method targetMethod, String desc, boolean async) {
        this.targetObject = targetObject;
        this.targetMethod = targetMethod;
        this.returnVoid = targetMethod.getReturnType().isAssignableFrom(Void.TYPE);
        this.async = async;
        if (desc == null || desc.isEmpty())
            desc = targetMethod.getName();
        this.desc = desc;

        Type[] types = targetMethod.getGenericParameterTypes();
        int[] parameterTypes = new int[types.length];
        try {
            for (int i = 0; i < types.length; i++) {
                Type type = types[i];
                Class<?> clazz;
                if (type instanceof ParameterizedType) {
                    ParameterizedType pt = (ParameterizedType) type;
                    // 检查是否为List/Collection等容器类型
                    if (pt.getRawType() instanceof Class &&
                            ((Class<?>) pt.getRawType()).isArray() ||
                            Collection.class.isAssignableFrom((Class<?>) pt.getRawType())) {
                        Type[] actualTypes = pt.getActualTypeArguments();
                        if (actualTypes.length > 0) {
                            clazz = (Class<?>) actualTypes[0];
                        } else {
                            clazz = Object.class; // 默认类型
                        }
                    } else {
                        clazz = (Class<?>) pt.getRawType(); // 处理非容器类型的参数化类型
                    }
                } else {
                    clazz = (Class<?>) type;
                }

                if (Message.class.isAssignableFrom(clazz)) {
                    parameterTypes[i] = MESSAGE;
                } else if (Session.class.isAssignableFrom(clazz)) {
                    parameterTypes[i] = SESSION;
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        this.parameterTypes = parameterTypes;
    }

    public <T extends Message> T invoke(T request, Session session) throws Exception {
        Object[] args = new Object[parameterTypes.length];

        for (int i = 0; i < parameterTypes.length; i++) {
            int type = parameterTypes[i];
            switch (type) {
                case BaseHandler.MESSAGE:
                    args[i] = request;
                    break;
                case BaseHandler.SESSION:
                    args[i] = session;
                    break;
            }
        }
        return (T) targetMethod.invoke(targetObject, args);
    }

    @Override
    public String toString() {
        return desc;
    }
}
