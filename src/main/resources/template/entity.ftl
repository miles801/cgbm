package ${packPath}.domain;

import com.ycrl.base.common.CommonDomain;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Date;
<#if fields??>
import com.michael.docs.annotations.ApiField;
</#if>
<#if tree>
import com.michael.tree.Tree;
</#if>
<#if attachment>
import eccrm.base.attachment.AttachmentSymbol;
</#if>
/**
 * ${name}
 * <#if author?has_content>@author ${author}</#if>
 */
@Entity
@Table(name = "${table}")
public class ${entity} extends CommonDomain <#if tree>implements Tree</#if><#if  tree && attachment >,AttachmentSymbol</#if><#if attachment && !tree>implements AttachmentSymbol</#if>{
<#if fields??>
<#-- 字段定义 -->
<#list fields as attr>
    <#assign type=(attr.type!'string')>
    @ApiField(value="${attr.name}"<#if attr.param?has_content>,desc="参数:${attr.param}"</#if>)
    <#if attr.require>
    @NotNull
    </#if>
    @Column( name="${attr.field}"<#if attr.require>,nullable=false</#if> <#if attr.unique>,unique=true</#if> <#if attr.type=='String' && attr.length??> ,length=${attr.length}</#if>)
    private ${attr.type} ${attr.field};

</#list>

<#if tree>
    // 上级
    @Column(length = 40)
    private String parentId;

    @Column(length = 40)
    private String parentName;


    @ApiField(value = "访问路径")
    @Column(length = 400)
    private String path;

    @ApiField(value = "层级", desc = "该值由后台自动设置,最小值为0，表示首层")
    @Column
    private Integer level;


    @ApiField(value = "排序号")
    @Column
    private Integer sequenceNo;

</#if>
<#if !deleted>
    @NotNull
    @Column
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
    public void set${attr.field?cap_first}(${attr.type} ${attr.field}){
        this.${attr.field} = ${attr.field};
    }
    public ${attr.type} get${attr.field?cap_first}(){
        return this.${attr.field};
    }
</#list>

    <#if attachment>
    @Override
    public String businessId() {
        return getId();
    }
    </#if>

    <#if tree>
    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Integer getSequenceNo() {
        return sequenceNo;
    }

    public void setSequenceNo(Integer sequenceNo) {
        this.sequenceNo = sequenceNo;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }
    </#if>
</#if>
}
