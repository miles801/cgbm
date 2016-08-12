package com.michael.code;

import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;

/**
 * @author Michael
 */
public class CodeEngine {

    /**
     * @param template     模板文件
     * @param data         数据文件
     * @param outputStream 输出流
     */
    public void generate(String template, Object data, OutputStream outputStream) {
        StringTemplateLoader templateLoader = new StringTemplateLoader();
        templateLoader.putTemplate("template", template);
        Configuration configuration = new Configuration();
        configuration.setDefaultEncoding("utf-8");
        String file = this.getClass().getClassLoader().getResource("").getFile();
        try {
            configuration.setDirectoryForTemplateLoading(new File(file));
        } catch (IOException e) {
            e.printStackTrace();
        }
        configuration.setTemplateLoader(templateLoader);
        try {
            Template t = configuration.getTemplate("template");
            t.process(data, new OutputStreamWriter(outputStream, "utf-8"));
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TemplateException e) {
            e.printStackTrace();
        }
    }
}
