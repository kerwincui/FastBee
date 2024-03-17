package com.fastbee.iot.mapper;

import com.fastbee.iot.domain.SocialUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 用户第三方用户信息Mapper接口
 *
 * @author json
 * @date 2022-04-18
 */
@Repository
public interface SocialUserMapper
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
     * 删除用户第三方用户信息
     *
     * @param socialUserId 用户第三方用户信息主键
     * @return 结果
     */
    public int deleteSocialUserBySocialUserId(Long socialUserId);

    /**
     * 批量删除用户第三方用户信息
     *
     * @param socialUserIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSocialUserBySocialUserIds(Long[] socialUserIds);

    /**
     * 根据openId和unionId获取用户第三方信息
     * @param openId
     * @param unionId
     * @return
     */
    SocialUser selectOneByOpenIdAndUnionId(@Param("openId") String openId, @Param("unionId") String unionId);

    /**
     * 通过unionId查询
     * @param unionId
     * @return
     */
    Long selectSysUserIdByUnionId(String unionId);

    /**
     * 通过系统用户id查询已绑定信息
     * @param sysUserId 系统用户id
     * @return
     */
    List<SocialUser> selectBySysUserId(Long sysUserId);

    /**
     * 取消三方登录相关信息
     * @param sysUserId 系统用户id
     * @param sourceClientList 来源具体平台
     * @return
     */
    int deleteBySysUserIdAndSourceClient(@Param("sysUserId") Long sysUserId, @Param("sourceClientList") List<String> sourceClientList);

    /**
     * 取消三方登录相关信息
     * @param sysUserIds 系统用户id集合
     * @param sourceClientList 来源具体平台
     * @return
     */
    int deleteBySysUserIdsAndSourceClient(@Param("sysUserIds") Long[] sysUserIds, @Param("sourceClientList") List<String> sourceClientList);
}
