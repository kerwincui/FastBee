package com.fastbee.iot.service.impl;

import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.SocialPlatform;
import com.fastbee.iot.mapper.SocialPlatformMapper;
import com.fastbee.iot.service.ISocialPlatformService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 第三方登录平台控制Service业务层处理
 * 
 * @author kerwincui
 * @date 2022-04-11
 */
@Service
public class SocialPlatformServiceImpl implements ISocialPlatformService 
{
    @Autowired
    private SocialPlatformMapper socialPlatformMapper;

    /**
     * 查询第三方登录平台控制
     * 
     * @param socialPlatformId 第三方登录平台控制主键
     * @return 第三方登录平台控制
     */
    @Override
    public SocialPlatform selectSocialPlatformBySocialPlatformId(Long socialPlatformId)
    {
        return socialPlatformMapper.selectSocialPlatformBySocialPlatformId(socialPlatformId);
    }

    @Override
    public SocialPlatform selectSocialPlatformByPlatform(String platform) {
        return socialPlatformMapper.selectSocialPlatformByPlatform(platform);
    }

    /**
     * 查询第三方登录平台控制列表
     * 
     * @param socialPlatform 第三方登录平台控制
     * @return 第三方登录平台控制
     */
    @Override
    public List<SocialPlatform> selectSocialPlatformList(SocialPlatform socialPlatform)
    {
        return socialPlatformMapper.selectSocialPlatformList(socialPlatform);
    }

    /**
     * 新增第三方登录平台控制
     * 
     * @param socialPlatform 第三方登录平台控制
     * @return 结果
     */
    @Override
    public int insertSocialPlatform(SocialPlatform socialPlatform)
    {
        socialPlatform.setCreateTime(DateUtils.getNowDate());
        socialPlatform.setDelFlag("0");
        return socialPlatformMapper.insertSocialPlatform(socialPlatform);
    }

    /**
     * 修改第三方登录平台控制
     * 
     * @param socialPlatform 第三方登录平台控制
     * @return 结果
     */
    @Override
    public int updateSocialPlatform(SocialPlatform socialPlatform)
    {
        socialPlatform.setUpdateTime(DateUtils.getNowDate());
        return socialPlatformMapper.updateSocialPlatform(socialPlatform);
    }

    /**
     * 批量删除第三方登录平台控制
     * 
     * @param socialPlatformIds 需要删除的第三方登录平台控制主键
     * @return 结果
     */
    @Override
    public int deleteSocialPlatformBySocialPlatformIds(Long[] socialPlatformIds)
    {
        return socialPlatformMapper.deleteSocialPlatformBySocialPlatformIds(socialPlatformIds);
    }

    /**
     * 删除第三方登录平台控制信息
     * 
     * @param socialPlatformId 第三方登录平台控制主键
     * @return 结果
     */
    @Override
    public int deleteSocialPlatformBySocialPlatformId(Long socialPlatformId)
    {
        return socialPlatformMapper.deleteSocialPlatformBySocialPlatformId(socialPlatformId);
    }
}
