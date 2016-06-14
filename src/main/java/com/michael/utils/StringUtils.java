package com.michael.utils;

/**
 * @author Michael
 */
public class StringUtils {

    /**
     * 将字符串的首字母变为小写
     */
    public static String lowerCamel(String string) {
        if (string == null) {
            return null;
        }
        if (string.length() == 1) {
            return string.toLowerCase();
        }
        return string.substring(0, 1).toLowerCase() + string.substring(1);
    }


    /**
     * 将字符串的首字母变为大写
     */
    public static String upperCamel(String string) {
        if (string == null) {
            return null;
        }
        if (string.length() == 1) {
            return string.toUpperCase();
        }
        return string.substring(0, 1).toUpperCase() + string.substring(1);
    }

    public static boolean isBlank(String string) {
        return string == null || "".equals(string.trim());
    }

    public static boolean isNotBlank(String string) {
        return !isBlank(string);
    }

    /**
     * 给指定的字符串加上前缀
     * 如果字符串已经有该前缀，则直接返回
     *
     * @param str    原字符串
     * @param prefix 前缀
     * @return 新字符串
     */
    public static String addPrefix(String str, String prefix) {
        if (isBlank(str) || isBlank(prefix)) {
            return str;
        }
        if (str.startsWith(prefix)) {
            return str;
        }
        return prefix + str;
    }

    /**
     * 给指定的字符串加上后缀
     * 如果字符串已经有该后缀，则直接返回
     *
     * @param str    原字符串
     * @param suffix 后缀
     * @return 新字符串
     */
    public static String addSuffix(String str, String suffix) {
        if (isBlank(str) || isBlank(suffix)) {
            return str;
        }
        if (str.endsWith(suffix)) {
            return str;
        }
        return str + suffix;
    }

}
