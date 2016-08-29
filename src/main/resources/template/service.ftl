package ${packPath}.service;

import com.michael.core.pager.PageVo;
import ${packPath}.bo.${entity}Bo;
import ${packPath}.domain.${entity};
import ${packPath}.vo.${entity}Vo;
import java.util.List;
/**
 * <#if author?has_content>@author ${author}</#if>
 */
public interface ${entity}Service {

    /**
     * 保存
     */
    String save(${entity} ${entity?uncap_first});

    /**
     * 更新
     */
    void update(${entity} ${entity?uncap_first});

    /**
     * 分页查询
     */
    PageVo pageQuery(${entity}Bo bo);

    /**
     * 不进行分页，常用于对外提供的查询接口
     */
    List<${entity}Vo> query(${entity}Bo bo);

    /**
     * 根据ID查询对象的信息
     */
    ${entity}Vo findById(String id);

    /**
     * 强制删除
     */
    void deleteByIds(String[] ids);

<#if !deleted>

    /**
    * 批量启用
    */
    void enable(String []ids);

    /**
    * 批量禁用
    */
    void disable(String []ids);

    /**
    * 查询所有有效的数据（不使用分页）
    * @param bo 可选的查询条件
    */
    List<${entity}> queryValid(${entity}Bo bo);

</#if>

<#if importData>
    /**
    * 导入数据
    * @param attachmentIds 上传的附件列表
    */
    void importData(String []attachmentIds);
</#if>
}
