package ${packPath}.service.impl;

import ${packPath}.bo.${entity}Bo;
import ${packPath}.domain.${entity};
import ${packPath}.vo.${entity}Vo;
import ${packPath}.dao.${entity}Dao;
import ${packPath}.service.${entity}Service;
import com.ycrl.core.beans.BeanWrapBuilder;
import com.ycrl.core.beans.BeanWrapCallback;
import com.ycrl.core.hibernate.validator.ValidatorUtils;
import com.ycrl.core.pager.PageVo;
import com.ycrl.core.pager.Pager;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
<#if importData>
import com.ycrl.core.SystemContainer;
import com.michael.poi.adapter.AnnotationCfgAdapter;
import com.michael.poi.core.Context;
import com.michael.poi.core.Handler;
import com.michael.poi.core.ImportEngine;
import com.michael.poi.core.RuntimeContext;
import com.michael.poi.imp.cfg.Configuration;
import eccrm.base.attachment.AttachmentProvider;
import eccrm.base.attachment.utils.AttachmentHolder;
import eccrm.base.attachment.vo.AttachmentVo;
import eccrm.utils.BeanCopyUtils;
import eccrm.base.parameter.service.ParameterContainer;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.util.ReflectionUtils;
import java.io.File;
import java.io.IOException;
import ${packPath}.dto.${entity}DTO;
</#if>
<#if tree>
import com.michael.tree.TreeBuilder;
</#if>
import java.util.List;
import javax.annotation.Resource;
/**
 * <#if author?has_content>@author ${author}</#if>
 */
@Service("${entity?uncap_first}Service")
public class ${entity}ServiceImpl implements ${entity}Service, BeanWrapCallback<${entity}, ${entity}Vo> {
    @Resource
    private ${entity}Dao ${entity?uncap_first}Dao;

    @Override
    public String save(${entity} ${entity?uncap_first}) {
        <#if !deleted>
        ${entity?uncap_first}.setDeleted(false);
        </#if>
        <#if tree>
        // 构建树形对象
        TreeBuilder<${entity}> treeBuilder = new TreeBuilder<${entity}>();
        treeBuilder.beforeSave(${entity?uncap_first});
        </#if>
        validate(${entity?uncap_first});
        String id = ${entity?uncap_first}Dao.save(${entity?uncap_first});
        return id;
    }

    @Override
    public void update(${entity} ${entity?uncap_first}) {
        validate(${entity?uncap_first});
        <#if tree>
        // 构建树形对象
        TreeBuilder<${entity}> treeBuilder = new TreeBuilder<${entity}>();
        treeBuilder.beforeUpdate(${entity?uncap_first});
        </#if>
        ${entity?uncap_first}Dao.update(${entity?uncap_first});
    }

    private void validate(${entity} ${entity?uncap_first}) {
        ValidatorUtils.validate(${entity?uncap_first});
<#if fields??>
    <#list fields as field>
        <#if field.unique>

        // 验证重复 - ${field.name}
        boolean has${field.field?cap_first} = ${entity?uncap_first}Dao.has${field.field?cap_first}(${entity?uncap_first}.get${field.field?cap_first}, ${entity?uncap_first}.getId());
        Assert.isTree(!has${field.field?cap_first},"操作失败!${field.name}["+${entity?uncap_first}.get${field.field?cap_first}+"]已经存在!");

        </#if>
    </#list>
</#if>
    }

    @Override
    public PageVo pageQuery(${entity}Bo bo) {
        PageVo vo = new PageVo();
        Long total = ${entity?uncap_first}Dao.getTotal(bo);
        vo.setTotal(total);
        if (total==null || total == 0) return vo;
        List<${entity}> ${entity?uncap_first}List = ${entity?uncap_first}Dao.pageQuery(bo);
        List<${entity}Vo> vos = BeanWrapBuilder.newInstance()
            .setCallback(this)
            .wrapList(${entity?uncap_first}List,${entity}Vo.class);
        vo.setData(vos);
        return vo;
    }


    @Override
    public ${entity}Vo findById(String id) {
        ${entity} ${entity?uncap_first} = ${entity?uncap_first}Dao.findById(id);
        return BeanWrapBuilder.newInstance()
            .wrap(${entity?uncap_first}, ${entity}Vo.class);
    }

    @Override
    public void deleteByIds(String[] ids) {
        if (ids == null || ids.length == 0) return;
        for (String id : ids) {
            ${entity?uncap_first}Dao.deleteById(id);
        }
    }

