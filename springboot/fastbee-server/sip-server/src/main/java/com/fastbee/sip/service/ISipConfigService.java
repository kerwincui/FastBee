package com.fastbee.sip.service;

import com.fastbee.sip.conf.SysSipConfig;
import com.fastbee.sip.domain.SipConfig;

/**
 * sip系统配置Service接口
 *
 * @author zhuangpeng.li
 * @date 2022-11-30
 */
public interface ISipConfigService
{
    void updateDefaultSipConfig(SipConfig sipConfig);
    SipConfig GetDefaultSipConfig();
    /**
     * 查询产品下第一条sip系统配置
     *
     * @param id sip系统配置主键
     * @return sip系统配置
     */
    SipConfig selectSipConfigByProductId(Long productId);
    SipConfig selectSipConfigBydeviceSipId(String deviceSipId);

    /**
     * 新增sip系统配置
     *
     * @param sipConfig sip系统配置
     * @return 结果
     */
    int insertSipConfig(SipConfig sipConfig);

    /**
     * 修改sip系统配置
     *
     * @param sipConfig sip系统配置
     * @return 结果
     */
    int updateSipConfig(SipConfig sipConfig);
    void  syncSipConfig(SysSipConfig sipConfig);

    /**
     * 批量删除sip系统配置
     *
     * @param ids 需要删除的sip系统配置主键集合
     * @return 结果
     */
    int deleteSipConfigByIds(Long[] ids);
    int deleteSipConfigByProductIds(Long[] productIds);
}
