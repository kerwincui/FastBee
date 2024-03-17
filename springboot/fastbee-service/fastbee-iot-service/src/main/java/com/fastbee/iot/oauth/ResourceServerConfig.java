package com.fastbee.iot.oauth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationManager;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.security.oauth2.provider.token.store.JdbcTokenStore;

import javax.sql.DataSource;

@Configuration
@EnableResourceServer
public class ResourceServerConfig extends ResourceServerConfigurerAdapter {

    @Autowired
    private DataSource dataSource;

    @Override
    public void configure(ResourceServerSecurityConfigurer resources) throws Exception {
        TokenStore tokenStore = jdbcTokenStore();
        OAuth2AuthenticationManager auth2AuthenticationManager= new OAuth2AuthenticationManager();
        resources.authenticationManager(auth2AuthenticationManager);
        resources.resourceId("speaker-service").tokenStore(tokenStore).stateless(true);
    }

    @Override
    public void configure(HttpSecurity http) throws Exception {
        // 限制资源服务器只接管匹配的资源
        http.requestMatchers().antMatchers("/oauth/speaker/**")
                .and()
                //授权的请求
                .authorizeRequests()
                .anyRequest().authenticated()
                //关闭跨站请求防护
                .and()
                .csrf().disable();
    }

    public TokenStore jdbcTokenStore(){
        TokenStore tokenStore = new JdbcTokenStore(dataSource);
        return tokenStore;
    }

}