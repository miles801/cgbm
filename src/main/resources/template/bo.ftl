package ${packPath}.bo;

import com.ycrl.core.hibernate.criteria.BO;
<#if fields??>
import com.ycrl.core.hibernate.criteria.Condition;
</#if>
<#if fields??>
    <#list fields as attr>
        <#if (attr.type)=='Date'>
import java.util.Date;
        <#break>
        </#if>
    </#list>
</#if>

/**
 * <#if author??>@author ${author}</#if>
 */
public class ${entity}Bo implements BO{
<#if fields?? >
    <#list fields as attr>
        <#if attr.condition??>
            <#if attr.condition == true>
    @Condition
    private ${attr.type} ${attr.field};

            </#if>
        </#if>
    </#list>
<#if !deleted>

    @Condition
    private Boolean deleted;

    public Boolean getDeleted() {
        return deleted;
    }
    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }
</#if>
    <#-- getter and setter-->
    <#list fields as attr>
    <#if (attr.condition)>
    public void set${attr.field?cap_first}(${attr.type} ${attr.field}){
        this.${attr.field} = ${attr.field};
    }
    public ${attr.type} get${attr.field?cap_first}(){
        return this.${attr.field};
    }
    </#if>
    </#list>
</#if>
}
