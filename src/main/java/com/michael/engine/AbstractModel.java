package com.michael.engine;

/**
 * 数据模型
 *
 * @author Michael
 */
public abstract class AbstractModel {
    String className;
    String root;
    String packageName;
    String moduleName;
    String author;

    public AbstractModel() {
        this.className = BuildContext.get(BuildContext.ENTITY_NAME).toString();
        this.root = BuildContext.get(BuildContext.ROOT).toString();
        this.packageName = BuildContext.get(BuildContext.PACKAGE_NAME).toString();
        this.moduleName = BuildContext.get(BuildContext.MODULE_NAME).toString();
        this.author = BuildContext.get(BuildContext.AUTHOR).toString();
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getRoot() {
        return root;
    }

    public void setRoot(String root) {
        this.root = root;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    /**
     * 获得模板的内容
     */
    public abstract String getTemplateContent();

    /**
     * 目标文件的名称(含后缀）
     */
    public abstract String getFileName();

    /**
     * 目标文件的完整路径（含文件名）
     */
    public abstract String getFullPath();
}
