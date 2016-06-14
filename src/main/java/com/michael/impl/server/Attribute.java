package com.michael.impl.server;

/**
 * 类中的属性
 *
 * @author Michael
 */
public class Attribute {
    /**
     * 属性名称
     */
    private String name;
    /**
     * 属性类型，请参考AttributeType
     */
    private String type;
    /**
     * 属性描述
     */
    private String description;

    public Attribute() {
    }

    public Attribute(String name, String type, String description) {
        this.name = name;
        this.type = type;
        this.description = description;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
