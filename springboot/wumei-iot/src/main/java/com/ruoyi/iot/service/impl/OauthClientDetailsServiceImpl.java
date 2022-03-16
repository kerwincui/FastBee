package com.ruoyi.iot.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.iot.mapper.OauthClientDetailsMapper;
import com.ruoyi.iot.domain.OauthClientDetails;
import com.ruoyi.iot.service.IOauthClientDetailsService;

/**
 * 云云对接Service业务层处理
 * 
 * @author kerwincui
 * @date 2022-02-07
 */
@Service
public class OauthClientDetailsServiceImpl implements IOauthClientDetailsService 
{
    @Autowired
    private OauthClientDetailsMapper oauthClientDetailsMapper;

    /**
     * 查询云云对接
     * 
     * @param clientId 云云对接主键
     * @return 云云对接
     */
    @Override
    public OauthClientDetails selectOauthClientDetailsByClientId(String clientId)
    {
        return oauthClientDetailsMapper.selectOauthClientDetailsByClientId(clientId);
    }

    /**
     * 查询云云对接列表
     * 
     * @param oauthClientDetails 云云对接
     * @return 云云对接
     */
    @Override
    public List<OauthClientDetails> selectOauthClientDetailsList(OauthClientDetails oauthClientDetails)
    {
        return oauthClientDetailsMapper.selectOauthClientDetailsList(oauthClientDetails);
    }

    /**
     * 新增云云对接
     * 
     * @param oauthClientDetails 云云对接
     * @return 结果
     */
    @Override
    public int insertOauthClientDetails(OauthClientDetails oauthClientDetails)
    {
        return oauthClientDetailsMapper.insertOauthClientDetails(oauthClientDetails);
    }

    /**
     * 修改云云对接
     * 
     * @param oauthClientDetails 云云对接
     * @return 结果
     */
    @Override
    public int updateOauthClientDetails(OauthClientDetails oauthClientDetails)
    {
        return oauthClientDetailsMapper.updateOauthClientDetails(oauthClientDetails);
    }

    /**
     * 批量删除云云对接
     * 
     * @param clientIds 需要删除的云云对接主键
     * @return 结果
     */
    @Override
    public int deleteOauthClientDetailsByClientIds(String[] clientIds)
    {
        return oauthClientDetailsMapper.deleteOauthClientDetailsByClientIds(clientIds);
    }

    /**
     * 删除云云对接信息
     * 
     * @param clientId 云云对接主键
     * @return 结果
     */
    @Override
    public int deleteOauthClientDetailsByClientId(String clientId)
    {
        return oauthClientDetailsMapper.deleteOauthClientDetailsByClientId(clientId);
    }
}
