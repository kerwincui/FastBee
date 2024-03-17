package com.fastbee.iot.service.impl;

import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.iot.domain.SocialUser;
import com.fastbee.iot.mapper.SocialUserMapper;
import com.fastbee.iot.service.ISocialUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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

    /**
     * 根据openId或unionId获取用户第三方信息
     * @param openId
     * @param unionId
     * @return
     */
    @Override
    public SocialUser selectOneByOpenIdAndUnionId(String openId, String unionId) {
        return socialUserMapper.selectOneByOpenIdAndUnionId(openId, unionId);
    }

    /**
     * 通过unionId查询
     *
     * @param unionId
     * @return
     */
    @Override
    public Long selectSysUserIdByUnionId(String unionId) {
        if (StringUtils.isEmpty(unionId)) {
            return null;
        }
        return socialUserMapper.selectSysUserIdByUnionId(unionId);
    }

    /**
     * 通过系统用户id查询已绑定信息
     * @param sysUserId 系统用户id
     * @return
     */
    @Override
    public List<SocialUser> selectBySysUserId(Long sysUserId) {
        return socialUserMapper.selectBySysUserId(sysUserId);
    }

    /**
     * 取消三方登录相关信息
     * @param sysUserId 系统用户id
     * @param sourceClientList 来源具体平台
     * @return
     */
    @Override
    public int cancelBind(Long sysUserId, List<String> sourceClientList) {
        return socialUserMapper.deleteBySysUserIdAndSourceClient(sysUserId, sourceClientList);
    }

    /**
     * 取消三方登录相关信息
     * @param sysUserIds 系统用户id集合
     * @param sourceClientList 来源具体平台
     * @return
     */
    @Override
    public int batchCancelBind(Long[] sysUserIds, List<String> sourceClientList) {
        return socialUserMapper.deleteBySysUserIdsAndSourceClient(sysUserIds, sourceClientList);
    }
}
