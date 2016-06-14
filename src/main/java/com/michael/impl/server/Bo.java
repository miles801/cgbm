package com.michael.impl.server;

import com.michael.engine.AbstractModel;
import com.michael.engine.BuildContext;
import com.michael.utils.StringUtils;
import com.michael.utils.TemplateUtils;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Michael
 */
public class Bo extends AbstractModel {
    private Logger logger = Logger.getLogger(Bo.class);

    private List<Attribute> attributes;

    public List<Attribute> getAttributes() {
        return attributes;
    }

    public void setAttributes(List<Attribute> attributes) {
        this.attributes = attributes;
    }


    public void addAttribute(Attribute attribute) {
        if (attributes == null) {
            attributes = new ArrayList<Attribute>();
        }
        attributes.add(attribute);
    }

    public void addAttribute(String name, AttributeType attributeType, String description) {
        Attribute da = new Attribute(name, attributeType.getValue(), description);
        addAttribute(da);
    }


    @Override
    public String getTemplateContent() {
        String templateFile = "/template/server/bo.ftl";
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
        String path = StringUtils.addSuffix(root, "/") + "eccrm-" + module + "/" + module + "-api/src/main/java/" + packageName.replaceAll("\\.", "/") + "/bo/" + getFileName();
        return path;
    }

    @Override
    public String getFileName() {
        return BuildContext.get(BuildContext.ENTITY_NAME) + "Bo.java";
    }

}
