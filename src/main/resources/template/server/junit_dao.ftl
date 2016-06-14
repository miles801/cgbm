package ${packageName}.dao.impl;

import ${packageName}.dao.${className}Dao;
import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;
import com.ycrl.common.AbstractTest;
import javax.annotation.Resource;

/**
 * <#if author??>@author ${author}</#if>
 */
public class ${className}DaoImplTest extends AbstractTest {

    @Resource
    private ${className}Dao dao;

    private Logger logger = Logger.getLogger(${className}DaoImplTest.class);

    @Before
    public void setUp() throws Exception {
        logger.info(" test ${packageName}.dao.impl.${className}DaoImpl ......");
    }

    @Test
    public void testSave() {
        logger.info(" save ......");
    }

    @Test
    public void testFindById() {
        logger.info("test findById() ... ");
    }

    @Test
    public void testQuery() throws Exception {
        logger.info("test query() .. ");
    }


}
