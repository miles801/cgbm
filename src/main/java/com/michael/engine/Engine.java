package com.michael.engine;

import com.michael.utils.FileUtils;
import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * 代码生成器引擎，持有一个或多个任务，然后生成对应的文件
 *
 * @author Michael
 */
public class Engine {
    private Logger logger = Logger.getLogger(Engine.class);
    private List<AbstractModel> models = new ArrayList<AbstractModel>();


    public void build() {
        if (models == null || models.isEmpty()) {
            logger.error("没有可执行单元!");
            return;
        }
        Configuration configuration = new Configuration();
        String templateName = "templateName";
        for (AbstractModel model : models) {
            StringTemplateLoader templateLoader = new StringTemplateLoader();
            String templateContent = model.getTemplateContent();
            templateLoader.putTemplate(templateName, templateContent);
            configuration.setTemplateLoader(templateLoader);
            File file = null;
            try {
                // 校验值是否完整
                check(model);

                // 创建输出文件
                Template template = configuration.getTemplate(templateName);
                String path = model.getFullPath();
                logger.info("生成文件：" + path);
                // 创建文件
                boolean result = FileUtils.createFile(path);
                if (!result) {
                    logger.error("创建文件失败!" + path);
                    continue;
                }
                template.process(model, new PrintWriter(new FileOutputStream(path)));
            } catch (IOException e) {
                e.printStackTrace();
            } catch (TemplateException e) {
                e.printStackTrace();
            }
        }
    }


    public void check(AbstractModel abstractModel) {
        Field fields[] = abstractModel.getClass().getDeclaredFields();
        for (Field field : fields) {
        }

    }

    public void setModels(List<AbstractModel> models) {
        this.models = models;
    }

    public Engine addModel(AbstractModel model) {
        if (models == null) {
            models = new ArrayList<AbstractModel>();
        }
        models.add(model);
        return this;
    }
}
