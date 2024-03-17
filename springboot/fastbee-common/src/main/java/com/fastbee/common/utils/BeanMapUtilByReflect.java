package com.fastbee.common.utils;

import com.fastbee.common.core.thingsModel.ThingsModelSimpleItem;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BeanMapUtilByReflect {
 
    /**
     * 对象转Map
     * @param object
     * @return
     * @throws IllegalAccessException
     */
    public static Map beanToMap(Object object) throws IllegalAccessException {
        Map<String, Object> map = new HashMap<String, Object>();
        Field[] fields = object.getClass().getDeclaredFields();
        for (Field field : fields) {
            field.setAccessible(true);
            map.put(field.getName(), field.get(object));
        }
        return map;
    }

    /**
     * bean转item对象
     * @param object
     * @return
     * @throws IllegalAccessException
     */
    public static List<ThingsModelSimpleItem> beanToItem(Object object) throws IllegalAccessException {
        List<ThingsModelSimpleItem> result = new ArrayList<>();
        Field[] fields = object.getClass().getDeclaredFields();
        for (Field field : fields) {
            field.setAccessible(true);
            ThingsModelSimpleItem item = new ThingsModelSimpleItem();
            item.setId(field.getName());
            item.setValue(field.get(object)+"");
            item.setTs(DateUtils.getNowDate());
            result.add(item);
        }
        return result;
    }
 
    /**
     * map转对象
     * @param map
     * @param beanClass
     * @param <T>
     * @return
     * @throws Exception
     */
    public static <T> T mapToBean(Map map, Class<T> beanClass) throws Exception {
        T object = beanClass.newInstance();
        Field[] fields = object.getClass().getDeclaredFields();
        for (Field field : fields) {
            int mod = field.getModifiers();
            if (Modifier.isStatic(mod) || Modifier.isFinal(mod)) {
                continue;
            }
            field.setAccessible(true);
            if (map.containsKey(field.getName())) {
                field.set(object, map.get(field.getName()));
            }
        }
        return object;
    }
}