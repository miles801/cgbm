package ${packPath}.dto;

import com.michael.docs.annotations.ApiField;
import com.michael.poi.annotation.Col;
import com.michael.poi.annotation.ImportConfig;
import com.michael.poi.core.DTO;
/**
 * <#if author??>@author ${author}</#if>
 */
@ImportConfig(file = "", startRow = 1)
public class ${entity}DTO implements DTO {
<#list fields as attr>
    // ${attr.name}
    @Col(index=${attr_index})
    private ${attr.type} ${attr.field};
</#list>

<#-- getter and setter-->
<#list fields as attr>
    public void set${attr.field?cap_first}(${attr.type} ${attr.field}){
        this.${attr.field} = ${attr.field};
    }
    public ${attr.type} get${attr.field?cap_first}(){
        return this.${attr.field};
    }
</#list>
}
