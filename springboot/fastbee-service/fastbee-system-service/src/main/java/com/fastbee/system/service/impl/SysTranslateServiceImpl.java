package com.fastbee.system.service.impl;

import com.fastbee.common.enums.TranslateType;
import com.fastbee.system.domain.SysTranslate;
import com.fastbee.system.mapper.SysTranslateMapper;
import com.fastbee.system.service.ISysTranslateService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

import static com.fastbee.common.constant.Constants.*;

/**
 * 翻译Service业务层处理
 *
 * @author kerwincui
 * @date 2024-05-29
 */
@Service
public class SysTranslateServiceImpl implements ISysTranslateService
{
    @Resource
    private SysTranslateMapper sysTranslateMapper;

    /**
     * 导入翻译列表
     * @param list
     * @return
     */
    public void importSysTranslate(List<SysTranslate> list, String type, Long productId) {
        TranslateType translateType = matchTranslateType(type);
        if (translateType == null) {
            return;
        }
        for (SysTranslate sysTranslate : list) {
            sysTranslate.setTableName(translateType.getTranslateTable());
            sysTranslate.setProductId(productId);
            sysTranslateMapper.insertSysTranslate(sysTranslate);
        }
    }

    /**
     * 查询翻译列表
     * @param sysTranslate 翻译类
     * @return 翻译列表
     */
    @Override
    public List<SysTranslate> selectSysTranslateList(SysTranslate sysTranslate, String type)
    {
        TranslateType translateType = matchTranslateType(type);
        if (translateType == null) {
            return null;
        }
        sysTranslate.setTableName(translateType.getTranslateTable());
        return sysTranslateMapper.selectSysTranslateList(sysTranslate);
    }

    /**
     * 查询原表数据列表
     * @param type
     * @return
     */
    @Override
    public List<SysTranslate> selectSourceList(String type, Long productId) {
        TranslateType translateType = matchTranslateType(type);
        if (translateType == null) {
            return null;
        }
        return sysTranslateMapper.selectSourceList(translateType.getSourceTable(), translateType.getIdColumn(), translateType.getNameColumn(), productId);
    }

    /**
     * 根据type匹配对应的翻译类型
     * @param type
     * @return
     */
    public TranslateType matchTranslateType(String type) {
        switch (type) {
            case MENU:
                return TranslateType.MENU_TYPE;
            case DICT_DATA:
                return TranslateType.DICT_DATA_TYPE;
            case DICT_TYPE:
                return TranslateType.DICT_TYPE_TYPE;
            case THINGS_MODEL:
                return TranslateType.THINGS_MODEL_TYPE;
            case THINGS_MODEL_TEMPLATE:
                return TranslateType.THINGS_MODEL_TEMPLATE_TYPE;
            default:
                return null;
        }
    }

}
