package com.ruoyi.iot.tdengine.init;


import com.alibaba.druid.pool.DruidDataSource;
import com.ruoyi.common.annotation.DataSource;
import com.ruoyi.iot.tdengine.config.TDengineConfig;
import com.ruoyi.iot.tdengine.dao.TDDeviceLogDAO;
import com.taosdata.jdbc.TSDBDriver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.ApplicationContext;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 类名: ApplicationStarted
 * 时间: 2022/5/18,0018 1:41
 * 开发人: wxy
 */
@Component
public class ApplicationStarted implements ApplicationRunner {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApplicationStarted.class);

    @Autowired
    private ApplicationContext applicationContext;

    private DruidDataSource dataSource;

    private TDengineConfig dengineConfig;

    private TDDeviceLogDAO deviceLogMapper;


    @Override
    public void run(ApplicationArguments args) {

        //先获取TDengine的配置，检测TDengine是否已经配置
        if (containBean(TDengineConfig.class)) {
            this.dengineConfig = applicationContext.getBean(TDengineConfig.class);
            this.dataSource = applicationContext.getBean("tDengineDataSource", DruidDataSource.class);
            this.deviceLogMapper= applicationContext.getBean(TDDeviceLogDAO.class);
            initTDengine(this.dengineConfig.getDbName());
            LOGGER.info("使用TDengine存储设备数据，初始化成功");
        }else{
            LOGGER.info("使用MySql存储设备数据，初始化成功");
        }
    }

    /**
     * @return
     * @Method
     * @Description 开始初始化加载系统参数, 创建数据库和超级表
     * @Param null
     * @date 2022/5/22,0022 14:27
     * @author wxy
     */
    public void initTDengine(String dbName) {
        try {
            createDatabase();
            //创建数据库表
            deviceLogMapper.createSTable(dbName);
            LOGGER.info("完成超级表的创建");
        } catch (Exception e) {
            LOGGER.error("错误",e.getMessage());
            e.printStackTrace();
        }

    }

    /**
    * @Method
    * @Description 根据数据库连接自动创建数据库
    * @Param null
    * @return
    * @date 2022/5/24,0024 14:32
    * @author wxy
    *
    */
    private void createDatabase(){
        try {
            String dbName = dengineConfig.getDbName();
            String jdbcUrl = dataSource.getRawJdbcUrl();
            String username = dataSource.getUsername();
            String password = dataSource.getPassword();
            jdbcUrl += ("&user=" + username);
            jdbcUrl += ("&password=" + password);
            int startIndex = jdbcUrl.indexOf('/',12);
            int endIndex = jdbcUrl.indexOf('?');
            String newJdbcUrl = jdbcUrl.substring(0,startIndex);
            newJdbcUrl= newJdbcUrl+jdbcUrl.substring(endIndex);
            System.out.println(newJdbcUrl);

            Properties connProps = new Properties();
            connProps.setProperty(TSDBDriver.PROPERTY_KEY_CHARSET, "UTF-8");
            connProps.setProperty(TSDBDriver.PROPERTY_KEY_LOCALE, "en_US.UTF-8");
            connProps.setProperty(TSDBDriver.PROPERTY_KEY_TIME_ZONE, "UTC-8");
            Connection conn = DriverManager.getConnection(newJdbcUrl, connProps);
            conn.createStatement().execute(String.format("create database  if not exists  %s;",dbName));
            conn.close();
            LOGGER.info("完成数据库创建");
        } catch (Exception e) {
            LOGGER.info("错误",e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * @return
     * @Method containBean
     * @Description 根据类判断是否有对应bean
     * @Param 类
     * @date 2022/5/22,0022 14:12
     * @author wxy
     */
    private boolean containBean(@Nullable Class<?> T) {
        String[] beans = applicationContext.getBeanNamesForType(T);
        if (beans == null || beans.length == 0) {
            return false;
        } else {
            return true;
        }
    }


}
