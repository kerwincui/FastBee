package com.fastbee.sip.server;

import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.server.msg.ConfigDownload;
import com.fastbee.sip.server.msg.DeviceControl;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import javax.sip.ClientTransaction;
import javax.sip.PeerUnavailableException;
import javax.sip.RequestEvent;
import javax.sip.message.Request;
import java.util.Date;

public interface MessageInvoker {

    /**
     * 发送订阅报警指令
     *
     * @param device             设备信息
     * @param startAlarmPriority 开始报警级别
     * @param endAlarmPriority   结束报警级别
     * @param expires            过期时间
     * @param alarmMethod        报警方式
     * @param startAlarmTime     开始报警时间
     * @param endAlarmTime       结束报警时间
     * @return void
     */
    void subscribe(@Nonnull SipDevice device,
                   int startAlarmPriority,
                   int endAlarmPriority,
                   int expires,
                   @Nonnull String alarmMethod,
                   @Nullable Date startAlarmTime,
                   @Nullable Date endAlarmTime);

    /**
     * 发送设备控制指令,{@link DeviceControl#getDeviceId()}为通道ID
     *
     * @param device  设备信息
     * @param command 控制指令
     * @return void
     */
    void deviceControl(SipDevice device, DeviceControl command);

    /**
     * 获取设备详细信息
     *
     * @param device 设备信息
     * @return 详细信息
     */
    boolean deviceInfoQuery(SipDevice device);

    /**
     * 获取通道列表
     *
     * @param device 设备信息
     * @return 通道列表
     */
    boolean catalogQuery(SipDevice device);

    boolean recordInfoQuery(SipDevice device, String sn, String channelId, Date start, Date end);


    /**
     * 订阅通道目录，发送订阅请求后
     *
     * @param device device
     * @param from   订阅有效期从
     * @param to     订阅有效期止
     * @return void
     */
    void subscribeCatalog(SipDevice device, Date from, Date to) throws PeerUnavailableException;


    /**
     * 下载设备配置信息，可指定配置类型，如果未指定类型则获取所有类型的配置
     *
     * @param device     设备信息
     * @param configType 要下载的配置类型
     * @return 配置信息
     */
    ConfigDownload downloadConfig(SipDevice device, ConfigDownload.ConfigType... configType);
    SipMessage messageToObj(RequestEvent event);
    /**
     * 发送SIP原始请求
     *
     * @param device   设备
     * @param request  原始请求
     * @param awaitAck 是否等待响应
     * @return 事务信息
     */
    ClientTransaction request(SipDevice device, Request request, boolean awaitAck);

    /**
     * 发起一个请求，并等待响应，不同的请求方式以及内容，响应的内容不同。
     *
     * @param transaction ClientTransaction
     * @param request     Request
     * @param awaitAck    是否等待响应
     * @return 响应结果
     */
    Object request(ClientTransaction transaction, Request request, boolean awaitAck);

    <T> T getExecResult(String key, long timeout);
}
