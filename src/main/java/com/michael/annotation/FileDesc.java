package com.michael.annotation;

/**
 * @author Michael
 */
public @interface FileDesc {
    /**
     * 文件名（含后缀）
     */
    String name();

    /**
     * 文件的生成路径（含文件名）
     * 返回的路径中，可以包含${}这样的占位符，最后将会使用内置变量进行替换
     */
    String path();

    /**
     * 如果路径是复杂的，则使用PathProvider进行获取
     */
    Class<? extends PathProvider> provider();

    /**
     * 模板文件的加载路径
     */
    String templatePath();
}
