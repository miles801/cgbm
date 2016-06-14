package com.michael.annotation;

import java.lang.annotation.*;

/**
 * @author Michael
 */
@Documented
@Retention(value = RetentionPolicy.RUNTIME)
@Target(value = ElementType.FIELD)
public @interface Module {
    /**
     * 模块名称
     */
    String name();

    /**
     * 模块描述：页面展示用
     */
    String description();
}
