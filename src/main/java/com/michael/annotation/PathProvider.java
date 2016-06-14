package com.michael.annotation;

/**
 * @author Michael
 */
public interface PathProvider {
    /**
     * 获得路径（不包含根路径，以/开头）
     */
    String getPath();
}
