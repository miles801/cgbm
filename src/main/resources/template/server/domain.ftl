package ${packageName}.domain;

import com.ycrl.base.common.CommonDomain;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.*;
import java.util.Date;
/**
 * <#if description??>${description}</#if>
 * <#if author??>@author ${author}</#if>
 */

@Entity
@Table(name = "T_${className?uncap_first}")
public class ${className} extends CommonDomain {

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
