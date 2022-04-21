package com.ruoyi.iot.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.iot.mapper.SocialUserMapper;
import com.ruoyi.iot.domain.SocialUser;
import com.ruoyi.iot.service.ISocialUserService;

/**
 * 用户第三方用户信息Service业务层处理
 * 
 * @author json
 * @date 2022-04-18
 */
@Service
public class SocialUserServiceImpl implements ISocialUserService 
{
    @Autowired
    private SocialUserMapper socialUserMapper;

    /**
     * 查询用户第三方用户信息
     * 
     * @param socialUserId 用户第三方用户信息主键
     * @return 用户第三方用户信息
     */
    @Override
    public SocialUser selectSocialUserBySocialUserId(Long socialUserId)
    {
        return socialUserMapper.selectSocialUserBySocialUserId(socialUserId);
    }

    /**
     * 查询用户第三方用户信息列表
     * 
     * @param socialUser 用户第三方用户信息
     * @return 用户第三方用户信息
     */
    @Override
    public List<SocialUser> selectSocialUserList(SocialUser socialUser)
    {
        return socialUserMapper.selectSocialUserList(socialUser);
    }

    /**
     * 新增用户第三方用户信息
     * 
     * @param socialUser 用户第三方用户信息
     * @return 结果
     */
    @Override
    public int insertSocialUser(SocialUser socialUser)
    {
        socialUser.setCreateTime(DateUtils.getNowDate());
        return socialUserMapper.insertSocialUser(socialUser);
    }

    /**
     * 修改用户第三方用户信息
     * 
     * @param socialUser 用户第三方用户信息
     * @return 结果
     */
    @Override
    public int updateSocialUser(SocialUser socialUser)
    {
        socialUser.setUpdateTime(DateUtils.getNowDate());
        return socialUserMapper.updateSocialUser(socialUser);
    }

    /**
     * 批量删除用户第三方用户信息
     * 
     * @param socialUserIds 需要删除的用户第三方用户信息主键
     * @return 结果
     */
    @Override
    public int deleteSocialUserBySocialUserIds(Long[] socialUserIds)
    {
        return socialUserMapper.deleteSocialUserBySocialUserIds(socialUserIds);
    }

    /**
     * 删除用户第三方用户信息信息
     * 
     * @param socialUserId 用户第三方用户信息主键
     * @return 结果
     */
    @Override
    public int deleteSocialUserBySocialUserId(Long socialUserId)
    {
        return socialUserMapper.deleteSocialUserBySocialUserId(socialUserId);
    }
}
