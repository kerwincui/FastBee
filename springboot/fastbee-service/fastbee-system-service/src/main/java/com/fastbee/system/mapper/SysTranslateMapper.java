package com.fastbee.system.mapper;

import com.fastbee.common.mybatis.mapper.BaseMapperX;
import com.fastbee.system.domain.SysTranslate;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 翻译Mapper接口
 *
 * @author kerwincui
 * @date 2024-05-29
 */
@Mapper
public interface SysTranslateMapper extends BaseMapperX<SysTranslate>
{

    /**
     * 新增或修改翻译
     *
     * @param sysTranslate 翻译
     * @return 结果
     */
    public int insertSysTranslate(SysTranslate sysTranslate);

    /**
     * 查询翻译列表
     *
     * @param sysTranslate 翻译
     * @return 翻译集合
     */
    public List<SysTranslate> selectSysTranslateList(SysTranslate sysTranslate);

    /**
     * 查询原表数据列表
     *
     * @param tableName 表名
     * @param idColumn id列名
     * @param nameColumn 名称列名
     * @return 翻译集合
     */
    public List<SysTranslate> selectSourceList(@Param("tableName") String tableName, @Param("idColumn") String idColumn, @Param("nameColumn") String nameColumn, @Param("productId") Long productId);

}
