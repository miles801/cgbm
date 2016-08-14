package com.michael.code;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Michael
 */
public class BeanConfig {
    /**
     * 工程路径
     */
    private String project;

    /**
     * 是否分模块
     */
    private boolean level = true;

    /**
     * 模块名称
     */
    private String name;
    /**
     * 表名称
     */
    private String table;
    /**
     * 实体类名称
     */
    private String entity;
    /**
     * 包路径
     */
    private String packPath;
    /**
     * 模块
     */
    private String module;
    /**
     * 子模块（可选）
     */
    private String module2;

    /**
     * 作者
     */
    private String author;
    /**
     * 时间
     */
    private String now;

    // 是否采用弹出层
    private boolean modal;

    // 是否采用分页
    private boolean page = true;

    // 是否采用真删除
    // 如果为false，则会添加enable和disable方法
    private boolean deleted = false;

    // 是否为附件：true表示有
    // 1. 在根js的save和update方法上，将使用attachmentIds
    // 2. 在编辑页面中将会引入upload.js
    // 3. 在编辑页面的js的save和update方法，会先获取attachmentIds属性
    private boolean attachment = false;

    // 是否为树：true表示有
    // 1. 在实体类中添加树形相关的字段，并实现Tree接口
    // 2. 在service的save和update方法中重置树形
    // 3. service提供树形接口
    // 4. 编辑页面注入树形js和css，对应的js也加入树形
    private boolean tree = false;

    private boolean date = false;

    // 是否允许导出数据
    private boolean export = false;

    // 是否允许导入数据
    private boolean importData = false;

    // 要生成的选项
    private List<String> items;

    public List<String> getItems() {
        return items;
    }

    public void setItems(List<String> items) {
        this.items = items;
    }

    public boolean isImportData() {
        return importData;
    }

    public void setImportData(boolean importData) {
        this.importData = importData;
    }

    public boolean isExport() {
        return export;
    }

    public void setExport(boolean export) {
        this.export = export;
    }

    public boolean isLevel() {
        return level;
    }

    public void setLevel(boolean level) {
        this.level = level;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isDate() {
        return date;
    }

    public void setDate(boolean date) {
        this.date = date;
    }

    public String getProject() {
        return project;
    }

    public void setProject(String project) {
        this.project = project;
    }

    public boolean isPage() {
        return page;
    }

    public void setPage(boolean page) {
        this.page = page;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    private List<BeanField> fields;

    public BeanConfig addBeanField(BeanField beanField) {
        if (fields == null) {
            fields = new ArrayList<BeanField>();
        }
        fields.add(beanField);
        return this;
    }

    public boolean isModal() {
        return modal;
    }

    public void setModal(boolean modal) {
        this.modal = modal;
    }

    public List<BeanField> getFields() {
        return fields;
    }

    public void setFields(List<BeanField> fields) {
        this.fields = fields;
    }

    public boolean isAttachment() {
        return attachment;
    }

    public void setAttachment(boolean attachment) {
        this.attachment = attachment;
    }

    public boolean isTree() {
        return tree;
    }

    public void setTree(boolean tree) {
        this.tree = tree;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getNow() {
        return now;
    }

    public void setNow(String now) {
        this.now = now;
    }

    public String getTable() {
        return table;
    }

    public void setTable(String table) {
        this.table = table;
    }

    public String getEntity() {
        return entity;
    }

    public void setEntity(String entity) {
        this.entity = entity;
    }

    public String getPackPath() {
        return packPath;
    }

    public void setPackPath(String packPath) {
        this.packPath = packPath;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public String getModule2() {
        return module2;
    }

    public void setModule2(String module2) {
        this.module2 = module2;
    }
}
