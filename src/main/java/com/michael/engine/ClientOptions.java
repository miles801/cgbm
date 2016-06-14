package com.michael.engine;

/**
 * @author Michael
 */
public class ClientOptions extends AbstractOptions {
    private boolean modal = false;      // 是否为弹出层
    private boolean tree = false;       // 是否有树形


    public boolean isModal() {
        return modal;
    }

    public void setModal(boolean modal) {
        this.modal = modal;
    }

    public boolean isTree() {
        return tree;
    }

    public void setTree(boolean tree) {
        this.tree = tree;
    }
}
