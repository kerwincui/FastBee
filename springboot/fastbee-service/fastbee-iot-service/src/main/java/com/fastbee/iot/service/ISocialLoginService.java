package com.fastbee.iot.service;

import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.domain.model.BindLoginBody;
import com.fastbee.common.core.domain.model.BindRegisterBody;
import com.fastbee.iot.domain.SocialUser;
import me.zhyd.oauth.model.AuthCallback;
import me.zhyd.oauth.model.AuthUser;

import jakarta.servlet.http.HttpServletRequest;

/**
 * 第三方登录Service接口
 * 处理登录跳转业务逻辑
 *
 * @author json
 * @date 2022-04-12
 */
public interface ISocialLoginService {

    /**
     * 第三方登录跳转
     *
     * @param source             平台
     * @param httpServletRequest 当前请求
     * @return 跳转路径
     */
    String renderAuth(String source, HttpServletRequest httpServletRequest);

    /**
     * 第三方登录callback
     *
     * @param source             平台
     * @param authCallback       回调参数
     * @param httpServletRequest 当前请求
     * @return 跳转路径
     */
    String callback(String source, AuthCallback authCallback, HttpServletRequest httpServletRequest);

    /**
     * 检查是否bindId
     *
     * @param bindId 绑定id
     * @return
     */
    AjaxResult checkBindId(String bindId);

    /**
     * 获得错误显示
     *
     * @param errorId errorId
     * @return
     */
    AjaxResult getErrorMsg(String errorId);

    /**
     * 跳转直接登录
     *
     * @param loginId 登录id
     * @return
     */
    AjaxResult socialLogin(String loginId);

    /**
     * 绑定登录api
     *
     * @param bindLoginBody 绑定账户参数
     * @return
     */
    AjaxResult bindLogin(BindLoginBody bindLoginBody);

    /**
     * 注册绑定api
     *
     * @param bindRegisterBody
     * @return
     */
    AjaxResult bindRegister(BindRegisterBody bindRegisterBody);

    String genBindId(AuthUser authUser);

    String genErrorId(String msg);

    String genWxBindId(Long userId);

    SocialUser findSocialUser(String uuid, String source);

    AjaxResult checkSocialUser(SocialUser socialUser, String bindId);
}
