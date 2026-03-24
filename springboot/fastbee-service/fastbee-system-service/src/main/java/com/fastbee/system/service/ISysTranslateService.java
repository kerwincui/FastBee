package com.fastbee.system.service;


import com.fastbee.system.domain.SysTranslate;

import java.util.List;

/**
 * 翻译Service接口
 *
 * @author kerwincui
 * @date 2024-05-29
 */
public interface ISysTranslateService
{
    /**
     * 导入翻译列表
     * @param list
     * @return
     */
    public void importSysTranslate(List<SysTranslate> list, String type, Long productId);

    /**
     * 查询翻译列表
     * @param sysTranslate 翻译类
     * @return 翻译列表
     */
    public List<SysTranslate> selectSysTranslateList(SysTranslate sysTranslate, String type);

    /**
     * 查询原表数据列表
     * @param type
     * @return
     */
    public List<SysTranslate> selectSourceList(String type, Long productId);

}
