package ${packPath}.dao.impl;

import ${packPath}.bo.${entity}Bo;
import ${packPath}.domain.${entity};
import ${packPath}.dao.${entity}Dao;
import com.ycrl.core.HibernateDaoHelper;
import com.ycrl.core.hibernate.criteria.CriteriaUtils;
import com.ycrl.utils.string.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;

import java.util.List;


/**
 * <#if author??>@author ${author}</#if>
 */
@Repository("${entity?uncap_first}Dao")
public class ${entity}DaoImpl extends HibernateDaoHelper implements ${entity}Dao {

    @Override
    public String save(${entity} ${entity?uncap_first}) {
        return (String) getSession().save(${entity?uncap_first});
    }

    @Override
    public void update(${entity} ${entity?uncap_first}) {
        getSession().update(${entity?uncap_first});
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<${entity}> query(${entity}Bo bo) {
        Criteria criteria = createCriteria(${entity}.class);
        initCriteria(criteria, bo);
        return criteria.list();
    }

    @Override
    public Long getTotal(${entity}Bo bo) {
        Criteria criteria = createRowCountsCriteria(${entity}.class);
        initCriteria(criteria, bo);
        return (Long) criteria.uniqueResult();
    }


    @Override
    public void deleteById(String id) {
        getSession().createQuery("delete from " + ${entity}.class.getName() + " e where e.id=?")
                .setParameter(0, id)
                .executeUpdate();
    }

    @Override
    public void delete(${entity} ${entity?uncap_first}) {
        Assert.notNull(${entity?uncap_first}, "要删除的对象不能为空!");
        getSession().delete(${entity?uncap_first});
    }

    @Override
    public ${entity} findById(String id) {
        Assert.hasText(id, "ID不能为空!");
        return (${entity}) getSession().get(${entity}.class, id);
    }

<#if fields??>
    <#list fields as field>
        <#if field.unique>
        @Override
    public boolean has${field.field?cap_first}(${field.type} ${field.field},String id){
        Assert.hasText(${field.field},"查询失败!${field.name}不能为空!");
        Criteria criteria = createRowCountsCriteria(${entity}.class)
                .add(Restrictions.eq("${field.field}", ${field.field}));
        if (StringUtils.isNotEmpty(id)) {
            criteria.add(Restrictions.ne("id", id));
        }
        return (Long) criteria.uniqueResult() > 0;
    }
        </#if>
    </#list>
</#if>

    private void initCriteria(Criteria criteria, ${entity}Bo bo) {
        Assert.notNull(criteria, "criteria must not be null!");
        CriteriaUtils.addCondition(criteria, bo);
    }

}