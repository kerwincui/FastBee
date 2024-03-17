package com.fastbee.iot.service;

import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.ProductAuthorize;
import com.fastbee.iot.model.MqttAuthenticationModel;
import com.fastbee.iot.model.ProductAuthenticateModel;
import com.fastbee.iot.model.RegisterUserInput;
import com.fastbee.iot.model.RegisterUserOutput;
import com.fastbee.iot.util.AESUtils;
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
     * 注册
     */
    public RegisterUserOutput registerNoCaptcha(RegisterUserInput registerBody);

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

    public  String generateRandomHex(int length);

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
     * 整合设备认证接口
     */
    public ResponseEntity clientAuth(String clientid,String username,String password) throws Exception;
    public ResponseEntity clientAuthv5(String clientid,String username,String password) throws Exception;

    /**
     * 返回认证信息
     */
    public ResponseEntity returnUnauthorized(MqttAuthenticationModel mqttModel, String message);
}
