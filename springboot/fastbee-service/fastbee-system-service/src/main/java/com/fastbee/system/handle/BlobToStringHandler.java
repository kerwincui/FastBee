package com.fastbee.system.handle;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.io.ByteArrayInputStream;
import java.io.UnsupportedEncodingException;
import java.sql.*;

import static cn.hutool.core.io.file.FileWrapper.DEFAULT_CHARSET;


public class BlobToStringHandler extends BaseTypeHandler<String> {

    @Override
    public void setNonNullParameter(PreparedStatement preparedStatement, int i, String parameter, JdbcType jdbcType) throws SQLException {
        ByteArrayInputStream inputStream;
        byte[] bytes;
        bytes = parameter.getBytes(DEFAULT_CHARSET);
        // 把String转化成byte流
        inputStream = new ByteArrayInputStream(bytes);
        preparedStatement.setBinaryStream(i, inputStream, bytes.length);
    }

    @Override
    public String getNullableResult(ResultSet resultSet, String columnName) throws SQLException {
        Blob blob = resultSet.getBlob(columnName);
        return getBlobToString(blob);
    }

    @Override
    public String getNullableResult(ResultSet resultSet, int columnIndex) throws SQLException {
        Blob blob = resultSet.getBlob(columnIndex);
        return getBlobToString(blob);
    }

    @Override
    public String getNullableResult(CallableStatement callableStatement, int columnIndex) throws SQLException {
        Blob blob = callableStatement.getBlob(columnIndex);
        return getBlobToString(blob);
    }

    private String getBlobToString(Blob blob) throws SQLException {
        byte[] returnValue = null;
        String result = null;
        if (null != blob) {
            returnValue = blob.getBytes(1, (int) blob.length());
        }
        if (null != returnValue) {
            // 把byte转化成string
            result = new String(returnValue, DEFAULT_CHARSET);
        }
        return result;
    }
}
