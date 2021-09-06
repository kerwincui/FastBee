package com.ruoyi.common.config;

import com.ruoyi.common.constant.Constants;
import me.chanjar.weixin.mp.api.WxMpQrcodeService;
import me.chanjar.weixin.mp.api.WxMpService;
import me.chanjar.weixin.mp.api.impl.WxMpQrcodeServiceImpl;
import me.chanjar.weixin.mp.api.impl.WxMpServiceImpl;
import me.chanjar.weixin.mp.config.WxMpConfigStorage;
import me.chanjar.weixin.mp.config.impl.WxMpDefaultConfigImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 类名: WxConfig
 * 描述: TODO
 * 时间: 2021/1/10 13:08
 * 开发人: admin
 */
@Configuration
public class WxMpConfig {

    @Bean
    public WxMpConfigStorage wxMpConfigStorage() {

        WxMpDefaultConfigImpl wxMpInMemoryConfigStorage = new WxMpDefaultConfigImpl();
        //设置appid  这个在项目中肯定是通过配置来实现
        wxMpInMemoryConfigStorage.setAppId(Constants.wxAppId);
        //设置密码
        wxMpInMemoryConfigStorage.setSecret(Constants.wxAppSecret);
        return wxMpInMemoryConfigStorage;

    }

    @Bean//文档中需要用到这个对象
    public WxMpService wxMpService() {
        WxMpServiceImpl wxMpService = new WxMpServiceImpl();
        //设置微信配置的存储
        wxMpService.setWxMpConfigStorage(wxMpConfigStorage());
        return wxMpService;

    }

    @Bean//文档中需要用到这个对象
    public WxMpQrcodeService wxMpQrcodeService() {
        WxMpQrcodeService wxMpQrcodeService = new WxMpQrcodeServiceImpl(wxMpService());
        //设置微信配置的存储
        return wxMpQrcodeService;

    }
}
