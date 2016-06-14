package ${packageName}.service;

import com.ycrl.core.pager.PageVo;
import ${packageName}.bo.${className}Bo;
import ${packageName}.domain.${className};
import ${packageName}.vo.${className}Vo;

/**
 * <#if author??>@author ${author}</#if>
 * <#if description??>${description}</#if>
 */
public interface ${className}Service {

    <#if save?? && save==true >
    /**
     * 保存
     */
    String save(${className} ${className?uncap_first});

    </#if>
    <#if update?? && update==true>
    /**
     * 更新
     */
    void update(${className} ${className?uncap_first});

    </#if>
    <#if pageQuery?? && pageQuery==true>
    /**
     * 分页查询
     */
    PageVo pageQuery(${className}Bo bo);

    </#if>
    <#if queryValid?? && queryValid==true>
    /**
     * 查询状态为有效的数据，不进行分页，常用于对外提供的查询接口
     */
    List<${className}Vo> queryValid(${className}Bo bo);

    </#if>
    <#if findById?? && findById==true>
    /**
     * 根据ID查询对象的信息
     */
    ${className}Vo findById(String id);

    </#if>
    <#if batchDelete?? && batchDelete==true>
    /**
     * 批量删除
     */
    void deleteByIds(String[] ids);

    </#if>
}
