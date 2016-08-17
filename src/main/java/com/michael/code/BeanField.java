package com.michael.code;

/**
 * @author Michael
 */
public class BeanField {
    // 名称
    private String name;
    // 字段名称
    private String field;
    // 类型：String,Boolean,Date
    private String type;
    // 页面上的类型：text/radio/checkbox/select/textarea/date
    private String type2;

    // 长度：当类型是string时有效
    private String length;

    // 默认值：如果有则在service保存的时候进行设置
    private String defaultValue;

    // 是否作为条件：如果true，
    // 1. 添加到bo，默认方式为Condition
    // 2. 在列表页面的查询条件中展示
    private boolean condition = false;

    // 是否作为列表：true则表示将会做列表页面的信息中展示
    private boolean list;

    // 是否作为编辑：true则表示改字段将会在编辑页面中进行展示
    private boolean edit;

    // 是否必须：true表示必须
    // 1. 在实体类上使用NotNull和nullable=false进行标注
    // 2. 在编辑页面使用validate validate-required标注
    private boolean require;

    // 是否唯一：true表示唯一
    // 1. 在实体类上使用unique=true标注
    // 2. 在dao层添加hasXxx的方法
    // 3. 在service的update和save方法时，调用validate方法进行唯一性校验
    private boolean unique;

    // 参数编号！如果该属性有值，则表示为参数，值为参数类型的编号
    private String param;

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }

    public String getLength() {
        return length;
    }

    public void setLength(String length) {
        this.length = length;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public boolean isCondition() {
        return condition;
    }

    public void setCondition(boolean condition) {
        this.condition = condition;
    }

    public boolean isList() {
        return list;
    }

    public void setList(boolean list) {
        this.list = list;
    }

    public boolean isEdit() {
        return edit;
    }

    public void setEdit(boolean edit) {
        this.edit = edit;
    }

    public boolean isRequire() {
        return require;
    }

    public void setRequire(boolean require) {
        this.require = require;
    }

    public boolean isUnique() {
        return unique;
    }

    public void setUnique(boolean unique) {
        this.unique = unique;
    }

    public String getType2() {
        return type2;
    }

    public void setType2(String type2) {
        this.type2 = type2;
    }
}
