package com.ruoyi.framework.web.service;


import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.exception.CustomException;
import com.ruoyi.common.exception.user.UserPasswordNotMatchException;
import com.ruoyi.common.utils.MessageUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.sign.Md5Utils;
import com.ruoyi.framework.manager.AsyncManager;
import com.ruoyi.framework.manager.factory.AsyncFactory;
import com.ruoyi.system.domain.TUserAccountInfo;
import com.ruoyi.system.domain.TUserLoginLog;
import com.ruoyi.system.mapper.TUserAccountInfoMapper;
import com.ruoyi.system.mapper.TUserLoginLogMapper;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 类名: AuthServiceImpl
 * 描述: TODO
 * 时间: 2021-08-11,0011 12:34
 * 开发人: admin
 */
@Service
public class AuthService {

    @Autowired
    private TUserAccountInfoMapper userAccountInfoMapper;

    @Autowired
    private TUserLoginLogMapper userLoginLogMapper;

    @Autowired
    private TokenService tokenService;

    @Resource
    private AuthenticationManager authenticationManager;
    @Autowired
    private ISysUserService sysUserService;


    @Transactional
    public String mpLogin(String code, String openId, String sessionKey, String accessToken) {
        //查询用户是否存在，不存在创建
        SysUser sysUser = sysUserService.selectUserByOpenId(openId);
        if(sysUser==null)
        {
            //创建用户
            sysUser=new SysUser();
            sysUser.setOpenId(openId);
            sysUser.setNickName("微信注册用户");
            sysUser.setPassword("123456");
            sysUser.setUserName(Md5Utils.hash(openId).toUpperCase().substring(20));
            sysUser.setCreateBy("微信小程序");
            sysUser.setPassword(SecurityUtils.encryptPassword(sysUser.getPassword()));
            sysUserService.insertUser(sysUser);
        }
//        Authentication authentication = null;
//        try {
//
//            // 该方法会去调用 UserDetailsServiceImpl.loadUserByUsername
//            authentication = authenticationManager
//                    .authenticate(new UsernamePasswordAuthenticationToken(openId, sysUser.getPassword()));
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//        LoginUser loginUser = (LoginUser) authentication.getPrincipal();
        Set<String> permissions=new HashSet<>();
        permissions.add("*:*:*");
        LoginUser loginUser =  new LoginUser(sysUser,permissions);

        // 生成token
        String token= tokenService.createToken(loginUser);
        return token;

    }

//    public UserDetails loadUserByOpenId(String openId) {
//        TUserAccountInfoExample tUserAccountInfoExample = new TUserAccountInfoExample();
//        TUserAccountInfoExample.Criteria criteria = tUserAccountInfoExample.createCriteria();
//        criteria.andOpenIdEqualTo(openId);
//        TUserAccountInfo tUserAccountInfo = userAccountInfoMapper.selectOneByExample(tUserAccountInfoExample);
//        if (tUserAccountInfo == null) {
//            return null;
//        } else {
//            UserInfoDetails userInfoDetails = new UserInfoDetails(tUserAccountInfo);
//            return userInfoDetails;
//        }
//    }
}
