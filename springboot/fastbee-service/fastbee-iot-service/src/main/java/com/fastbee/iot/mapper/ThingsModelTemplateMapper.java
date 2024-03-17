package com.fastbee.iot.mapper;

import com.fastbee.iot.domain.ThingsModel;
import com.fastbee.iot.domain.ThingsModelTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 通用物模型Mapper接口
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Repository
public interface ThingsModelTemplateMapper
{
    /**
     * 查询通用物模型
     *
     * @param templateId 通用物模型主键
     * @return 通用物模型
     */
    public ThingsModelTemplate selectThingsModelTemplateByTemplateId(Long templateId);

    /**
     * 根据id数组查询通用物模型集合
     * @param templateIds
     * @return
     */
    public List<ThingsModelTemplate> selectThingsModelTemplateByTemplateIds (Long[] templateIds);

    /**
     * 查询通用物模型列表
     *
     * @param thingsModelTemplate 通用物模型
     * @return 通用物模型集合
     */
    public List<ThingsModelTemplate> selectThingsModelTemplateList(ThingsModelTemplate thingsModelTemplate);

    /**
     * 新增通用物模型
     *
     * @param thingsModelTemplate 通用物模型
     * @return 结果
     */
    public int insertThingsModelTemplate(ThingsModelTemplate thingsModelTemplate);

    /**
     * 修改通用物模型
     *
     * @param thingsModelTemplate 通用物模型
     * @return 结果
     */
    public int updateThingsModelTemplate(ThingsModelTemplate thingsModelTemplate);


    /**
     * 根据从机关联id更新模板信息
     * @param thingsModelTemplate
     * @return
     */
    public int updateTemplateByTempSlaveId(ThingsModelTemplate thingsModelTemplate);

    /**
     * 删除通用物模型
     *
     * @param templateId 通用物模型主键
     * @return 结果
     */
    public int deleteThingsModelTemplateByTemplateId(Long templateId);

    /**
     * 根据采集点模板ID删除通用物模型
     *
     * @param templateId 通用物模型主键
     * @return 结果
     */
    public int deleteThingsModelTemplateByVarTemplateId(Long templateId);

    /**
     * 批量删除通用物模型
     *
     * @param templateIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteThingsModelTemplateByTemplateIds(Long[] templateIds);


    /**
     * 根据模板id查询从机采集点列表
     *
     * @return 变量模板从机采集点集合
     */
    public List<ThingsModelTemplate> selectAllByTemplateId(Long templateId);

}
