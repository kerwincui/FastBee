package com.ruoyi.iot.tdengine.config;

import com.alibaba.druid.pool.DruidDataSource;
import com.ruoyi.common.utils.StringUtils;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 类名: TDengineConfig
 * 描述: TDengine配置类
 * 时间: 2022/5/13,0016 1:14
 * 开发人: wxy
 */
@Configuration
@MapperScan(basePackages = {"com.ruoyi.iot.tdengine.dao"}, sqlSessionTemplateRef = "tdengineSqlSessionTemplate")
@ConditionalOnProperty(name = "spring.datasource.druid.tdengine-server.enabled", havingValue = "true")
public class TDengineConfig {

    @Value("${spring.datasource.druid.tdengine-server.dbName}")
    private String dbName;
    @Value("${spring.datasource.druid.tdengine-server.url}")
    private String jdbc;


    @Bean(name = "tDengineDataSource")
    @ConfigurationProperties(prefix = "spring.datasource.druid.tdengine-server")
    public DataSource tdengineDataSource() {
        return new DruidDataSource();
    }



    @Bean(name = "tDengineSqlSessionFactory")
    public SqlSessionFactory tDengineSqlSessionFactory(@Qualifier("tDengineDataSource") DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setMapperLocations(resolveMapperLocations(StringUtils.split("classpath:mapper/tdengine/*Mapper.xml", ",")));
        sqlSessionFactoryBean.setDataSource(dataSource);
        return sqlSessionFactoryBean.getObject();
    }


    @Bean(name = "tdengineSqlSessionTemplate")
    public SqlSessionTemplate tdengineSqlSessionTemplate(@Qualifier("tDengineSqlSessionFactory") SqlSessionFactory sqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory);
    }

    public String getDbName() {
        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName;
    }
    public Resource[] resolveMapperLocations(String[] mapperLocations)
    {
        ResourcePatternResolver resourceResolver = new PathMatchingResourcePatternResolver();
        List<Resource> resources = new ArrayList<Resource>();
        if (mapperLocations != null)
        {
            for (String mapperLocation : mapperLocations)
            {
                try
                {
                    Resource[] mappers = resourceResolver.getResources(mapperLocation);
                    resources.addAll(Arrays.asList(mappers));
                }
                catch (IOException e)
                {
                    // ignore
                }
            }
        }
        return resources.toArray(new Resource[resources.size()]);
    }


}
