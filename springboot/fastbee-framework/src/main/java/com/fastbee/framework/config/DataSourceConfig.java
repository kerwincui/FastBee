package com.fastbee.framework.config;

import com.baomidou.dynamic.datasource.DynamicRoutingDataSource;
import com.baomidou.dynamic.datasource.creator.DefaultDataSourceCreator;
import com.baomidou.dynamic.datasource.provider.AbstractDataSourceProvider;
import com.baomidou.dynamic.datasource.provider.DynamicDataSourceProvider;
import com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DynamicDataSourceProperties;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Configuration
public class DataSourceConfig {
    private final DynamicDataSourceProperties properties;
    private final DefaultDataSourceCreator dataSourceCreator;
    private final DataSource shardingSphereDataSource;

    public DataSourceConfig(DynamicDataSourceProperties properties,
                            DefaultDataSourceCreator dataSourceCreator,
                            @Lazy
                                     @Qualifier("shardingSphereDataSource") DataSource shardingSphereDataSource) {
        this.properties = properties;
        this.dataSourceCreator = dataSourceCreator;
        this.shardingSphereDataSource = shardingSphereDataSource;
    }


    @Bean
    public DynamicDataSourceProvider dynamicDataSourceProvider() {
        return new AbstractDataSourceProvider(dataSourceCreator) {
            @Override
            public Map<String, DataSource> loadDataSources() {
                Map<String, DataSource> dataSourceMap = new HashMap<>();
                // 把 shardingSphereDataSource 加入多数据源，到时候使用的时候就可以 `@DS("shardingSphere")`
                if(null != shardingSphereDataSource) {
                    dataSourceMap.put("shardingSphere", shardingSphereDataSource);
                }
                return dataSourceMap;
            }
        };
    }

    @Primary
    @Bean
    public DataSource dataSource(List<DynamicDataSourceProvider> providers) {
        DynamicRoutingDataSource dataSource = new DynamicRoutingDataSource(providers);
        dataSource.setPrimary(properties.getPrimary());
        dataSource.setStrict(properties.getStrict());
        dataSource.setStrategy(properties.getStrategy());
        dataSource.setP6spy(properties.getP6spy());
        dataSource.setSeata(properties.getSeata());
        return dataSource;
    }


    @Bean
    public DataSourceTransactionManager transactionManager(DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }
}
