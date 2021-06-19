/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/

package com.kerwin.wumei.entity;

public class DictData {

    /** 字典标签 */
    private String dictLabel;

    /** 字典键值 */
    private Integer dictValue;

    /** 字典编码 */
    private Long dictCode;

    /** 字典类型 */
    private String dictType;


    public Long getDictCode()
    {
        return dictCode;
    }
    public void setDictCode(Long dictCode)
    {
        this.dictCode = dictCode;
    }

    public String getDictLabel()
    {
        return dictLabel;
    }
    public void setDictLabel(String dictLabel)
    {
        this.dictLabel = dictLabel;
    }

    public Integer getDictValue()
    {
        return dictValue;
    }
    public void setDictValue(Integer dictValue)
    {
        this.dictValue = dictValue;
    }

    public String getDictType()
    {
        return dictType;
    }
    public void setDictType(String dictType)
    {
        this.dictType = dictType;
    }

}
