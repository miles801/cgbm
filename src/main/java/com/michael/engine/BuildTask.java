package com.michael.engine;

import java.util.ArrayList;
import java.util.List;

/**
 * 生成代码的任务，持有多个生成单元
 *
 * @author Michael
 */
public class BuildTask {
    /**
     * 任务名称
     */
    private String name;
    /**
     * 任务描述
     */
    private String description;
    /**
     * 生成单元
     */
    private List<AbstractModel> models = new ArrayList<AbstractModel>();

    public BuildTask addUnit(AbstractModel model) {
        if (model == null) {
            return this;
        }
        if (models == null) {
            models = new ArrayList<AbstractModel>();
        }
        models.add(model);
        return this;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<AbstractModel> getModels() {
        return models;
    }

    public void setModels(List<AbstractModel> models) {
        this.models = models;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
