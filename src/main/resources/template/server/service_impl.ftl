package ${packageName}.service.impl;

import com.ycrl.core.pager.PageVo;
import com.ycrl.base.common.CommonStatus;
import ${packageName}.bo.${className}Bo;
import ${packageName}.domain.${className};
import ${packageName}.vo.${className}Vo;
import ${packageName}.dao.${className}Dao;
import ${packageName}.service.${className}Service;
import org.springframework.stereotype.Service;
import com.ycrl.core.beans.BeanWrapBuilder;
import com.ycrl.core.beans.BeanWrapCallback;
import com.ycrl.core.hibernate.validator.ValidatorUtils;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <#if author??>@author ${author}</#if>
 */
@Service("${className?uncap_first}Service")
public class ${className}ServiceImpl implements ${className}Service, BeanWrapCallback<${className}, ${className}Vo> {
    @Resource
    private ${className}Dao ${className?uncap_first}Dao;

    @Override
    public String save(${className} ${className?uncap_first}) {
        ValidatorUtils.validate(${className?uncap_first});
        String id = ${className?uncap_first}Dao.save(${className?uncap_first});
        return id;
    }

    @Override
    public void update(${className} ${className?uncap_first}) {
        ValidatorUtils.validate(${className?uncap_first});
        ${className?uncap_first}Dao.update(${className?uncap_first});
    }

    @Override
    public PageVo pageQuery(${className}Bo bo) {
        PageVo vo = new PageVo();
        Long total = ${className?uncap_first}Dao.getTotal(bo);
        vo.setTotal(total);
        if (total==null || total == 0) return vo;
        List<${className}> ${className?uncap_first}List = ${className?uncap_first}Dao.query(bo);
        List<${className}Vo> vos = BeanWrapBuilder.newInstance()
            .setCallback(this)
            .wrapList(${className?uncap_first}List,${className}Vo.class);
        vo.setData(vos);
        return vo;
    }


    @Override
    public ${className}Vo findById(String id) {
        ${className} ${className?uncap_first} = ${className?uncap_first}Dao.findById(id);
        return BeanWrapBuilder.newInstance()
            .wrap(${className?uncap_first}, ${className}Vo.class);
    }

    @Override
    public void deleteByIds(String[] ids) {
        if (ids == null || ids.length == 0) return;
        for (String id : ids) {
            ${className?uncap_first}Dao.deleteById(id);
        }
    }

    @Override
    public void doCallback(${className} ${className?uncap_first}, ${className}Vo vo) {
    }
}
