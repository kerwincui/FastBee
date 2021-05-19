/*
 * Copyright (C) 2021 xuexiangjys(xuexiangjys@163.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package com.kerwin.wumei.utils;


import android.content.Context;
import android.os.Parcelable;

import com.tencent.mmkv.MMKV;

import java.util.Set;

/**
 * MMKV工具类
 *
 * @author xuexiang
 * @since 2019-07-04 10:20
 */
public final class MMKVUtils {

    private MMKVUtils() {
        throw new UnsupportedOperationException("u can't instantiate me...");
    }

    private static MMKV sMMKV;

    /**
     * 初始化
     *
     * @param context
     */
    public static void init(Context context) {
        MMKV.initialize(context.getApplicationContext());
        sMMKV = MMKV.defaultMMKV();
    }

    public static MMKV getsMMKV() {
        if (sMMKV == null) {
            sMMKV = MMKV.defaultMMKV();
        }
        return sMMKV;
    }

    //=======================================键值保存==================================================//

    /**
     * 保存键值
     *
     * @param key
     * @param value
     * @return
     */
    public static boolean put(String key, Object value) {
        if (value instanceof Integer) {
            return getsMMKV().encode(key, (Integer) value);
        } else if (value instanceof Float) {
            return getsMMKV().encode(key, (Float) value);
        } else if (value instanceof String) {
            return getsMMKV().encode(key, (String) value);
        } else if (value instanceof Boolean) {
            return getsMMKV().encode(key, (Boolean) value);
        } else if (value instanceof Long) {
            return getsMMKV().encode(key, (Long) value);
        } else if (value instanceof Double) {
            return getsMMKV().encode(key, (Double) value);
        } else if (value instanceof Parcelable) {
            return getsMMKV().encode(key, (Parcelable) value);
        } else if (value instanceof byte[]) {
            return getsMMKV().encode(key, (byte[]) value);
        } else if (value instanceof Set) {
            return getsMMKV().encode(key, (Set<String>) value);
        }
        return false;
    }


    //=======================================键值获取==================================================//

    /**
     * 获取键值
     *
     * @param key
     * @param defaultValue
     * @return
     */
    public static Object get(String key, Object defaultValue) {
        if (defaultValue instanceof Integer) {
            return getsMMKV().decodeInt(key, (Integer) defaultValue);
        } else if (defaultValue instanceof Float) {
            return getsMMKV().decodeFloat(key, (Float) defaultValue);
        } else if (defaultValue instanceof String) {
            return getsMMKV().decodeString(key, (String) defaultValue);
        } else if (defaultValue instanceof Boolean) {
            return getsMMKV().decodeBool(key, (Boolean) defaultValue);
        } else if (defaultValue instanceof Long) {
            return getsMMKV().decodeLong(key, (Long) defaultValue);
        } else if (defaultValue instanceof Double) {
            return getsMMKV().decodeDouble(key, (Double) defaultValue);
        } else if (defaultValue instanceof byte[]) {
            return getsMMKV().decodeBytes(key);
        } else if (defaultValue instanceof Set) {
            return getsMMKV().decodeStringSet(key, (Set<String>) defaultValue);
        }
        return null;
    }


    /**
     * 根据key获取boolean值
     *
     * @param key
     * @param defValue
     * @return
     */
    public static boolean getBoolean(String key, boolean defValue) {
        try {
            return getsMMKV().getBoolean(key, defValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defValue;
    }

    /**
     * 根据key获取long值
     *
     * @param key
     * @param defValue
     * @return
     */
    public static long getLong(String key, long defValue) {
        try {
            return getsMMKV().getLong(key, defValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defValue;
    }

    /**
     * 根据key获取float值
     *
     * @param key
     * @param defValue
     * @return
     */
    public static float getFloat(String key, float defValue) {
        try {
            return getsMMKV().getFloat(key, defValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defValue;
    }

    /**
     * 根据key获取String值
     *
     * @param key
     * @param defValue
     * @return
     */
    public static String getString(String key, String defValue) {
        try {
            return getsMMKV().getString(key, defValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defValue;
    }

    /**
     * 根据key获取int值
     *
     * @param key
     * @param defValue
     * @return
     */
    public static int getInt(String key, int defValue) {
        try {
            return getsMMKV().getInt(key, defValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defValue;
    }


    /**
     * 根据key获取double值
     *
     * @param key
     * @param defValue
     * @return
     */
    public static double getDouble(String key, double defValue) {
        try {
            return getsMMKV().decodeDouble(key, defValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defValue;
    }


    /**
     * 获取对象
     *
     * @param key
     * @param tClass 类型
     * @param <T>
     * @return
     */
    public static <T extends Parcelable> T getObject(String key, Class<T> tClass) {
        return getsMMKV().decodeParcelable(key, tClass);
    }

    /**
     * 获取对象
     *
     * @param key
     * @param tClass 类型
     * @param <T>
     * @return
     */
    public static <T extends Parcelable> T getObject(String key, Class<T> tClass, T defValue) {
        try {
            return getsMMKV().decodeParcelable(key, tClass, defValue);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return defValue;
    }


    /**
     * 判断键值对是否存在
     *
     * @param key 键
     * @return 键值对是否存在
     */
    public static boolean containsKey(String key) {
        return getsMMKV().containsKey(key);
    }

    /**
     * 清除指定键值对
     *
     * @param key 键
     */
    public static void remove(String key) {
        getsMMKV().remove(key).apply();
    }

}
