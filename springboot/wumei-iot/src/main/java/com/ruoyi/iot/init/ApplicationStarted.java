package com.ruoyi.iot.init;


//import com.ruoyi.mysql.config.TDengineConfig;

//import com.ruoyi.iot.tdengine.config.TDengineConfig;
import com.ruoyi.iot.tdengine.config.TDengineConfig;
        import com.ruoyi.iot.domain.DeviceLog;
import com.ruoyi.iot.mapper.DeviceMapper;
import com.ruoyi.iot.tdengine.mapper.TDDeviceLogMapper;
        import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 类名: ApplicationStarted
 * 描述: TODO
 * 时间: 2022/5/18,0018 1:41
 * 开发人: wxy
 */
@Component
public class ApplicationStarted implements ApplicationRunner {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApplicationStarted.class);

    @Autowired
    private TDengineConfig dengineConfig;

    @Autowired
    private TDDeviceLogMapper deviceLogMapper;

    @Autowired
    private ApplicationContext applicationContext;

    @Autowired
    private DeviceMapper deviceMapper;

    @Autowired
    @Qualifier("mysqlSqlSessionTemplate")
    private SqlSessionTemplate mysqlSqlSessionTemplate;

    @Autowired
    @Qualifier("tdengineSqlSessionTemplate")
    private SqlSessionTemplate tdengineSqlSessionTemplate;

    @Override
    public void run(ApplicationArguments args) {
        printBean();
        deviceMapper.selectDeviceByDeviceId(0L);
        System.out.println("初始化MySql链接成功");
        initTDengine();
        System.out.println("初始化TDengine链接成功");
    }

    /**
     * 开始初始化加载系统参数
     */
    public void initTDengine() {
        try {
            String dbName = dengineConfig.getDbName();
            int db = deviceLogMapper.createDB(dbName);
            deviceLogMapper.createSTable(dbName);

            System.out.println(db);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ERROR");
        }

    }

    private void printBean(){
        String[] beanDefinitionNames = applicationContext.getBeanDefinitionNames();
        for (int i = 0; i < beanDefinitionNames.length; i++) {
            System.out.println(beanDefinitionNames[i]);

        }
    }
}
