package com.fastbee.iot.service.impl;

import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.annotation.DataScope;
import com.fastbee.common.constant.CacheConstants;
import com.fastbee.common.constant.Constants;
import com.fastbee.common.constant.UserConstants;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.exception.user.CaptchaException;
import com.fastbee.common.exception.user.CaptchaExpireException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.MessageUtils;
import com.fastbee.common.utils.SecurityUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.framework.manager.AsyncManager;
import com.fastbee.framework.manager.factory.AsyncFactory;
import com.fastbee.iot.domain.ProductAuthorize;
import com.fastbee.iot.mapper.ProductAuthorizeMapper;
import com.fastbee.iot.model.*;
import com.fastbee.iot.service.IDeviceService;
import com.fastbee.iot.service.IToolService;
import com.fastbee.iot.util.AESUtils;
import com.fastbee.system.mapper.SysUserMapper;
import com.fastbee.system.service.ISysConfigService;
import com.fastbee.system.service.ISysUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
     * 生成任意长度 HEX格式字符串
     * @param length
     * @return
     */
    public  String generateRandomHex(int length) {
        Random random = new Random();
        StringBuilder sb = new StringBuilder(length);
        // 添加"D"作为开头
        sb.append("D");
        for (int i = 1; i < length; i++) {
            int randomInt = random.nextInt(16); // 生成0到15的随机整数
            char hexChar = Character.toUpperCase(Character.forDigit(randomInt, 16)); // 将整数转换为十六进制字符并转为大写
            sb.append(hexChar);
        }
        return sb.toString();
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
        SysUser sysUser = new SysUser();
        sysUser.setUserName(username);

        boolean captchaEnabled = configService.selectCaptchaEnabled();
        // 验证码开关
        if (captchaEnabled)
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
        else if (UserConstants.NOT_UNIQUE.equals(userService.checkUserNameUnique(sysUser)))
        {
            msg = "保存用户'" + username + "'失败，注册账号已存在";
        }else if (UserConstants.NOT_UNIQUE.equals(checkPhoneUnique(phonenumber)))
        {
            msg = "保存用户'" + username + "'失败，注册手机号码已存在";
        }
        else
        {
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

    @Override
    @Transactional(rollbackFor = Exception.class)
    public RegisterUserOutput registerNoCaptcha(RegisterUserInput registerBody)
    {
        RegisterUserOutput registerUserOutput = new RegisterUserOutput();
        String msg = "";
        String username = registerBody.getUsername();
        String password = registerBody.getPassword();
        String phonenumber=registerBody.getPhonenumber();
        SysUser sysUser = new SysUser();
        sysUser.setUserName(username);

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
        else if (UserConstants.NOT_UNIQUE.equals(userService.checkUserNameUnique(sysUser)))
        {
            msg = "保存用户'" + username + "'失败，注册账号已存在";
        }else if (UserConstants.NOT_UNIQUE.equals(checkPhoneUnique(phonenumber)))
        {
            msg = "保存用户'" + username + "'失败，注册手机号码已存在";
        }
        else
        {
            sysUser.setNickName(username);
            sysUser.setPhonenumber(phonenumber);
            sysUser.setPassword(SecurityUtils.encryptPassword(registerBody.getPassword()));
            boolean regFlag = userService.registerUser(sysUser);
            //分配普通用户角色(1=超级管理员，2=设备租户，3=普通用户，4=游客)
            Long[] roleIds={3L};
            userService.insertUserAuth(sysUser.getUserId(),roleIds);
            registerUserOutput.setSysUserId(sysUser.getUserId());
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
        registerUserOutput.setMsg(msg);
        return registerUserOutput;
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
        String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + StringUtils.nvl(uuid, "");
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
     * 整合设备认证接口
     */
    @Override
    public ResponseEntity clientAuth(String clientid,String username,String password) throws Exception {
        // 设备端认证：加密认证（E）和简单认证（S，配置的账号密码认证）
        String[] clientArray = clientid.split("&");
        if(clientArray.length != 4 || clientArray[0].equals("") || clientArray[1].equals("") || clientArray[2].equals("") || clientArray[3].equals("")){
            return this.returnUnauthorized(new MqttAuthenticationModel(clientid, username, password), "设备mqtt客户端Id格式为：认证类型 & 设备编号 & 产品ID & 用户ID");
        }
        String authType = clientArray[0];
        String deviceNumber = clientArray[1];
        Long productId = Long.valueOf(clientArray[2]);
        Long userId = Long.valueOf(clientArray[3]);
        // 产品认证信息
        ProductAuthenticateModel model = deviceService.selectProductAuthenticate(new AuthenticateInputModel(deviceNumber, productId));
        if (model == null) {
            return this.returnUnauthorized(new MqttAuthenticationModel(clientid, username, password), "设备认证，通过产品ID查询不到信息");
        }
        if (model.getProductStatus() != 2) {
            // 产品必须为发布状态：1-未发布，2-已发布
            return this.returnUnauthorized(new MqttAuthenticationModel(clientid, username, password), "设备认证，设备对应产品还未发布");
        }

        if (authType.equals("S")) {
            // 设备简单认证
            return this.simpleMqttAuthentication(new MqttAuthenticationModel(clientid, username, password, deviceNumber, productId, userId), model);

        } else if (authType.equals("E")) {
            // 设备加密认证
            return this.encryptAuthentication(new MqttAuthenticationModel(clientid, username, password, deviceNumber, productId, userId), model);
        } else {
            return this.returnUnauthorized(new MqttAuthenticationModel(clientid, username, password), "设备认证，认证类型有误");
        }
    }

    @Override
    public ResponseEntity clientAuthv5(String clientid,String username,String password) throws Exception {
        JSONObject ret = new JSONObject();
        ret.put("is_superuser", false);
        // 设备端认证：加密认证（E）和简单认证（S，配置的账号密码认证）
        String[] clientArray = clientid.split("&");
        if(clientArray.length != 4 || clientArray[0].equals("") || clientArray[1].equals("") || clientArray[2].equals("") || clientArray[3].equals("")){
            return this.returnUnauthorized(new MqttAuthenticationModel(clientid, username, password), "设备mqtt客户端Id格式为：认证类型 & 设备编号 & 产品ID & 用户ID");
        }
        String authType = clientArray[0];
        String deviceNumber = clientArray[1];
        Long productId = Long.valueOf(clientArray[2]);
        Long userId = Long.valueOf(clientArray[3]);
        // 产品认证信息
        ProductAuthenticateModel model = deviceService.selectProductAuthenticate(new AuthenticateInputModel(deviceNumber, productId));
        if (model == null) {
            log.error("-----------设备认证，通过产品ID查询不到信息,clientId:" + clientid + "---------------");
            ret.put("result", "deny");
            return ResponseEntity.ok().body(ret);
        }
        if (model.getProductStatus() != 2) {
            // 产品必须为发布状态：1-未发布，2-已发布
            log.error("-----------设备认证，设备对应产品还未发布,clientId:" + clientid + "---------------");
            ret.put("result", "deny");
            return ResponseEntity.ok().body(ret);
        }

        if (authType.equals("S")) {
            // 设备简单认证
            ResponseEntity res =  this.simpleMqttAuthentication(new MqttAuthenticationModel(clientid, username, password, deviceNumber, productId, userId), model);
            if (res.getStatusCodeValue() == HttpStatus.OK.value()){
                ret.put("result", "allow");
                return ResponseEntity.ok().body(ret);
            } else {
                ret.put("result", "deny");
                return ResponseEntity.ok().body(ret);
            }

        } else if (authType.equals("E")) {
            // 设备加密认证
            ResponseEntity res = this.encryptAuthentication(new MqttAuthenticationModel(clientid, username, password, deviceNumber, productId, userId), model);
            if (res.getStatusCodeValue() == HttpStatus.OK.value()){
                ret.put("result", "allow");
                return ResponseEntity.ok().body(ret);
            } else {
                ret.put("result", "deny");
                return ResponseEntity.ok().body(ret);
            }
        } else {
            log.error("-----------设备认证，认证类型有误,clientId:" + clientid + "---------------");
            ret.put("result", "deny");
            return ResponseEntity.ok().body(ret);
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
