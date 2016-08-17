package ${packPath}.vo;

import ${packPath}.domain.${entity};

/**
 * <#if author??>@author ${author}</#if>
 */
public class ${entity}Vo extends ${entity} {
<#list fields as attr>
<#if attr.param??>
     // ${attr.name}--参数名称
     private ${attr.type} ${attr.field}Name;
</#if>
</#list>

<#list fields as attr>
   <#if attr.param??>
    public void set${attr.field?cap_first}Name(${attr.type} ${attr.field}Name){
        this.${attr.field}Name = ${attr.field}Name;
    }
    public ${attr.type} get${attr.field?cap_first}Name(){
       return this.${attr.field}Name;
    }
   </#if>
</#list>
}
