package com.fastbee.base.service;


import com.fastbee.base.session.Session;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


/**
 * 服务会话存储接口
 * @author gsb
 * @date 2022/10/14 14:16
 */
public interface ISessionStore {
    /**
     * session 会话存储
     *
     * @param clientId:    客户端标识
     * @param session: session会话

     */
    void storeSession(String clientId, Session session);

    /**
     * 根据客户端标识获取相应会话
     *
     * @param clientId: 客户端标识
     */
    Session getSession(String clientId);

    /**
     * 清除历史会话状态
     *
     * @param clientId: 客户端标识
     */
    void cleanSession(String clientId);

    /**
     * 根据客户端标识查看是否存在该会话
     *
     * @param clientId:
     */
    boolean containsKey(String clientId);

    /**
     * 获取集合
     * @return MAP
     */
    ConcurrentHashMap<String, Session> getSessionMap();

    /**
     * map分页（从1开始）
     *
     * @param sourceMap 分页数据
     * @param pageSize     页面大小
     * @param currentPage  当前页面
     */
    public  Map<String, Session> listPage(Map<String, Session> sourceMap, int pageSize, int currentPage);
}
