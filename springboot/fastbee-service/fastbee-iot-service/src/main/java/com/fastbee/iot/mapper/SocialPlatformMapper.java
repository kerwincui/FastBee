package com.fastbee.iot.mapper;

import java.util.List;
import com.fastbee.iot.domain.SocialPlatform;
import org.springframework.stereotype.Repository;

/**
 * 第三方登录平台控制Mapper接口
 * 
 * @author kerwincui
 * @date 2022-04-11
 */
@Repository
public interface SocialPlatformMapper 
{
    /**
     * 查询第三方登录平台控制
     * 
     * @param socialPlatformId 第三方登录平台控制主键
     * @return 第三方登录平台控制
     */
    public SocialPlatform selectSocialPlatformBySocialPlatformId(Long socialPlatformId);

    /**
     * 查询第三方登录平台控制
     *
     * @param platform 第三方登录平台名称
     * @return 第三方登录平台控制
     */
    public SocialPlatform selectSocialPlatformByPlatform(String platform);

    /**
     * 查询第三方登录平台控制列表
     * 
     * @param socialPlatform 第三方登录平台控制
     * @return 第三方登录平台控制集合
     */
    public List<SocialPlatform> selectSocialPlatformList(SocialPlatform socialPlatform);

    /**
     * 新增第三方登录平台控制
     * 
     * @param socialPlatform 第三方登录平台控制
     * @return 结果
     */
    public int insertSocialPlatform(SocialPlatform socialPlatform);

    /**
     * 修改第三方登录平台控制
     * 
     * @param socialPlatform 第三方登录平台控制
     * @return 结果
     */
    public int updateSocialPlatform(SocialPlatform socialPlatform);

    /**
     * 删除第三方登录平台控制
     * 
     * @param socialPlatformId 第三方登录平台控制主键
     * @return 结果
     */
    public int deleteSocialPlatformBySocialPlatformId(Long socialPlatformId);

    /**
     * 批量删除第三方登录平台控制
     * 
     * @param socialPlatformIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSocialPlatformBySocialPlatformIds(Long[] socialPlatformIds);
}
