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
 * 实体类
 *
 * @author Michael
 */
public class Domain extends AbstractModel {

    private Logger logger = Logger.getLogger(Domain.class);

    /**
     * 实体类的描述
     */
    private String description;

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String getTemplateContent() {
        String templateFile = "/template/server/domain.ftl";
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
        String path = StringUtils.addSuffix(root, "/") + "eccrm-" + module + "/" + module + "-api/src/main/java/" + packageName.replaceAll("\\.", "/") + "/domain/" + getFileName();
        return path;
    }

    @Override
    public String getFileName() {
        return BuildContext.get(BuildContext.ENTITY_NAME) + ".java";
    }

}
