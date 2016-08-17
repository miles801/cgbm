package ${packPath}.web;

import com.ycrl.core.web.BaseController;
import com.ycrl.base.common.JspAccessType;
import com.ycrl.core.pager.PageVo;
import com.ycrl.utils.gson.GsonUtils;
import ${packPath}.bo.${entity}Bo;
import ${packPath}.domain.${entity};
import ${packPath}.service.${entity}Service;
import ${packPath}.vo.${entity}Vo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
<#if export>
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.ycrl.utils.gson.DateStringConverter;
import com.michael.poi.exp.ExportEngine;
import org.apache.commons.io.IOUtils;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
</#if>
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * <#if author??>@author ${author}</#if>
 */
@Controller
@RequestMapping(value = {"/${module}/${module2}/${entity?uncap_first}"})
public class ${entity}Ctrl extends BaseController {
    @Resource
    private ${entity}Service ${entity?uncap_first}Service;


    @RequestMapping(value = {""}, method=RequestMethod.GET )
    public String toList() {
        return "${module}/${module2}/${entity?uncap_first}/${entity?uncap_first}_list";
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String toAdd(HttpServletRequest request) {
        request.setAttribute(JspAccessType.PAGE_TYPE, JspAccessType.ADD);
        return "${module}/${module2}/${entity?uncap_first}/${entity?uncap_first}_edit";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public void save(HttpServletRequest request, HttpServletResponse response) {
        ${entity} ${entity?uncap_first} = GsonUtils.wrapDataToEntity(request, ${entity}.class);
        ${entity?uncap_first}Service.save(${entity?uncap_first});
        GsonUtils.printSuccess(response);
    }

    @RequestMapping(value = "/modify", params = {"id"}, method = RequestMethod.GET)
    public String toModify(@RequestParam String id, HttpServletRequest request) {
        request.setAttribute(JspAccessType.PAGE_TYPE, JspAccessType.MODIFY);
        request.setAttribute("id", id);
        return "${module}/${module2}/${entity?uncap_first}/${entity?uncap_first}_edit";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public void update(HttpServletRequest request, HttpServletResponse response) {
        ${entity} ${entity?uncap_first} = GsonUtils.wrapDataToEntity(request, ${entity}.class);
        ${entity?uncap_first}Service.update(${entity?uncap_first});
        GsonUtils.printSuccess(response);
    }

    @RequestMapping(value = {"/detail"}, params = {"id"}, method = RequestMethod.GET)
    public String toDetail(@RequestParam String id, HttpServletRequest request) {
        request.setAttribute(JspAccessType.PAGE_TYPE, JspAccessType.DETAIL);
        request.setAttribute("id", id);
        return "${module}/${module2}/${entity?uncap_first}/${entity?uncap_first}_edit";
    }

    @ResponseBody
    @RequestMapping(value = "/get", params = {"id"}, method = RequestMethod.GET)
    public void findById(@RequestParam String id, HttpServletResponse response) {
        ${entity}Vo vo = ${entity?uncap_first}Service.findById(id);
        GsonUtils.printData(response, vo);
    }

    @ResponseBody
    @RequestMapping(value = "/pageQuery", method = RequestMethod.POST)
    public void pageQuery(HttpServletRequest request, HttpServletResponse response) {
        ${entity}Bo bo = GsonUtils.wrapDataToEntity(request, ${entity}Bo.class);
        PageVo pageVo = ${entity?uncap_first}Service.pageQuery(bo);
        GsonUtils.printData(response, pageVo);
    }

    @ResponseBody
    @RequestMapping(value = "/query", method = RequestMethod.POST)
    public void query(HttpServletRequest request, HttpServletResponse response) {
        ${entity}Bo bo = GsonUtils.wrapDataToEntity(request, ${entity}Bo.class);
        List<${entity}Vo> vos = ${entity?uncap_first}Service.query(bo);
        GsonUtils.printData(response, vos);
    }

    <#if !deleted>
    @ResponseBody
    @RequestMapping(value = "/enable", params = {"ids"}, method = RequestMethod.POST)
        public void enable(@RequestParam String ids, HttpServletResponse response) {
        String[] idArr = ids.split(",");
        ${entity?uncap_first}Service.enable(idArr);
        GsonUtils.printSuccess(response);
    }

    @ResponseBody
    @RequestMapping(value = "/disable", params = {"ids"}, method = RequestMethod.POST)
        public void disable(@RequestParam String ids, HttpServletResponse response) {
        String[] idArr = ids.split(",");
        ${entity?uncap_first}Service.disable(idArr);
        GsonUtils.printSuccess(response);
    }

    // 查询所有有效的数据，不使用分页
    @ResponseBody
    @RequestMapping(value = "/query-valid", method = RequestMethod.POST)
    public void queryValid(HttpServletRequest request, HttpServletResponse response) {
        ${entity}Bo bo = GsonUtils.wrapDataToEntity(request, ${entity}Bo.class);
        List<${entity}> data = ${entity?uncap_first}Service.queryValid(bo);
        GsonUtils.printData(response, data);
    }

    </#if>
    @ResponseBody
    @RequestMapping(value = "/delete", params = {"ids"}, method = RequestMethod.DELETE)
    public void deleteByIds(@RequestParam String ids, HttpServletResponse response) {
        String[] idArr = ids.split(",");
        ${entity?uncap_first}Service.deleteByIds(idArr);
        GsonUtils.printSuccess(response);
    }

    <#if export>
    // 导出数据
    @RequestMapping(value = "/export", method = RequestMethod.GET)
    public String export(HttpServletRequest request, HttpServletResponse response) {
        Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new DateStringConverter("yyyy-MM-dd HH:mm:ss"))
            .create();
        ${entity}Bo bo = GsonUtils.wrapDataToEntity(request, ${entity}Bo.class);
        List<${entity}Vo> data = ${entity?uncap_first}Service.query(bo);
        String json = gson.toJson(data);
        JsonElement element = gson.fromJson(json, JsonElement.class);
        JsonObject o = new JsonObject();
        o.add("c", element);
        String disposition = null;//
        try {
            disposition = "attachment;filename=" + URLEncoder.encode("${name}数据"+new SimpleDateFormat("yyyyMMdd").format(new Date())+".xlsx", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition", disposition);
        try {
            new ExportEngine().export(response.getOutputStream(), this.getClass().getClassLoader().getResourceAsStream("export_${entity?uncap_first}.xlsx"), o);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


    // 下载模板
    @ResponseBody
    @RequestMapping(value = "/template", method = RequestMethod.GET)
    public void downloadTemplate(HttpServletResponse response) {
        InputStream input = ${entity}Ctrl.class.getClassLoader().getResourceAsStream("import_${entity?uncap_first}.xlsx");
        Assert.notNull(input, "模板下载失败!${name}数据导入模板不存在!");
        response.setContentType("application/vnd.ms-excel");
        String disposition = null;//
        try {
            disposition = "attachment;filename=" + URLEncoder.encode("${name}数据导入模板.xlsx", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-disposition", disposition);
        try {
            IOUtils.copy(input, response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    </#if>

    <#if importData>
    // 跳转到导入页面
    @RequestMapping(value = "/import", method = RequestMethod.GET)
    public String toImport(HttpServletRequest request) {
        return "${module}/${module2}/${entity?uncap_first}/${entity?uncap_first}_import";
    }

    // 执行导入
    @ResponseBody
    @RequestMapping(value = "/import", params = {"attachmentIds"}, method = RequestMethod.POST)
    public void importData(@RequestParam String attachmentIds, HttpServletResponse response) {
        ${entity?uncap_first}Service.importData(attachmentIds.split(","));
        GsonUtils.printSuccess(response);
    }
    </#if>
}
