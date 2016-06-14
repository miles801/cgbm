package ${packageName}.dao;

import ${packageName}.bo.${className}Bo;
import ${packageName}.domain.${className};
import ${packageName}.vo.${className}Vo;
import java.util.List;

/**
 * <#if author??>@author ${author}</#if>
 */
public interface ${className}Dao {

    String save(${className} ${className?uncap_first});

    void update(${className} ${className?uncap_first});

    /**
     * 高级查询接口
     */
    List<${className}> query(${className}Bo bo);

    /**
     * 查询总记录数
     */
    Long getTotal(${className}Bo bo);

    ${className} findById(String id);

    void deleteById(String id);

    /**
     * 根据实体对象删除
     * 必须保证该实体是存在的（一般是get或者load得到的对象）
     */
    void delete(${className} ${className?uncap_first});
}
