package com.fastbee.iot.tsdb.init;

import com.alibaba.druid.pool.DruidDataSource;
import com.fastbee.iot.tsdb.config.InfluxConfig;
import com.fastbee.iot.tsdb.config.IotDbConfig;
import com.fastbee.iot.tsdb.config.TDengineConfig;
import com.fastbee.iot.tsdb.service.ILogService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 * 类名: ApplicationStarted
 * 时间: 2022/5/18,0018 1:41
 * 开发人: wxy
 */
@Slf4j
@Component
public class ApplicationStarted {
    @Resource
    private ILogService tsdbService;
    @Resource
    private TDengineConfig tDengineConfig;
    @Resource
    private InfluxConfig influxConfig;
    @Resource
    private IotDbConfig iotDbConfig;

    @PostConstruct
    public void run() {
        //同时只能启用一个时序数据库
        // 缓存配置状态以减少重复调用
        boolean isTDengineEnabled = tDengineConfig.isEnabled();
        boolean isInfluxEnabled = influxConfig.isEnabled();
        boolean isIoTDBEnabled = iotDbConfig.isEnabled();

        // 检查是否同时启用了多个时序数据库
        int enabledCount = (isTDengineEnabled ? 1 : 0) + (isInfluxEnabled ? 1 : 0) + (isIoTDBEnabled ? 1 : 0);
        if (enabledCount > 1) {
            log.error("只能启用一个时序数据库，当前启用的数据库包括："
                    + (isTDengineEnabled ? "TDengine, " : "")
                    + (isInfluxEnabled ? "Influx, " : "")
                    + (isIoTDBEnabled ? "IoTDB" : ""));
            return;
        }
        // 根据配置选择时序数据库
        if (isTDengineEnabled) {
            try {
                initTDengine(tDengineConfig.getDbName());
                log.info("使用TDengine存储设备数据，初始化成功，数据库名称: {}", tDengineConfig.getDbName());
            } catch (Exception e) {
                log.error("TDengine初始化失败，数据库名称: {}, 错误信息: {}", tDengineConfig.getDbName(), e.getMessage(), e);
            }
        } else if (isInfluxEnabled) {
            log.info("使用Influx存储设备数据，初始化成功");
        } else if (isIoTDBEnabled) {
            initIoTDB(iotDbConfig.getDbName());
            log.info("使用IoTDB存储设备数据，初始化成功");
        } else {
            log.info("未启用任何时序数据库，使用Mysql存储设备数据，初始化成功");
        }
    }

    public void initIoTDB(String dbName) {
        tsdbService.createSTable(dbName);
        log.info("完成IoTDB超级表的创建");
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
            tsdbService.createSTable(dbName);
            log.info("完成超级表的创建");
        } catch (Exception e) {
            log.error("错误", e.getMessage());
            e.printStackTrace();
        }

    }

    /**
     * @return
     * @Method
     * @Description 根据数据库连接自动创建数据库
     * @Param null
     * @date 2022/5/24,0024 14:32
     * @author wxy
     */
    private void createDatabase() {
        try {
            //去掉数据库名
            String jdbcUrl = tDengineConfig.getUrl();
            int startIndex = jdbcUrl.indexOf('/', 15);
            int endIndex = jdbcUrl.indexOf('?');
            String newJdbcUrl = jdbcUrl.substring(0, startIndex);
            newJdbcUrl = newJdbcUrl + jdbcUrl.substring(endIndex);

            DruidDataSource dataSource = new DruidDataSource();
            dataSource.setUrl(newJdbcUrl);
            dataSource.setUsername(tDengineConfig.getUsername());
            dataSource.setPassword(tDengineConfig.getPassword());
            if (tDengineConfig.getUrl().contains("jdbc:TAOS://")) {
                dataSource.setDriverClassName("com.taosdata.jdbc.TSDBDriver");
            } else if (tDengineConfig.getUrl().contains("jdbc:TAOS-WS://")) {
                dataSource.setDriverClassName("com.taosdata.jdbc.ws.WebSocketDriver");
            } else if(tDengineConfig.getUrl().contains("jdbc:TAOS-RS://")) {
                dataSource.setDriverClassName("com.taosdata.jdbc.rs.RestfulDriver");
            }
            Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(String.format("create database if not exists %s;", tDengineConfig.getDbName()));
            boolean resultS = ps.execute();
            log.info("完成数据库创建:{}",resultS);
        } catch (Exception e) {
            log.info("错误", e.getMessage());
            e.printStackTrace();
        }
    }
}
