package com.michael.cgbm;

import com.michael.engine.BuildContext;
import com.michael.engine.Engine;
import com.michael.impl.server.*;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Michael
 */
public class UserTest {
    @Before
    public void setUp() throws Exception {
        BuildContext.put(BuildContext.ENTITY_NAME, "BlackList");
        BuildContext.put(BuildContext.MODULE_NAME, "oa");
        BuildContext.put(BuildContext.PACKAGE_NAME, "com.michael.oa");
        BuildContext.put(BuildContext.ROOT, "D:\\workspace\\lr\\hh-oa");
        BuildContext.put(BuildContext.AUTHOR, "Michael");
    }

    @Test
    public void testBuild() throws Exception {

        Engine engine = new Engine();
        // 实体类单元
        List<Attribute> attributes = new ArrayList<Attribute>();

        Domain domain = new Domain();
        domain.setAttributes(attributes);
        domain.setDescription("黑户");
        engine.addModel(domain);

        // BO单元
        Bo bo = new Bo();
        List<Attribute> boAtt = new ArrayList<Attribute>();
        bo.setAttributes(boAtt);
        engine.addModel(bo);

        // VO单元
        Vo vo = new Vo();
        vo.setAttributes(attributes);
        engine.addModel(vo);

        // service单元
        engine.addModel(new Service());
        engine.addModel(new ServiceImpl());

        // dao单元
        engine.addModel(new Dao());
        engine.addModel(new DaoImpl());

        // Ctrl单元
        engine.addModel(new Ctrl());

        engine.build();

    }

}
