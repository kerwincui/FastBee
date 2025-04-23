package com.fastbee.common.core.domain;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * @author admin
 * @version 1.0
 * @description: 分页参数基础类
 * @date 2024-11-15 18:00
 */
@Data
public class PageEntity implements Serializable {

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @TableField(exist = false)
    private Integer pageNum;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @TableField(exist = false)
    private Integer pageSize;
    /**
     * 当前记录起始索引 默认值
     */
    public static final int DEFAULT_PAGE_NUM = 1;

    /**
     * 每页显示记录数 默认值 默认查全部
     */
    public static final int DEFAULT_PAGE_SIZE = Integer.MAX_VALUE;

    /**
     * 构建分页对象
     */
    public <T> Page<T> buildPage() {
        Integer pageNum = ObjectUtil.defaultIfNull(this.pageNum, DEFAULT_PAGE_NUM);
        Integer pageSize = ObjectUtil.defaultIfNull(this.pageSize, DEFAULT_PAGE_SIZE);
        if (pageNum <= 0) {
            pageNum = DEFAULT_PAGE_NUM;
        }
        Page<T> page = new Page<>(pageNum, pageSize);
        return page;
    }

    /**
     * 请求参数
     */
    @TableField(exist = false)
    @ApiModelProperty("请求参数")
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private Map<String, Object> params;

    public Map<String, Object> getParams() {
        if (params == null) {
            params = new HashMap<>();
        }
        return params;
    }

    public Integer getPageNum() {
        return ObjectUtil.defaultIfNull(this.pageNum, DEFAULT_PAGE_NUM);
    }

    public Integer getPageSize() {
        return ObjectUtil.defaultIfNull(this.pageSize, DEFAULT_PAGE_SIZE);
    }
}
