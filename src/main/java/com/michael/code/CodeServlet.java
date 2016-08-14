package com.michael.code;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.michael.utils.StringUtils;
import com.michael.utils.TemplateUtils;
import org.apache.commons.io.IOUtils;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.InvalidParameterException;
import java.util.*;

/**
 * @author Michael
 */
@WebServlet(name = "code", urlPatterns = "/code")
public class CodeServlet extends HttpServlet {

    public CodeServlet() {
        System.out.println("代码生成器Servlet初始化成功!。。。。。。。。。。。");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BeanConfig beanConfig = wrapDataToEntity(req, BeanConfig.class);
        CodeEngine engine = new CodeEngine();
        List<String> items = beanConfig.getItems();
        // 导入
        if (beanConfig.isImportData()) {
            items.add("import");
            items.add("import_js");
        }
        for (String item : items) {
            // entity
            engine.generate(TemplateUtils.loadTemplate("template/" + item + ".ftl"), beanConfig, getFile(beanConfig, item));
        }
        System.out.println("文件生成完毕.....");
    }

    private FileOutputStream getFile(BeanConfig config, String type) throws FileNotFoundException {
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
        } else if ("dto".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-api/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/dto/" + entity + "DTO.java";
        } else if ("dao".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-api/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/dao/" + entity + "Dao.java";
        } else if ("dao_impl".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-impl/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/dao/impl/" + entity + "DaoImpl.java";
        } else if ("service".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-api/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/service/" + entity + "Service.java";
        } else if ("service_impl".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-impl/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/service/impl/" + entity + "ServiceImpl.java";
        } else if ("ctrl".equals(type)) {
            path += "/eccrm-" + module + "/" + module + "-web/src/main/java/" + packagePath.replaceAll("\\.", "/") + "/web/" + entity + "Ctrl.java";
        } else {
            // 前台部分
            path += "/web/src/main/webapp/app/" + module + "/" + module2 + "/";
            if ("js_root".equals(type)) {
                path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + ".js";
            } else if ("list".equals(type)) {
                path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + "_list.jsp";
            } else if ("list_js".equals(type)) {
                path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + "_list.js";
            } else if ("edit".equals(type)) {
                path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + "_edit.jsp";
            } else if ("edit_js".equals(type)) {
                path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + "_edit.js";
            } else if ("import".equals(type)) {
                path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + "_import.jsp";
            } else if ("import_js".equals(type)) {
                path += StringUtils.lowerCaseFirst(entity) + "/" + StringUtils.lowerCaseFirst(entity) + "_import.js";
            }
        }
        if (!config.isLevel()) {
            path = path.replaceAll(module + "-[a-z]{3,4}/", "");
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

    private static <T> T wrapDataToEntity(HttpServletRequest request, Class<T> clazz, String... excludeFields) {
        if (request == null || clazz == null) {
            throw new InvalidParameterException("参数不能为空！");
        }

        // 创建gson对象
        GsonBuilder builder = new GsonBuilder();

        Gson gson = builder.create();

        // 根据请求类型分别解析
        String method = request.getMethod();
        String data = null;
        try {
            // 从流中获取数据
            ServletInputStream inputStream = request.getInputStream();
            if (inputStream != null) {
                data = IOUtils.toString(inputStream, "utf-8");
            }
            if (inputStream == null || StringUtils.isEmpty(data)) {
                Enumeration<String> enumeration = request.getParameterNames();
                JsonObject jsonObject = new JsonObject();
                while (enumeration.hasMoreElements()) {
                    String key = enumeration.nextElement();
                    if (excludeFields != null && Arrays.binarySearch(excludeFields, key) != -1) {
                        continue;
                    }
                    String value = request.getParameter(key);
                    if (value != null) {
                        jsonObject.addProperty(key, StringUtils.decodeByUTF8(value));
                    }
                }
                return gson.fromJson(jsonObject, clazz);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (data == null) {
            return null;
        }

        //空对象和空集合不进行转换
        data = data.replaceAll("(:\\[\\])|(:\\{\\})", ":null");
        return gson.fromJson(data, clazz);
    }
}
