package com.ruoyi.iot.log.service.factory;

import com.alibaba.fastjson.JSONObject;
import com.ruoyi.framework.config.MyBatisConfig;
import com.ruoyi.iot.log.service.impl.MySqlLogServiceImpl;
import com.ruoyi.iot.log.service.impl.TdengineLogServiceImpl;
import com.ruoyi.iot.model.MonitorModel;
import com.ruoyi.iot.tdengine.config.TDengineConfig;
import com.ruoyi.iot.domain.DeviceLog;
import com.ruoyi.iot.log.service.ILogService;
import com.ruoyi.iot.mapper.DeviceLogMapper;
import com.ruoyi.iot.tdengine.mapper.TDDeviceLogMapper;
import com.ruoyi.iot.util.SnowflakeIdWorker;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.lang.Nullable;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 类名: DeviceLogServiceImpl
 * 描述: TODO
 * 时间: 2022/5/19,0019 18:09
 * 开发人: wxy
 */
@Component
public class LogServiceFactory {

    @Autowired
    private ApplicationContext applicationContext;

    @Bean
    public ILogService getLogService() {
        //先获取TDengine的配置，检测TDengine是否已经配置
        if (containBean(TDengineConfig.class)) {
            TDengineConfig tDengineConfig = applicationContext.getBean(TDengineConfig.class);
            TDDeviceLogMapper tDDeviceLogMapper = applicationContext.getBean(TDDeviceLogMapper.class);
            ILogService logService = new TdengineLogServiceImpl(tDengineConfig, tDDeviceLogMapper);
            return logService;
        } else if (containBean(MyBatisConfig.class)) {
            //没有配置TDengine，那么使用MySQL的日志配置
            DeviceLogMapper deviceLogMapper = applicationContext.getBean( DeviceLogMapper.class);
            ILogService logService = new MySqlLogServiceImpl(deviceLogMapper);
            return logService;
        } else {
            return null;
        }
    }

    /**
    * @Method containBean
    * @Description 根据类判断是否有对应bean
    * @Param 类
    * @return
    * @date 2022/5/22,0022 14:12
    * @author wxy
    *
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
