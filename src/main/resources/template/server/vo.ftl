package ${packageName}.vo;

import ${packageName}.domain.${className};

/**
 * <#if author??>@author ${author}</#if>
 */
public class ${className}Vo extends ${className} {

<#if attributes?? >
    <#list attributes as attr>
    <#if attr.description??>
    // ${attr.description}
    </#if>
    private ${attr.type} ${attr.name};

    </#list>

    <#list attributes as attr>
    public void set${attr.name?cap_first}(${attr.type} ${attr.name}){
        this.${attr.name} = ${attr.name};
    }

    public ${attr.type} get${attr.name?cap_first}(){
        return this.${attr.name};
    }
    
    </#list>
</#if>
}
