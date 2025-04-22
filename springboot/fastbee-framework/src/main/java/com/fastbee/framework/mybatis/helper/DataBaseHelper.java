package com.fastbee.framework.mybatis.helper;

import cn.hutool.core.convert.Convert;
import com.baomidou.dynamic.datasource.DynamicRoutingDataSource;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.mabatis.enums.DataBaseType;
import com.fastbee.common.utils.spring.SpringUtils;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * 数据库助手
 *
 * @author Lion Li
 */
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class DataBaseHelper {

    private static final DynamicRoutingDataSource DS = SpringUtils.getBean(DynamicRoutingDataSource.class);
    public static final String DEFAULT_DATASOURCE_NAME = "master";

    /**
     * 获取当前数据库类型
     */
    public static DataBaseType getDataBaseType(String dataName) {
        DataSource dataSource = DS.getDataSources().get(dataName);
        try (Connection conn = dataSource.getConnection()) {
            DatabaseMetaData metaData = conn.getMetaData();
            String databaseProductName = metaData.getDatabaseProductName();
            return DataBaseType.find(databaseProductName);
        } catch (SQLException e) {
            throw new ServiceException(e.getMessage());
        }
    }

    public static boolean isMySql() {
        return DataBaseType.MY_SQL == getDataBaseType(DEFAULT_DATASOURCE_NAME);
    }

    public static boolean isOracle() {
        return DataBaseType.ORACLE == getDataBaseType(DEFAULT_DATASOURCE_NAME);
    }

    public static boolean isPostgerSql() {
        return DataBaseType.POSTGRE_SQL == getDataBaseType(DEFAULT_DATASOURCE_NAME);
    }

    public static boolean isSqlServer() {
        return DataBaseType.SQL_SERVER == getDataBaseType(DEFAULT_DATASOURCE_NAME);
    }

    public static boolean isDm() {
        return DataBaseType.DM == getDataBaseType(DEFAULT_DATASOURCE_NAME);
    }

    public static boolean isMySql(String dataName) {
        return DataBaseType.MY_SQL == getDataBaseType(dataName);
    }

    public static boolean isOracle(String dataName) {
        return DataBaseType.ORACLE == getDataBaseType(dataName);
    }

    public static boolean isPostgerSql(String dataName) {
        return DataBaseType.POSTGRE_SQL == getDataBaseType(dataName);
    }

    public static boolean isSqlServer(String dataName) {
        return DataBaseType.SQL_SERVER == getDataBaseType(dataName);
    }

    public static boolean isDm(String dataName) {
        return DataBaseType.DM == getDataBaseType(dataName);
    }

    public static String findInSet(Object var1, String var2) {
        DataBaseType dataBasyType = getDataBaseType(DEFAULT_DATASOURCE_NAME);
        String var = Convert.toStr(var1);
        if (dataBasyType == DataBaseType.SQL_SERVER) {
            // charindex(',100,' , ',0,100,101,') <> 0
            return String.format("charindex(',%s,' , ','+%s+',') <> 0", var, var2);
        } else if (dataBasyType == DataBaseType.POSTGRE_SQL) {
            // (select strpos(',0,100,101,' , ',100,')) <> 0
            return String.format("(select strpos(','||%s||',' , ',%s,')) <> 0", var2, var);
        } else if (dataBasyType == DataBaseType.ORACLE || dataBasyType == DataBaseType.DM) {
            // instr(',0,100,101,' , ',100,') <> 0
            return String.format("instr(','||%s||',' , ',%s,') <> 0", var2, var);
        }
        // find_in_set(100 , '0,100,101')
        return String.format("find_in_set(%s , %s) <> 0", var, var2);
    }

    public static String findInSetColumn(String var1, String var2) {
        DataBaseType dataBasyType = getDataBaseType(DEFAULT_DATASOURCE_NAME);
        String var = Convert.toStr(var1);
        if (dataBasyType == DataBaseType.SQL_SERVER) {
            // charindex(','+de.dept_id+',' , ',0,100,101,') <> 0
            return String.format("charindex(',' + %s + ',' , ',' + %s + ',') <> 0", var, var2);
        } else if (dataBasyType == DataBaseType.POSTGRE_SQL) {
            // (select strpos(',0,100,101,' , ',' || de.dept_id || ',')) <> 0
            return String.format("(select strpos(','||%s||',' , ','|| %s ||',')) <> 0", var2, var);
        } else if (dataBasyType == DataBaseType.ORACLE|| dataBasyType == DataBaseType.DM) {
            // instr(',0,100,101,' , ','||de.dept_id||',') <> 0
            return String.format("instr(','||%s||',' , ','||%s||',') <> 0", var2, var);
        }
        // find_in_set(de.dept_id , '0,100,101')
        return String.format("find_in_set(%s , '%s') <> 0", var, var2);
    }

    /**
     * 获取当前加载的数据库名
     */
    public static List<String> getDataSourceNameList() {
        return new ArrayList<>(DS.getDataSources().keySet());
    }

    public static String getDeptCondition(Long deptId) {
        if (deptId == null || deptId == 0) {
            // 无效条件，确保查询不会返回结果
            return "1=1";
        }
        if (isPostgerSql()) {
            return "SELECT u.user_id FROM sys_user u WHERE u.dept_id IN (SELECT dept_id FROM sys_dept WHERE " + deptId + "::text = ANY(string_to_array(ancestors, ',')) OR dept_id = " + deptId + ")";
        } else if (isSqlServer()) {
            return "SELECT u.user_id FROM sys_user u WHERE u.dept_id IN (SELECT dept_id FROM sys_dept WHERE CHARINDEX(',' + CAST(" + deptId + " AS VARCHAR) + ',', ',' + ancestors + ',') > 0 OR dept_id = " + deptId + ")";
        } else if (isOracle()) {
            return "SELECT u.user_id FROM sys_user u WHERE u.dept_id IN (SELECT dept_id FROM sys_dept WHERE INSTR(',' || ancestors || ',', ',' || " + deptId + " || ',') > 0 OR dept_id = " + deptId + ")";
        } else if (isDm()) {
            return "SELECT u.user_id FROM sys_user u WHERE u.dept_id IN (SELECT dept_id FROM sys_dept WHERE INSTR(',' || ancestors || ',', ',' || " + deptId + " || ',') > 0 OR dept_id = " + deptId + ")";
        } else if (isMySql()) {
            return "SELECT u.user_id FROM sys_user u WHERE u.dept_id IN (SELECT dept_id FROM sys_dept WHERE FIND_IN_SET(" + deptId + ", ancestors) > 0 OR dept_id = " + deptId + ")";
        } else {
            throw new UnsupportedOperationException("Unsupported database type");
        }
    }

    public static String checkTime(Integer timeout) {
        if (timeout == null || timeout == 0) {
            // 无效条件，确保查询不会返回结果
            return "";
        }
        if (isPostgerSql()) {
            return "CURRENT_TIMESTAMP > last_connect_time + interval '1 seconds' * " + timeout;
        } else if (isSqlServer()) {
            return "CURRENT_TIMESTAMP > DATEADD(SECOND, " + timeout + " last_connect_time)";
        } else if (isOracle()) {
            return "CURRENT_TIMESTAMP > last_connect_time + (" + timeout + " / 86400)";
        } else if (isDm()) {
            return "CURRENT_TIMESTAMP > DATEADD(SECOND, " + timeout + ", last_connect_time)";
        } else if (isMySql()) {
            return "CURRENT_TIMESTAMP > DATE_ADD(last_connect_time, INTERVAL " + timeout + " SECOND)";
        } else {
            throw new UnsupportedOperationException("Unsupported database type");
        }
    }

}
