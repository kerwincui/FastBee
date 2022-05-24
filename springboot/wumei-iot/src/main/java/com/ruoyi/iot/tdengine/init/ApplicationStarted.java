package com.ruoyi.iot.tdengine.init;


import com.ruoyi.iot.tdengine.config.TDengineConfig;
import com.ruoyi.iot.tdengine.dao.TDDeviceLogDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.ApplicationContext;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;

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
    private ApplicationContext applicationContext;

    @Override
    public void run(ApplicationArguments args) {
        //先获取TDengine的配置，检测TDengine是否已经配置
        if (containBean(TDengineConfig.class)) {
            TDengineConfig tDengineConfig = applicationContext.getBean(TDengineConfig.class);
            TDDeviceLogDAO tDDeviceLogDAO = applicationContext.getBean(TDDeviceLogDAO.class);
            initTDengine(tDengineConfig, tDDeviceLogDAO);
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
    public void initTDengine(TDengineConfig dengineConfig, TDDeviceLogDAO deviceLogMapper) {
        try {
            String dbName = dengineConfig.getDbName();
            // TODO 目前还不支持自动创建数据库
            int db = deviceLogMapper.createDB(dbName);
            deviceLogMapper.createSTable(dbName);
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
