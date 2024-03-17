package com.fastbee.base.service.impl;

import com.fastbee.base.service.ISessionStore;
import com.fastbee.base.session.Session;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 内存存储服务会话
 *
 * @author gsb
 * @date 2022/10/14 14:18
 */
@Service
public class SessionStoreImpl implements ISessionStore {

    /*session存储集合*/
    private final ConcurrentHashMap<String, Session> sessionMap = new ConcurrentHashMap<>();

    /**
     * MQTT会话存储
     *
     * @param clientId:    客户端标识
     * @param session: MQTT会话
     */
    @Override
    public void storeSession(String clientId, Session session) {
        sessionMap.put(clientId, session);
    }

    /**
     * 根据客户端标识获取相应会话
     *
     * @param clientId: 客户端标识
     */
    @Override
    public Session getSession(String clientId) {
        return sessionMap.get(clientId);
    }

    /**
     * 清除历史会话状态
     *
     * @param clientId: 客户端标识
     */
    @Override
    public void cleanSession(String clientId) {
        sessionMap.remove(clientId);
    }

    /**
     * 根据客户端标识查看是否存在该会话
     *
     * @param clientId:
     */
    @Override
    public boolean containsKey(String clientId) {
        return sessionMap.containsKey(clientId);
    }

    /**
     * 获取集合
     * @return MAP
     */
    @Override
    public ConcurrentHashMap<String, Session> getSessionMap(){
        return sessionMap;
    }


    /**
     * map分页（从1开始）
     *
     * @param sourceMap 分页数据
     * @param pageSize     页面大小
     * @param currentPage  当前页面
     */
    @Override
    public  Map<String, Session> listPage(Map<String, Session> sourceMap, int pageSize, int currentPage) {
        Map<String, Session> map = new LinkedHashMap<>();
        if (sourceMap.size() > 0) {
            AtomicInteger flag = new AtomicInteger(0);
            AtomicInteger size = new AtomicInteger(0);
            int currIdx = (currentPage > 1  ? (currentPage - 1) * pageSize : 0);
            sourceMap.forEach((ass, list_km) -> {
                if (flag.get() >= currIdx) {
                    if (size.get() < pageSize) {
                        map.put(ass, list_km);
                    } else {
                        return;
                    }
                    size.getAndIncrement();
                }
                flag.getAndIncrement();
            });

        }
        return map;
    }
}
