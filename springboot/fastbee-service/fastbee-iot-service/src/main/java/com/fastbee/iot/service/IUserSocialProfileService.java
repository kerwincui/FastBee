package com.fastbee.iot.service;

import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.iot.domain.UserSocialProfile;

import java.util.List;

public interface IUserSocialProfileService {
    /**
     * 找到用户绑定的社交账户
     *
     * @param sysUserId 用户主键
     * @return
     */
    List<UserSocialProfile> selectUserSocialProfile(Long sysUserId);

    /**
     * 绑定用户
     *
     * @param bindId    绑定的Id
     * @param sysUserId 用户主键
     * @return
     */
    AjaxResult bindUser(String bindId, Long sysUserId);

    /**
     * 点击绑定跳转api
     *
     * @param platform 平台
     * @return
     */
    AjaxResult bindSocialAccount(String platform);

    /**
     * 解除绑定
     *
     * @param socialUserId 要解除的社交账户主键
     * @param sysUserId    用户主键
     * @return
     */
    AjaxResult unbindSocialAccount(Long socialUserId, Long sysUserId);
}
