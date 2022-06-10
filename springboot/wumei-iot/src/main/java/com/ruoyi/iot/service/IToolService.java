package com.ruoyi.iot.service;

import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.iot.domain.ProductAuthorize;
import com.ruoyi.iot.model.MqttAuthenticationModel;
import com.ruoyi.iot.model.ProductAuthenticateModel;
import com.ruoyi.iot.model.RegisterUserInput;
import com.ruoyi.iot.util.AESUtils;
import org.springframework.http.ResponseEntity;

import java.util.List;

/**
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public interface IToolService
{
    /**
     * 注册
     */
    public String register(RegisterUserInput registerBody);

    /**
     * 根据条件分页查询用户列表
     *
     * @param user 用户信息
     * @return 用户信息集合信息
     */
    public List<SysUser> selectUserList(SysUser user);

    /**
     * 生成随机数字和字母
     */
    public String getStringRandom(int length);

    /**
     * 设备简单认证
     */
    public ResponseEntity simpleMqttAuthentication(MqttAuthenticationModel mqttModel, ProductAuthenticateModel productModel);

    /**
     * 设备加密认证
     *
     * @return
     */
    public ResponseEntity encryptAuthentication(MqttAuthenticationModel mqttModel, ProductAuthenticateModel productModel)throws Exception;


    /**
     * 返回认证信息
     */
    public ResponseEntity returnUnauthorized(MqttAuthenticationModel mqttModel, String message);
}
