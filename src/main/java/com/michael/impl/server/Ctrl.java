package com.michael.impl.server;

import com.michael.engine.AbstractModel;
import com.michael.engine.BuildContext;
import com.michael.utils.StringUtils;
import com.michael.utils.TemplateUtils;
import org.apache.log4j.Logger;

import java.io.IOException;

/**
 * @author Michael
 */
public class Ctrl extends AbstractModel {

    private Logger logger = Logger.getLogger(Ctrl.class);

    /**
     * 跳转到列表页面
     */
    private boolean toList = true;
    /**
     * 跳转到新增页面
     */
    private boolean toAdd = true;
    /**
     * 保存
     */
    private boolean save = true;
    /**
     * 跳转到编辑页面
     */
    private boolean toModify = true;
    /**
     * 更新
     */
    private boolean update = true;
    /**
     * 跳转到明细页面
     */
    private boolean toDetail = true;
    /**
     * 根据id查询
     */
    private boolean findById = true;
    /**
     * 高级分页查询
     */
    private boolean pageQuery = true;
    /**
     * 查询有效数据
     */
    private boolean queryValid = false;
    /**
     * 批量删除
     */
    private boolean batchDelete = true;

    @Override
    public String getTemplateContent() {
        String templateFile = "/template/server/ctrl.ftl";
        try {
            return TemplateUtils.loadTemplate(templateFile);
        } catch (IOException e) {
            logger.error("读取模板[" + templateFile + "]失败!");
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public String getFullPath() {
        String root = BuildContext.get(BuildContext.ROOT).toString();
        String module = BuildContext.get(BuildContext.MODULE_NAME).toString();
        String packageName = BuildContext.get(BuildContext.PACKAGE_NAME).toString();
        String path = StringUtils.addSuffix(root, "/") + "eccrm-" + module + "/" + module + "-web/src/main/java/" + packageName.replaceAll("\\.", "/") + "/web/" + getFileName();
        return path;
    }

    @Override
    public String getFileName() {
        return BuildContext.get(BuildContext.ENTITY_NAME) + "Ctrl.java";
    }

    public boolean isBatchDelete() {
        return batchDelete;
    }

    public void setBatchDelete(boolean batchDelete) {
        this.batchDelete = batchDelete;
    }

    public boolean isFindById() {
        return findById;
    }

    public void setFindById(boolean findById) {
        this.findById = findById;
    }

    public Logger getLogger() {
        return logger;
    }

    public void setLogger(Logger logger) {
        this.logger = logger;
    }

    public boolean isPageQuery() {
        return pageQuery;
    }

    public void setPageQuery(boolean pageQuery) {
        this.pageQuery = pageQuery;
    }

    public boolean isQueryValid() {
        return queryValid;
    }

    public void setQueryValid(boolean queryValid) {
        this.queryValid = queryValid;
    }

    public boolean isSave() {
        return save;
    }

    public void setSave(boolean save) {
        this.save = save;
    }

    public boolean isToAdd() {
        return toAdd;
    }

    public void setToAdd(boolean toAdd) {
        this.toAdd = toAdd;
    }

    public boolean isToDetail() {
        return toDetail;
    }

    public void setToDetail(boolean toDetail) {
        this.toDetail = toDetail;
    }

    public boolean isToList() {
        return toList;
    }

    public void setToList(boolean toList) {
        this.toList = toList;
    }

    public boolean isToModify() {
        return toModify;
    }

    public void setToModify(boolean toModify) {
        this.toModify = toModify;
    }

    public boolean isUpdate() {
        return update;
    }

    public void setUpdate(boolean update) {
        this.update = update;
    }
}
