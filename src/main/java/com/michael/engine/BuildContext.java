package com.michael.engine;

import java.util.HashMap;
import java.util.Map;

/**
 * 上下文信息，需要在一开始就初始化，然后在生产完代码后清空
 *
 * @author Michael
 */
public class BuildContext {

    /**
     * 实体类名称
     */
    public static final String ENTITY_NAME = "_entityName";
    /**
     * 包名称
     */
    public static final String PACKAGE_NAME = "_packageName";
    /**
     * 表名称
     */
    public static final String TABLE_NAME = "_tableName";
    /**
     * 项目根路径
     */
    public static final String ROOT = "_root";
    /**
     * 模板名称
     */
    public static final String MODULE_NAME = "_moduleName";

    /**
     * 作者
     */
    public static final String AUTHOR = "_author";

    private static ThreadLocal<Map<String, Object>> map = new ThreadLocal<Map<String, Object>>();

    /**
     * @param key 该值来自原当前类的常量,也可以自定义一些key
     */
    public static void put(String key, Object value) {
        Map<String, Object> foo = map.get();
        if (foo == null) {
            foo = new HashMap<String, Object>();
            map.set(foo);
        }
        map.get().put(key, value);
    }


    /**
     * 获取值
     * 如果key不存在则返回一个空字符串（方便获取值）
     *
     * @param key 该类的常量
     */
    public static Object get(String key) {
        Map<String, Object> foo = map.get();
        if (foo == null || foo.isEmpty()) {
            return null;
        }
        Object o = foo.get(key);
        return o == null ? "" : o;
    }

    public static void remove(String key) {
        if (map.get() != null) {
            map.get().remove(key);
        }
    }

    public static void clear() {
        map.remove();
    }
}
