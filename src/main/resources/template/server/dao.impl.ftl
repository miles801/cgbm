package ${packageName}.dao.impl;

import ${packageName}.bo.${className}Bo;
import ${packageName}.domain.${className};
import ${packageName}.dao.${className}Dao;
import com.ycrl.core.HibernateDaoHelper;
import org.hibernate.criterion.Example;
import com.ycrl.core.hibernate.criteria.CriteriaUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;
import java.util.List;


/**
 * <#if author??>@author ${author}</#if>
 */
@Repository("${className?uncap_first}Dao")
public class ${className}DaoImpl extends HibernateDaoHelper implements ${className}Dao {

    @Override
    public String save(${className} ${className?uncap_first}) {
        return (String) getSession().save(${className?uncap_first});
    }

    @Override
    public void update(${className} ${className?uncap_first}) {
        getSession().update(${className?uncap_first});
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<${className}> query(${className}Bo bo) {
        Criteria criteria = createCriteria(${className}.class);
        initCriteria(criteria, bo);
        return criteria.list();
    }

    @Override
    public Long getTotal(${className}Bo bo) {
        Criteria criteria = createRowCountsCriteria(${className}.class);
        initCriteria(criteria, bo);
        return (Long) criteria.uniqueResult();
    }


    @Override
    public void deleteById(String id) {
        getSession().createQuery("delete from " + ${className}.class.getName() + " e where e.id=?")
                .setParameter(0, id)
                .executeUpdate();
    }

    @Override
    public void delete(${className} ${className?uncap_first}) {
        Assert.notNull(${className?uncap_first}, "要删除的对象不能为空!");
        getSession().delete(${className?uncap_first});
    }

    @Override
    public ${className} findById(String id) {
        Assert.hasText(id, "ID不能为空!");
        return (${className}) getSession().get(${className}.class, id);
    }

    private void initCriteria(Criteria criteria, ${className}Bo bo) {
        Assert.notNull(criteria, "criteria must not be null!");
        CriteriaUtils.addCondition(criteria, bo);
    }

}