    @Override
    public List<${entity}Vo> query(${entity}Bo bo) {
        List<${entity}> ${entity?uncap_first}List = ${entity?uncap_first}Dao.query(bo);
        List<${entity}Vo> vos = BeanWrapBuilder.newInstance()
            .setCallback(this)
            .wrapList(${entity?uncap_first}List,${entity}Vo.class);
        return vos;
    }

    <#--只有逻辑删除的实体才拥有启用和禁用的功能-->
<#if !deleted>
    @Override
    public void enable(String []ids){
        Assert.notEmpty(ids,"启用失败!ID集合不能为空!");
        for (String id : ids) {
            ${entity} ${entity?uncap_first} = ${entity?uncap_first}Dao.findById(id);
            Assert.notNull(${entity?uncap_first},"启用失败!数据不存在，请刷新后重试!");
            ${entity?uncap_first}.setDeleted(false);
        }
    }

    @Override
    public void disable(String []ids){
        Assert.notEmpty(ids,"启用失败!ID集合不能为空!");
        for (String id : ids) {
            ${entity} ${entity?uncap_first} = ${entity?uncap_first}Dao.findById(id);
            Assert.notNull(${entity?uncap_first},"启用失败!数据不存在，请刷新后重试!");
            ${entity?uncap_first}.setDeleted(true);
        }
    }

    @Override
    public List<${entity}> queryValid(${entity}Bo bo) {
        if (bo == null) {
            bo = new ${entity}Bo();
        }
        bo.setDeleted(false);
        return ${entity?uncap_first}Dao.query(bo);
    }

</#if>

<#if importData>
    public void importData(String []attachmentIds){
        Logger logger = Logger.getLogger(${entity}ServiceImpl.class);
        Assert.notEmpty(attachmentIds, "数据导入失败!数据文件不能为空，请重试!");
        for (String id : attachmentIds) {
            AttachmentVo vo = AttachmentProvider.getInfo(id);
            Assert.notNull(vo, "附件已经不存在，请刷新后重试!");
            final File file = AttachmentHolder.newInstance().getTempFile(id);
            logger.info("准备导入数据：" + file.getAbsolutePath());
            logger.info("初始化导入引擎....");
            long start = System.currentTimeMillis();

            // 初始化引擎
            Configuration configuration = new AnnotationCfgAdapter(${entity}DTO.class).parse();
            configuration.setStartRow(1);
            String newFilePath = file.getAbsolutePath() + vo.getFileName().substring(vo.getFileName().lastIndexOf(".")); //获取路径
            try {
                FileUtils.copyFile(file, new File(newFilePath));
            } catch (IOException e) {
                e.printStackTrace();
            }
            // 获取session
            SessionFactory sessionFactory = (SessionFactory) SystemContainer.getInstance().getBean("sessionFactory");
            final Session session = sessionFactory.getCurrentSession();
            configuration.setPath(newFilePath);
            configuration.setHandler(new Handler<${entity}DTO>() {
                @Override
                public void execute(${entity}DTO dto) {
                    Context context = RuntimeContext.get();
                    ${entity} ${entity?uncap_first} = new ${entity}();
                    BeanUtils.copyProperties(dto, ${entity?uncap_first});
                    if (BeanCopyUtils.isEmpty(${entity?uncap_first})) {
                        return;
                    }
                    session.save(${entity?uncap_first});
                    if (context.getRowIndex()%10==0) {
                        session.flush();
                        session.clear();
                    }
                }
            });
            logger.info("开始导入数据....");
            ImportEngine engine = new ImportEngine(configuration);
            try {
                engine.execute();
            } catch (Exception e) {
                Assert.isTrue(false, String.format("数据异常!发生在第%d行,%d列!原因:%s", RuntimeContext.get().getRowIndex(), RuntimeContext.get().getCellIndex(), e.getCause() == null ? e.getMessage() : e.getCause().getMessage()));
            }
            logger.info(String.format("导入数据成功,用时(%d)s....", (System.currentTimeMillis() - start) / 1000));
            new File(newFilePath).delete();

    }
    }
</#if>
    @Override
    public void doCallback(${entity} ${entity?uncap_first}, ${entity}Vo vo) {
            ParameterContainer container = ParameterContainer.getInstance();
        <#list fields as attr>
            <#if attr.param?has_content>

                // ${attr.name}
            vo.set${attr.field?cap_first}Name(container.getSystemName("${attr.param}", ${entity?uncap_first}.get${attr.field?cap_first}()));
            </#if>
        </#list>

    }
}
