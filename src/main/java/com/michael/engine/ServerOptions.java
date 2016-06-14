package com.michael.engine;

import com.michael.impl.server.Attribute;

import java.util.List;

/**
 * 服务端的配置
 *
 * @author Michael
 */
public class ServerOptions extends AbstractOptions {


    private boolean permission = false;     // 是否启用权限
    private boolean dynamicTree = false;    // 是否启用动态树
    private boolean attachment;             // 是否启用附件
    private boolean save = true;
    private boolean update = true;
    private boolean pageQuery = true;       // 高级分页查询
    private boolean pageQueryValid = false; // 分页查询有效的
    private boolean findById = true;        // 根据id查询
    private boolean batchDelete = true;     // 批量删除
    private boolean batchCancel = false;    // 批量注销
    private boolean permissionPageQuery = false;// 带权限的分页查询
    private boolean permissionQuery = false;    // 带权限的集合查询

    private String tableName;               // 表名称
    private String description;             // 类描述
    private List<Attribute> attributes;     // 实体的属性

    public boolean isPermission() {
        return permission;
    }

    public void setPermission(boolean permission) {
        this.permission = permission;
    }

    public boolean isDynamicTree() {
        return dynamicTree;
    }

    public void setDynamicTree(boolean dynamicTree) {
        this.dynamicTree = dynamicTree;
    }

    public boolean isAttachment() {
        return attachment;
    }

    public void setAttachment(boolean attachment) {
        this.attachment = attachment;
    }

    public boolean isSave() {
        return save;
    }

    public void setSave(boolean save) {
        this.save = save;
    }

    public boolean isUpdate() {
        return update;
    }

    public void setUpdate(boolean update) {
        this.update = update;
    }

    public boolean isPageQuery() {
        return pageQuery;
    }

    public void setPageQuery(boolean pageQuery) {
        this.pageQuery = pageQuery;
    }

    public boolean isPageQueryValid() {
        return pageQueryValid;
    }

    public void setPageQueryValid(boolean pageQueryValid) {
        this.pageQueryValid = pageQueryValid;
    }

    public boolean isFindById() {
        return findById;
    }

    public void setFindById(boolean findById) {
        this.findById = findById;
    }

    public boolean isBatchDelete() {
        return batchDelete;
    }

    public void setBatchDelete(boolean batchDelete) {
        this.batchDelete = batchDelete;
    }

    public boolean isBatchCancel() {
        return batchCancel;
    }

    public void setBatchCancel(boolean batchCancel) {
        this.batchCancel = batchCancel;
    }

    public boolean isPermissionPageQuery() {
        return permissionPageQuery;
    }

    public void setPermissionPageQuery(boolean permissionPageQuery) {
        this.permissionPageQuery = permissionPageQuery;
    }

    public boolean isPermissionQuery() {
        return permissionQuery;
    }

    public void setPermissionQuery(boolean permissionQuery) {
        this.permissionQuery = permissionQuery;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public List<Attribute> getAttributes() {
        return attributes;
    }

    public void setAttributes(List<Attribute> attributes) {
        this.attributes = attributes;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
