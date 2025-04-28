package com.fastbee.framework.mybatis.config;


import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.pagination.DialectFactory;
import com.baomidou.mybatisplus.extension.plugins.pagination.dialects.IDialect;
import com.baomidou.mybatisplus.extension.toolkit.JdbcUtils;
import org.apache.ibatis.executor.Executor;

import java.sql.Connection;
import java.sql.SQLException;

public class AutoPaginationInnerInterceptor extends PaginationInnerInterceptor {
    @Override
    protected IDialect findIDialect(Executor executor) {
        Connection conn = null;
        try {
            conn = executor.getTransaction().getConnection();
            String jdbcUrl = conn.getMetaData().getURL();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (this.getDialect() != null) {
            return this.getDialect();
        } else if (this.getDbType() != null) {
            this.setDialect(DialectFactory.getDialect(this.getDbType()));
            return this.getDialect();
        } else {
            return DialectFactory.getDialect(JdbcUtils.getDbType(executor));
        }
    }

}
