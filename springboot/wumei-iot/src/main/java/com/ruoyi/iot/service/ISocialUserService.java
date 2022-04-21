package com.ruoyi.iot.service;

import java.util.List;
import com.ruoyi.iot.domain.SocialUser;

/**
 * 用户第三方用户信息Service接口
 * 
 * @author json
 * @date 2022-04-18
 */
public interface ISocialUserService 
{
    /**
     * 查询用户第三方用户信息
     * 
     * @param socialUserId 用户第三方用户信息主键
     * @return 用户第三方用户信息
     */
    public SocialUser selectSocialUserBySocialUserId(Long socialUserId);

    /**
     * 查询用户第三方用户信息列表
     * 
     * @param socialUser 用户第三方用户信息
     * @return 用户第三方用户信息集合
     */
    public List<SocialUser> selectSocialUserList(SocialUser socialUser);

    /**
     * 新增用户第三方用户信息
     * 
     * @param socialUser 用户第三方用户信息
     * @return 结果
     */
    public int insertSocialUser(SocialUser socialUser);

    /**
     * 修改用户第三方用户信息
     * 
     * @param socialUser 用户第三方用户信息
     * @return 结果
     */
    public int updateSocialUser(SocialUser socialUser);

    /**
     * 批量删除用户第三方用户信息
     * 
     * @param socialUserIds 需要删除的用户第三方用户信息主键集合
     * @return 结果
     */
    public int deleteSocialUserBySocialUserIds(Long[] socialUserIds);

    /**
     * 删除用户第三方用户信息信息
     * 
     * @param socialUserId 用户第三方用户信息主键
     * @return 结果
     */
    public int deleteSocialUserBySocialUserId(Long socialUserId);
}
