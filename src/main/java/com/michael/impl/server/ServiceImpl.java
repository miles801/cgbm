package com.michael.impl.server;

import com.michael.engine.AbstractModel;
import com.michael.engine.BuildContext;
import com.michael.utils.StringUtils;
import com.michael.utils.TemplateUtils;
import org.apache.log4j.Logger;

import java.io.IOException;

/**
 * @author Michael
 */
public class ServiceImpl extends AbstractModel {

    private Logger logger = Logger.getLogger(ServiceImpl.class);

    @Override
    public String getTemplateContent() {
        String templateFile = "/template/server/service_impl.ftl";
        try {
            return TemplateUtils.loadTemplate(templateFile);
        } catch (IOException e) {
            logger.error("读取模板[" + templateFile + "]失败!");
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public String getFullPath() {
        String root = BuildContext.get(BuildContext.ROOT).toString();
        String module = BuildContext.get(BuildContext.MODULE_NAME).toString();
        String packageName = BuildContext.get(BuildContext.PACKAGE_NAME).toString();
        String path = StringUtils.addSuffix(root, "/") + "eccrm-" + module + "/" + module + "-impl/src/main/java/" + packageName.replaceAll("\\.", "/") + "/service/impl/" + getFileName();
        return path;
    }

    @Override
    public String getFileName() {
        return BuildContext.get(BuildContext.ENTITY_NAME) + "ServiceImpl.java";
    }

}