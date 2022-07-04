package com.ruoyi.iot.service.impl;

import com.ruoyi.common.annotation.DataScope;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.user.CaptchaException;
import com.ruoyi.common.exception.user.CaptchaExpireException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.MessageUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.manager.AsyncManager;
import com.ruoyi.framework.manager.factory.AsyncFactory;
import com.ruoyi.iot.domain.ProductAuthorize;
import com.ruoyi.iot.mapper.ProductAuthorizeMapper;
import com.ruoyi.iot.model.MqttAuthenticationModel;
import com.ruoyi.iot.model.ProductAuthenticateModel;
import com.ruoyi.iot.model.RegisterUserInput;
import com.ruoyi.iot.service.IDeviceService;
import com.ruoyi.iot.service.IToolService;
import com.ruoyi.iot.util.AESUtils;
import com.ruoyi.system.mapper.SysUserMapper;
import com.ruoyi.system.service.ISysConfigService;
import com.ruoyi.system.service.ISysUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.iot.mqtt.MqttConfig;

import java.util.List;
import java.util.Random;

/**
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@Service
public class ToolServiceImpl implements IToolService
{
    private static final Logger log = LoggerFactory.getLogger(ToolServiceImpl.class);

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private SysUserMapper userMapper;

    @Autowired
    private ProductAuthorizeMapper productAuthorizeMapper;

    @Autowired
    private MqttConfig mqttConfig;

    @Autowired
    @Lazy
    private IDeviceService deviceService;

    /**
     * 生成随机数字和字母
     */
    @Override
    public String getStringRandom(int length) {
        String val = "";
        Random random = new Random();
        //参数length，表示生成几位随机数
        for(int i = 0; i < length; i++) {
            String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";
            //输出字母还是数字
            if( "char".equalsIgnoreCase(charOrNum) ) {
                //输出是大写字母还是小写字母
                // int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;
                val += (char)(random.nextInt(26) + 65);
            } else if( "num".equalsIgnoreCase(charOrNum) ) {
                val += String.valueOf(random.nextInt(10));
            }
        }
        return val;
    }

    /**
     * 注册
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String register(RegisterUserInput registerBody)
    {
        String msg = "";
        String username = registerBody.getUsername();
        String password = registerBody.getPassword();
        String phonenumber=registerBody.getPhonenumber();

        boolean captchaOnOff = configService.selectCaptchaOnOff();
        // 验证码开关
        if (captchaOnOff)
        {
            validateCaptcha(username, registerBody.getCode(), registerBody.getUuid());
        }

        if (StringUtils.isEmpty(username))
        {
            msg = "用户名不能为空";
        }
        else if (StringUtils.isEmpty(password))
        {
            msg = "用户密码不能为空";
        }
        else if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH)
        {
            msg = "账户长度必须在2到20个字符之间";
        }
        else if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH)
        {
            msg = "密码长度必须在5到20个字符之间";
        }
        else if (UserConstants.NOT_UNIQUE.equals(userService.checkUserNameUnique(username)))
        {
            msg = "保存用户'" + username + "'失败，注册账号已存在";
        }else if (UserConstants.NOT_UNIQUE.equals(checkPhoneUnique(phonenumber)))
        {
            msg = "保存用户'" + username + "'失败，注册手机号码已存在";
        }
        else
        {
            SysUser sysUser = new SysUser();
            sysUser.setUserName(username);
            sysUser.setNickName(username);
            sysUser.setPhonenumber(phonenumber);
            sysUser.setPassword(SecurityUtils.encryptPassword(registerBody.getPassword()));
            boolean regFlag = userService.registerUser(sysUser);
            //分配普通用户角色(1=超级管理员，2=设备租户，3=普通用户，4=游客)
            Long[] roleIds={3L};
            userService.insertUserAuth(sysUser.getUserId(),roleIds);
            if (!regFlag)
            {
                msg = "注册失败,请联系系统管理人员";
            }
            else
            {
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.REGISTER,
                        MessageUtils.message("user.register.success")));
            }
        }
        return msg;
    }

    /**
     * 根据条件分页查询用户列表
     *
     * @param user 用户信息
     * @return 用户信息集合信息
     */
    @Override
    public List<SysUser> selectUserList(SysUser user)
    {
        return userMapper.selectUserList(user);
    }

    /**
     * 校验手机号码是否唯一
     *
     * @param phonenumber 手机号码
     * @return
     */
    public String checkPhoneUnique(String phonenumber)
    {
        SysUser info = userMapper.checkPhoneUnique(phonenumber);
        if (StringUtils.isNotNull(info))
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验验证码
     *
     * @param username 用户名
     * @param code 验证码
     * @param uuid 唯一标识
     * @return 结果
     */
    public void validateCaptcha(String username, String code, String uuid)
    {
        String verifyKey = Constants.CAPTCHA_CODE_KEY + uuid;
        String captcha = redisCache.getCacheObject(verifyKey);
        redisCache.deleteObject(verifyKey);
        if (captcha == null)
        {
            throw new CaptchaExpireException();
        }
        if (!code.equalsIgnoreCase(captcha))
        {
            throw new CaptchaException();
        }
    }

    /**
     * 设备简单认证
     */
    @Override
    public ResponseEntity simpleMqttAuthentication(MqttAuthenticationModel mqttModel, ProductAuthenticateModel productModel) {
        // 1=简单认证，2=加密认证，3=简单+加密认证
        if(productModel.getVertificateMethod()!=1 && productModel.getVertificateMethod()!=3){
            return returnUnauthorized(mqttModel, "设备简单认证，设备对应产品不支持简单认证");
        }
        String[] passwordArray = mqttModel.getPassword().split("&");
        if (productModel.getIsAuthorize() == 1 && passwordArray.length != 2) {
            return returnUnauthorized(mqttModel, "设备简单认证，产品启用授权码后，密码格式为：密码 & 授权码");
        }
        String mqttPassword = passwordArray[0];
        String authCode = passwordArray.length == 2 ? passwordArray[1] : "";
        // 验证用户名
        if (!mqttModel.getUserName().equals(productModel.getMqttAccount())) {
            return returnUnauthorized(mqttModel, "设备简单认证，设备mqtt用户名错误");
        }
        // 验证密码
        if (!mqttPassword.equals(productModel.getMqttPassword())) {
            return returnUnauthorized(mqttModel, "设备简单认证，设备mqtt密码错误");
        }
        // 验证授权码
        if (productModel.getIsAuthorize() == 1) {
            // 授权码验证和处理
            String resultMessage = authCodeProcess(authCode, mqttModel, productModel);
            if (!resultMessage.equals("")) {
                return returnUnauthorized(mqttModel, resultMessage);
            }
        }
        if (productModel.getDeviceId() != null && productModel.getDeviceId() != 0) {
            if (productModel.getStatus() == 2) {
                return returnUnauthorized(mqttModel, "设备简单认证，设备处于禁用状态");
            }
            log.info("-----------设备简单认证成功,clientId:" + mqttModel.getClientId() + "---------------");
            return ResponseEntity.ok().body("ok");
        } else {
            // 自动添加设备
            int result = deviceService.insertDeviceAuto(mqttModel.getDeviceNumber(), mqttModel.getUserId(), mqttModel.getProductId());
            if (result == 1) {
                log.info("-----------设备简单认证成功,并自动添加设备到系统，clientId:" + mqttModel.getClientId() + "---------------");
                return ResponseEntity.ok().body("ok");
            }
            return returnUnauthorized(mqttModel, "设备简单认证，自动添加设备失败");
        }
    }

    /**
     * 设备加密认证
     *
     * @return
     */
    @Override
    public ResponseEntity encryptAuthentication(MqttAuthenticationModel mqttModel, ProductAuthenticateModel productModel) throws Exception {
        // 1=简单认证，2=加密认证，3=简单+加密认证
        if(productModel.getVertificateMethod()!=2 && productModel.getVertificateMethod()!=3){
            return returnUnauthorized(mqttModel, "设备加密认证，设备对应产品不支持加密认证");
        }
        String decryptPassword = AESUtils.decrypt(mqttModel.getPassword(), productModel.getMqttSecret());
        if (decryptPassword == null || decryptPassword.equals("")) {
            return returnUnauthorized(mqttModel, "设备加密认证，mqtt密码解密失败");
        }
        String[] passwordArray = decryptPassword.split("&");
        if (passwordArray.length != 2 && passwordArray.length != 3) {
            // 密码加密格式 password & expireTime (& authCode 可选)
            return returnUnauthorized(mqttModel, "设备加密认证，mqtt密码加密格式为：密码 & 过期时间 & 授权码，其中授权码为可选");
        }
        String mqttPassword = passwordArray[0];
        Long expireTime = Long.valueOf(passwordArray[1]);
        String authCode = passwordArray.length == 3 ? passwordArray[2] : "";
        // 验证用户名
        if (!mqttModel.getUserName().equals(productModel.getMqttAccount())) {
            return returnUnauthorized(mqttModel, "设备加密认证，设备mqtt用户名错误");
        }
        // 验证密码
        if (!mqttPassword.equals(productModel.getMqttPassword())) {
            return returnUnauthorized(mqttModel, "设备加密认证，设备mqtt密码错误");
        }
        // 验证过期时间
        if (expireTime < System.currentTimeMillis()) {
            return returnUnauthorized(mqttModel, "设备加密认证，设备mqtt密码已过期");
        }
        // 验证授权码
        if (productModel.getIsAuthorize() == 1) {
            // 授权码验证和处理
            String resultMessage = authCodeProcess(authCode, mqttModel, productModel);
            if (!resultMessage.equals("")) {
                return returnUnauthorized(mqttModel, resultMessage);
            }
        }
        // 设备状态验证 （1-未激活，2-禁用，3-在线，4-离线）
        if (productModel.getDeviceId() != null && productModel.getDeviceId() != 0) {
            if (productModel.getStatus() == 2) {
                return returnUnauthorized(mqttModel, "设备加密认证，设备处于禁用状态");
            }
            log.info("-----------设备加密认证成功,clientId:" + mqttModel.getClientId() + "---------------");
            return ResponseEntity.ok().body("ok");
        } else {
            // 自动添加设备
            int result = deviceService.insertDeviceAuto(mqttModel.getDeviceNumber(), mqttModel.getUserId(), mqttModel.getProductId());
            if (result == 1) {
                log.info("-----------设备加密认证成功,并自动添加设备到系统，clientId:" + mqttModel.getClientId() + "---------------");
                return ResponseEntity.ok().body("ok");
            }
            return returnUnauthorized(mqttModel, "设备加密认证，自动添加设备失败");
        }
    }

    /**
     * 授权码认证和处理
     */
    private String authCodeProcess(String authCode, MqttAuthenticationModel mqttModel, ProductAuthenticateModel productModel) {
        String message = "";
        if (authCode.equals("")) {
            return message = "设备认证，设备授权码不能为空";
        }
        // 查询授权码是否存在
        ProductAuthorize authorize = productAuthorizeMapper.selectFirstAuthorizeByAuthorizeCode(new ProductAuthorize(authCode, productModel.getProductId()));
        if (authorize == null) {
            message = "设备认证，设备授权码错误";
            return message;
        }
        if (authorize.getSerialNumber() != null && !authorize.getSerialNumber().equals("")) {
            // 授权码已关联设备
            if (!authorize.getSerialNumber().equals( productModel.getSerialNumber())) {
                message = "设备认证，设备授权码已经分配给其他设备";
                return message;
            }
        } else {
            // 授权码未关联设备
            authorize.setSerialNumber(mqttModel.getDeviceNumber());
            authorize.setUserId(mqttModel.getUserId());
            authorize.setUserName("");
            authorize.setUpdateTime(DateUtils.getNowDate());
            // 状态（1-未使用，2-使用中）
            authorize.setStatus(2);
            int result = productAuthorizeMapper.updateProductAuthorize(authorize);
            if (result != 1) {
                message = "设备认证，设备授权码关联失败";
                return message;
            }
        }
        return message;
    }

    /**
     * 返回认证信息
     */
    @Override
    public ResponseEntity returnUnauthorized(MqttAuthenticationModel mqttModel, String message) {
        log.warn("认证失败：" + message
                + "\nclientid:" + mqttModel.getClientId()
                + "\nusername:" + mqttModel.getUserName()
                + "\npassword:" + mqttModel.getPassword());
        return ResponseEntity.status(401).body("Unauthorized");
    }
}
