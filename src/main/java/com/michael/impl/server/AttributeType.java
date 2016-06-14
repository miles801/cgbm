package com.michael.impl.server;

/**
 * 属性类型
 * @author Michael
 */
public enum AttributeType {
    STRING("String"),
    INTEGER("Integer"),
    FLOAT("Float"),
    BOOLEAN("Boolean"),
    DATE("java.util.Date"),
    DOUBLE("Double");
    private String value;

    AttributeType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
