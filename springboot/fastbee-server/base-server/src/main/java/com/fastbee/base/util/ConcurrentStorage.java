package com.fastbee.base.util;

import lombok.Data;

import java.util.concurrent.ConcurrentHashMap;

/**
 * concurrentMap存储类
 * @author bill
 */
@Data
public abstract class ConcurrentStorage<K,V> implements Storage<K,V>{

    private volatile ConcurrentHashMap<K,V> map;

    public ConcurrentStorage(){
        this(new ConcurrentHashMap<K,V>());
    }

    public ConcurrentStorage(ConcurrentHashMap<K,V> map){
        this.map = map;
    }


    @Override
    public V push(K key, V value) {
        return map.put(key,value);
    }

    @Override
    public V pop(K key) {
        return map.get(key);
    }

    @Override
    public V remove(K key) {
        return map.remove(key);
    }

    @Override
    public boolean isContains(Object key) {
        return map.containsKey(key);
    }

    @Override
    public Object getStorage() {
        return this.map;
    }


}
