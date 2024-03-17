package com.fastbee.base.core;


import com.fastbee.common.core.protocol.Message;
import com.fastbee.base.session.Session;

/**
 * 消息拦截器
 * @author bill
 */
public interface HandlerInterceptor<T extends Message> {

    /**
     * 未匹配到对应的Handle（消息处理）
     */
    T notSupported(T request, Session session);

    /**
     * 调用之前
     * 处理消息类型匹配
     */
    boolean beforeHandle(T request, Session session);

    /**
     * 需要应答设备，在这里执行
     * 调用之后，返回值为void的 */
    T successful(T request, Session session);

    /** 调用之后，有返回值的 */
    void afterHandle(T request, T response, Session session);

    /**
     * 报错应答方法
     * 调用之后抛出异常的
     */
    T exceptional(T request, Session session, Exception e);
}
