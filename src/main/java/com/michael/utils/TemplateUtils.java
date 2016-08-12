package com.michael.utils;

import org.apache.commons.io.IOUtils;

import java.io.IOException;
import java.io.InputStream;

/**
 * @author Michael
 */
public class TemplateUtils {

    /**
     * 从类路径下加载指定名称的模板，并返回模板内容
     *
     * @param path 类路径
     * @return 模板内容
     * @throws IOException
     */
    public static String loadTemplate(String path) throws IOException {
        InputStream resourceAsStream = TemplateUtils.class.getClassLoader().getResourceAsStream(path);
        if (resourceAsStream == null) {
            throw new RuntimeException("资源[" + path + "]不存在!");
        }
        return IOUtils.toString(resourceAsStream, "utf-8");
    }
}
