package com.ruoyi.iot.init;


//import com.ruoyi.mysql.config.TDengineConfig;

//import com.ruoyi.iot.tdengine.config.TDengineConfig;
import com.alibaba.druid.pool.DruidDataSource;
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

import javax.sql.DataSource;
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
    private DeviceMapper deviceMapper;

    @Override
    public void run(ApplicationArguments args) {
        deviceMapper.selectDeviceByDeviceId(0L);
        System.out.println("初始化MySql链接成功");
        initTDengine();
        System.out.println("初始化TDengine链接成功");
    }

    /**
    * @Method
    * @Description 开始初始化加载系统参数,创建数据库和超级表
    * @Param null
    * @return
    * @date 2022/5/22,0022 14:27
    * @author wxy
    *
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

}
