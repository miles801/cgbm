package com.michael.utils;

import com.google.gson.Gson;
import com.michael.code.BeanConfig;
import com.michael.code.CodeEngine;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * @author Michael
 */
public class Test {
    public static void main(String[] args) throws IOException {
        String json = "{\"name\":\"问卷\",\"project\":\"d:/workspace/lr/\",\"module\":\"itsm\",\"module2\":\"survey\",\"entity\":\"Subject\",\"table\":\"itms_subject\",\"attachment\":true,\"delete\":false,\"tree\":false,\"modal\":false,\"packPath\":\"eccrm.survey.questionbank\",\"author\":\"Michael\",\"fields\":[{\"edit\":true,\"condition\":true,\"length\":\"100\",\"list\":true,\"name\":\"标题\",\"field\":\"title\",\"require\":true,\"type\":\"String\",\"type2\":\"text2\"},{\"edit\":true,\"condition\":false,\"length\":\"1000\",\"list\":false,\"field\":\"description\",\"name\":\"描述\",\"type\":\"String\",\"type2\":\"textarea\"},{\"edit\":true,\"field\":\"content\",\"condition\":false,\"length\":\"1000\",\"list\":false,\"name\":\"内容\",\"require\":true,\"type\":\"String\",\"type2\":\"textarea\"}]}";
        Gson gson = new Gson();
        BeanConfig beanConfig = gson.fromJson(json, BeanConfig.class);
        CodeEngine engine = new CodeEngine();
        // entity
        engine.generate(TemplateUtils.loadTemplate("template/domain.ftl"), beanConfig, getFile(beanConfig, "entity"));
        // bo
        engine.generate(TemplateUtils.loadTemplate("template/bo.ftl"), beanConfig, getFile(beanConfig, "bo"));
        // service
        engine.generate(TemplateUtils.loadTemplate("template/service.ftl"), beanConfig, getFile(beanConfig, "service"));
        // serviceImpl
        engine.generate(TemplateUtils.loadTemplate("template/service_impl.ftl"), beanConfig, getFile(beanConfig, "serviceImpl"));
        // dao
        engine.generate(TemplateUtils.loadTemplate("template/dao.ftl"), beanConfig, getFile(beanConfig, "dao"));
        // daoImpl
        engine.generate(TemplateUtils.loadTemplate("template/dao_impl.ftl"), beanConfig, getFile(beanConfig, "daoImpl"));
        // vo
        engine.generate(TemplateUtils.loadTemplate("template/vo.ftl"), beanConfig, getFile(beanConfig, "vo"));
        // ctrl
        engine.generate(TemplateUtils.loadTemplate("template/ctrl.ftl"), beanConfig, getFile(beanConfig, "ctrl"));

        // js
        engine.generate(TemplateUtils.loadTemplate("template/js_root.ftl"), beanConfig, getFile(beanConfig, "js"));
        // list.jsp
        engine.generate(TemplateUtils.loadTemplate("template/list_page.ftl"), beanConfig, getFile(beanConfig, "list"));
        // list.js
        engine.generate(TemplateUtils.loadTemplate("template/list_js.ftl"), beanConfig, getFile(beanConfig, "list_js"));
        // edit.jsp
        engine.generate(TemplateUtils.loadTemplate("template/edit_page.ftl"), beanConfig, getFile(beanConfig, "edit"));
        // edit.js
        engine.generate(TemplateUtils.loadTemplate("template/edit_js.ftl"), beanConfig, getFile(beanConfig, "edit_js"));

    }

    private static FileOutputStream getFile(BeanConfig config, String type) throws FileNotFoundException {
        String path = config.getProject();
        String module = config.getModule();
        String module2 = config.getModule2();
        String packagePath = config.getPackPath();
        String entity = config.getEntity();

        // 后台部分
        if ("entity".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-api/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/domain/" + entity + ".java";
        } else if ("bo".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-api/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/bo/" + entity + "Bo.java";
        } else if ("vo".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-api/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/vo/" + entity + "Vo.java";
        } else if ("dao".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-api/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/dao/" + entity + "Dao.java";
        } else if ("daoImpl".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-impl/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/dao/impl/" + entity + "DaoImpl.java";
        } else if ("service".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-api/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/service/" + entity + "Service.java";
        } else if ("serviceImpl".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-impl/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/service/impl/" + entity + "ServiceImpl.java";
        } else if ("ctrl".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-web/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/web/" + entity + "Ctrl.java";
        }

        // 前台部分
        if ("js".equals(type)) {
            path += "/webapp/app/" + module + "/";
            if (StringUtils.isNotEmpty(module2)) {
                path += module2 + "/";
            }
            path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + ".js";
        } else if ("list".equals(type)) {
            path += "/webapp/app/" + module + "/";
            if (StringUtils.isNotEmpty(module2)) {
                path += module2 + "/";
            }
            path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + "_list.jsp";
        } else if ("list_js".equals(type)) {
            path += "/webapp/app/" + module + "/";
            if (StringUtils.isNotEmpty(module2)) {
                path += module2 + "/";
            }
            path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + "_list.js";
        } else if ("edit".equals(type)) {
            path += "/webapp/app/" + module + "/";
            if (StringUtils.isNotEmpty(module2)) {
                path += module2 + "/";
            }
            path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + "_edit.jsp";
        } else if ("edit_js".equals(type)) {
            path += "/webapp/app/" + module + "/";
            if (StringUtils.isNotEmpty(module2)) {
                path += module2 + "/";
            }
            path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + "_edit.js";
        }

        File file = new File(path);
        if (!file.exists()) {
            try {
                File parent = file.getParentFile();
                if (!parent.exists()) {
                    parent.mkdirs();
                }
                boolean result = file.createNewFile();
                System.out.println("创建文件:" + path + "-->" + result);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("覆盖文件:" + path);
        }
        return new FileOutputStream(file);
    }

}
