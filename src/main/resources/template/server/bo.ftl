package ${packageName}.bo;

import com.ycrl.core.hibernate.criteria.BO;
<#if attributes??>
import com.ycrl.core.hibernate.criteria.Condition;
</#if>

/**
 * <#if author??>@author ${author}</#if>
 */
public class ${className}Bo implements BO{
<#if attributes?? >
    <#list attributes as attr>
    <#if attr.description??>
    // ${attr.description}
    </#if>
    @Condition
    private ${attr.type} ${attr.name};

    </#list>

    <#list attributes as attr>
    public void set${attr.name?cap_first}(${attr.type} ${attr.name}){
        this.${attr.name} = ${attr.name};
    }

    public ${attr.type} get${attr.name}(){
        return this.${attr.name};
    }
    </#list>
</#if>
}
