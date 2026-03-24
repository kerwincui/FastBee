package com.fastbee.system.domain;

import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;
import lombok.Data;

/**
 * 翻译对象 sys_translate
 *
 * @author ruoyi
 */
@Data
public class SysTranslate extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** ID */
    @Excel(name = "ID")
    private Long id;

    /** zh_CN */
    @Excel(name = "zh-CN")
    private String zh_CN;

    /** en_US */
    @Excel(name = "en-US")
    private String en_US;

    /** 物模型翻译表使用 */
    private Long productId;

    private String tableName;

}
