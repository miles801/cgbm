package com.michael.annotation;

/**
 * @author Michael
 */
public @interface Options {

    /**
     * 类型
     */
    Type type() default Type.TEXT;

    String name();

    boolean required() default false;

    /**
     * 只有在类型为Type.SELECT和CHECKBOX时才有效
     */
    String[] values();

    /**
     * 引用：表示该值来自于上下文Context中指定的名称的变量
     */
    InnerVariable reference();

}
