package ${packageName}.service.impl;

import ${packageName}.service.${className}Service;
import com.ycrl.common.AbstractTest;
import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;
import javax.annotation.Resource;

/**
 * <#if author??>@author ${author}</#if>
 */
public class ${className}ServiceImplTest extends AbstractTest {

    @Resource
    private ${className}Service service;

    private Logger logger = Logger.getLogger(${className}ServiceImplTest.class);

    @Before
    public void setUp() throws Exception {
        logger.info("test init ...");
    }

    @Test
    public void testSave() {
        logger.info("test save() ... ");
    }

    @Test
    public void testFindById() {
        logger.info("test findById() ... ");
    }

    @Test
    public void testQuery() throws Exception {
        logger.info("test query() .. ");
    }

    @Test
    public void testUpdate() throws Exception {
        logger.info("test update() ... ");
    }

    @Test
    public void testDeleteById() {
    }

}
