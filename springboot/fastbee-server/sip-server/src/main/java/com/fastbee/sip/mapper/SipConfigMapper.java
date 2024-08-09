package com.fastbee.sip.mapper;

import com.fastbee.sip.domain.SipConfig;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * sip系统配置Mapper接口
 *
 * @author zhuangpeng.li
 * @date 2022-11-30
 */
@Repository
public interface SipConfigMapper
{
    /**
     * 查询产品下第一条sip系统配置
     *
     * @return sip系统配置
     */
    public SipConfig selectSipConfigByProductId(Long productId);
    /**
     * 查询sip系统配置列表
     *
     * @param sipConfig sip系统配置
     * @return sip系统配置集合
     */
    public List<SipConfig> selectSipConfigList(SipConfig sipConfig);

    /**
     * 新增sip系统配置
     *
     * @param sipConfig sip系统配置
     * @return 结果
     */
    public int insertSipConfig(SipConfig sipConfig);

    /**
     * 修改sip系统配置
     *
     * @param sipConfig sip系统配置
     * @return 结果
     */
    public int updateSipConfig(SipConfig sipConfig);

    public int resetDefaultSipConfig();

    /**
     * 删除sip系统配置
     *
     * @param id sip系统配置主键
     * @return 结果
     */
    public int deleteSipConfigById(Long id);

    /**
     * 批量删除sip系统配置
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSipConfigByIds(Long[] ids);

    public int deleteSipConfigByProductId(Long[] productIds);
}
