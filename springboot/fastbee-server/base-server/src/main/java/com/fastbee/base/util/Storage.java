package com.fastbee.base.util;

/**
 * 存储管理
 * @author bill
 */
public interface Storage<K,V> {

    V push(K key, V value);

    V pop(K key);

    V remove(K key);

    boolean isContains(K key);

    Object getStorage();
}
