package ${packageName}.web;

import com.ycrl.core.web.BaseController;
import com.ycrl.base.common.JspAccessType;
import com.ycrl.core.pager.PageVo;
import com.ycrl.utils.gson.GsonUtils;
import ${packageName}.bo.${className}Bo;
import ${packageName}.domain.${className};
import ${packageName}.service.${className}Service;
import ${packageName}.vo.${className}Vo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * <#if author??>@author ${author}</#if>
 */
@Controller
@RequestMapping(value = {"/${moduleName}/${className?uncap_first}"})
public class ${className}Ctrl extends BaseController {
    @Resource
    private ${className}Service ${className?uncap_first}Service;
<#if toList?? && toList==true>
    @RequestMapping(value = {""}, method=RequestMethod.GET )
    public String toList() {
        return "${moduleName}/${className?uncap_first}/list/${className?uncap_first}_list";
    }

</#if>
<#if toAdd?? && toAdd==true>
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String toAdd(HttpServletRequest request) {
        request.setAttribute(JspAccessType.PAGE_TYPE, JspAccessType.ADD);
        return "${moduleName}/${className?uncap_first}/edit/${className?uncap_first}_edit";
    }

</#if>
<#if save?? && save==true>
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public void save(HttpServletRequest request, HttpServletResponse response) {
        ${className} ${className?uncap_first} = GsonUtils.wrapDataToEntity(request, ${className}.class);
        ${className?uncap_first}Service.save(${className?uncap_first});
        GsonUtils.printSuccess(response);
    }
</#if>
<#if toModify?? && toModify==true>
    @RequestMapping(value = "/modify", params = {"id"}, method = RequestMethod.GET)
    public String toModify(@RequestParam String id, HttpServletRequest request) {
        request.setAttribute(JspAccessType.PAGE_TYPE, JspAccessType.MODIFY);
        request.setAttribute("id", id);
        return "${moduleName}/${className?uncap_first}/edit/${className?uncap_first}_edit";
    }

</#if>
<#if update?? && update==true>
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public void update(HttpServletRequest request, HttpServletResponse response) {
        ${className} ${className?uncap_first} = GsonUtils.wrapDataToEntity(request, ${className}.class);
        ${className?uncap_first}Service.update(${className?uncap_first});
        GsonUtils.printSuccess(response);
    }

</#if>
<#if toDetail?? && toDetail==true>
    @RequestMapping(value = {"/detail"}, params = {"id"}, method = RequestMethod.GET)
    public String toDetail(@RequestParam String id, HttpServletRequest request) {
        request.setAttribute(JspAccessType.PAGE_TYPE, JspAccessType.DETAIL);
        request.setAttribute("id", id);
        return "${moduleName}/${className?uncap_first}/edit/${className?uncap_first}_edit";
    }

</#if>
<#if findById?? && findById==true>
    @ResponseBody
    @RequestMapping(value = "/get", params = {"id"}, method = RequestMethod.GET)
    public void findById(@RequestParam String id, HttpServletResponse response) {
        ${className}Vo vo = ${className?uncap_first}Service.findById(id);
        GsonUtils.printData(response, vo);
    }

</#if>
<#if pageQuery?? && pageQuery==true>
    @ResponseBody
    @RequestMapping(value = "/pageQuery", method = RequestMethod.POST)
    public void pageQuery(HttpServletRequest request, HttpServletResponse response) {
        ${className}Bo bo = GsonUtils.wrapDataToEntity(request, ${className}Bo.class);
        PageVo pageVo = ${className?uncap_first}Service.pageQuery(bo);
        GsonUtils.printData(response, pageVo);
    }

</#if>
<#if queryValid?? && queryValid==true>
    @ResponseBody
    @RequestMapping(value = "/queryValid", method = RequestMethod.GET)
    public void queryValid(HttpServletRequest request, HttpServletResponse response) {
        ${className}Bo bo = GsonUtils.wrapDataToEntity(request, ${className}Bo.class);
        List<${className}Vo> data = ${className?uncap_first}Service.queryValid(bo);
        GsonUtils.printData(response, data);
    }

</#if>
<#if batchDelete?? && batchDelete==true>
    @ResponseBody
    @RequestMapping(value = "/delete", params = {"ids"}, method = RequestMethod.DELETE)
    public void deleteByIds(@RequestParam String ids, HttpServletResponse response) {
        String[] idArr = ids.split(",");
        ${className?uncap_first}Service.deleteByIds(idArr);
        GsonUtils.printSuccess(response);
    }

</#if>
}
