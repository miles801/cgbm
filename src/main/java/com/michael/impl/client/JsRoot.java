package com.michael.impl.client;

import com.michael.engine.AbstractModel;
import com.michael.engine.BuildContext;
import com.michael.utils.StringUtils;
import com.michael.utils.TemplateUtils;
import org.apache.log4j.Logger;

import java.io.IOException;

/**
 * 每个模块的根js
 *
 * @author Michael
 */
public class JsRoot extends AbstractModel {
    private Logger logger = Logger.getLogger(JsRoot.class);

    @Override
    public String getFullPath() {
        return null;
    }

    @Override
    public String getFileName() {
        return StringUtils.lowerCamel(BuildContext.get(BuildContext.ENTITY_NAME).toString());
    }

    @Override
    public String getTemplateContent() {
        String templateFile = "/template/client/js_root.ftl";
        try {
            return TemplateUtils.loadTemplate(templateFile);
        } catch (IOException e) {
            logger.error("读取模板[" + templateFile + "]失败!");
            e.printStackTrace();
        }
        return null;
    }
}
