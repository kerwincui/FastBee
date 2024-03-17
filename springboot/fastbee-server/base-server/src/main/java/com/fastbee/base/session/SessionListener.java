package com.fastbee.base.session;

/**
 * session监听
 * @author gsb
 * @date 2022/11/7 8:57
 */

public interface SessionListener {

    /** 客户端建立连接 */
    default void sessionCreated(Session session) {

    }

    /** 客户端完成注册或鉴权 */
    default void sessionRegistered(Session session) {
    }

    /**
     * 客户端注销或离线
     */
    default void sessionDestroyed(Session session) {

    }
}
