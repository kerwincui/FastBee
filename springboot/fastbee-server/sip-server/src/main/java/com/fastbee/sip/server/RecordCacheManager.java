package com.fastbee.sip.server;

import com.fastbee.sip.model.RecordList;
import org.springframework.stereotype.Component;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.ReentrantLock;

@Component
public class RecordCacheManager {
    private final ConcurrentHashMap<String, RecordList> recordMap = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<String, ReentrantLock> lockMap = new ConcurrentHashMap<>();

    public  void put(String key,RecordList list){
        recordMap.putIfAbsent(key, list);
    }

    public  RecordList get(String key){
        RecordList ret = recordMap.get(key);
        if (ret == null) {
            ret = new RecordList();
            recordMap.putIfAbsent(key, ret);
        }
        return ret;
    }

    public void remove(String key) {
        recordMap.remove(key);
        lockMap.remove(key);
    }

    public void addlock(String key){
        lockMap.put(key,new ReentrantLock());
    }

    public ReentrantLock getlock(String key){
        return lockMap.get(key);
    }


}
