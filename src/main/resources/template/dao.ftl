package ${packPath}.dao;

import ${packPath}.bo.${entity}Bo;
import ${packPath}.domain.${entity};
import ${packPath}.vo.${entity}Vo;
import java.util.List;

/**
 * <#if author??>@author ${author}</#if>
 */
public interface ${entity}Dao {

    String save(${entity} ${entity?uncap_first});

    void update(${entity} ${entity?uncap_first});

    /**
     * 高级查询接口
     */
    List<${entity}> query(${entity}Bo bo);

    /**
     * 查询总记录数
     */
    Long getTotal(${entity}Bo bo);

    ${entity} findById(String id);

    void deleteById(String id);

    /**
     * 根据实体对象删除
     * 必须保证该实体是存在的（一般是get或者load得到的对象）
     */
    void delete(${entity} ${entity?uncap_first});

<#if fields??>
    <#list fields as field>
        <#if field.unique>
    /**
    * 判断是否具有重复的项
    * @param ${field.field} ${field.name}
    * @param id 排除自身
    * @return true：存在
    */
    boolean has${field.field?cap_first}(${field.type} ${field.field},String id);
        </#if>
    </#list>
</#if>
}
