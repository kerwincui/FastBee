package com.fastbee.mqtt.manager;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.mq.DeviceStatusBo;
import com.fastbee.common.enums.DeviceStatus;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.common.utils.spring.SpringUtils;
import com.fastbee.iot.service.cache.IDeviceCache;
import com.fastbee.mq.redischannel.producer.MessageProducer;
import com.fastbee.mq.service.IMessagePublishService;
import com.fastbee.base.service.ISessionStore;
import com.fastbee.base.session.Session;
import com.fastbee.base.util.AttributeUtils;
import com.fastbee.mqtt.utils.MqttMessageUtils;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.mqtt.MqttMessageType;
import lombok.extern.slf4j.Slf4j;

import java.util.Map;
import java.util.Set;

/**
 * 会话管理类
 *
 * @Author guanshubiao
 * @Date 2022/9/12 20:22
 */
@Slf4j
public class SessionManger {


    private static ISessionStore sessionStore = SpringUtils.getBean(ISessionStore.class);
    private static MqttRemoteManager remoteManager = SpringUtils.getBean(MqttRemoteManager.class);
    private static IDeviceCache deviceCache = SpringUtils.getBean(IDeviceCache.class);

    /**
     * mqtt新客户连接
     *
     * @param clientId 客户端id
     * @param session  客户端
     */
    public static void buildSession(String clientId, Session session) {
        log.debug("=>新客户端连接，clientId={}", clientId);
        if (StringUtils.isEmpty(clientId) || handleContext(session)) {
            log.error("=>客户端id为空或者session未注册!");
            return;
        }

        sessionStore.storeSession(clientId, session);
        //contextMap.put(session.getHandlerContext(), session);
        /*更新客户端在平台的最新响应时间*/
        ClientManager.updatePing(clientId);
        /*发送MQ，设备上线*/
        DeviceStatusBo statusBo = MqttMessageUtils.buildStatusMsg(session.getHandlerContext(), session.getClientId(), DeviceStatus.ONLINE, session.getIp());
        if (!statusBo.getSerialNumber().startsWith(FastBeeConstant.SERVER.WM_PREFIX) &&
                !statusBo.getSerialNumber().startsWith(FastBeeConstant.SERVER.WS_PREFIX) &&
                !statusBo.getSerialNumber().startsWith(FastBeeConstant.SERVER.FAST_PHONE)) {
            deviceCache.updateDeviceStatusCache(statusBo);
            remoteManager.pushDeviceStatus(-1L,statusBo.getSerialNumber(), statusBo.getStatus());
        }
    }

    /**
     * 根据客户端id移除客户端
     *
     * @param clientId 客户端id
     */
    public static void removeClient(String clientId) {
        log.debug("=>移除客户端,clientId={}", clientId);
        try {
            if (StringUtils.isEmpty(clientId) || !sessionStore.containsKey(clientId) || clientId.endsWith(FastBeeConstant.SERVER.WS_PREFIX) ||
            clientId.endsWith(FastBeeConstant.SERVER.FAST_PHONE)) {
                return;
            }
            Session session = sessionStore.getSession(clientId);
            if (handleContext(session)) {
                log.error("移除客户端失败,客户端未注册!");
                return;
            }
            //关闭通道
            session.getHandlerContext().close();
            //移除client
            sessionStore.cleanSession(clientId);
            session.setMqttMessageType(MqttMessageType.DISCONNECT);
            //发送至MQ,设备下线
            DeviceStatusBo statusBo = MqttMessageUtils.buildStatusMsg(session.getHandlerContext(), session.getClientId(), DeviceStatus.OFFLINE, session.getIp());
            if (!statusBo.getSerialNumber().startsWith(FastBeeConstant.SERVER.WM_PREFIX) &&
                    !statusBo.getSerialNumber().startsWith(FastBeeConstant.SERVER.WS_PREFIX)) {
                deviceCache.updateDeviceStatusCache(statusBo);
                remoteManager.pushDeviceStatus(-1L,statusBo.getSerialNumber(), statusBo.getStatus());
            }
        } catch (Exception e) {
            throw new ServiceException("移除客户端失败,message=" + e.getMessage());
        }
    }

    /**
     * 根据客户通道移除客户端
     *
     * @param ctx 上下文通道
     */
    public static void removeContextByContext(ChannelHandlerContext ctx) {
        try {
            /*获取*/
            Session session = AttributeUtils.getSession(ctx.channel());
            if (handleContext(session)) {
                log.error("=>客户端通道不存在!移除失败");
                return;
            }
            sessionStore.cleanSession(session.getClientId());
            session.setMqttMessageType(MqttMessageType.DISCONNECT);
            //发送至MQ,设备下线
            DeviceStatusBo statusBo = MqttMessageUtils.buildStatusMsg(session.getHandlerContext(), session.getClientId(), DeviceStatus.OFFLINE, session.getIp());
            if (!statusBo.getSerialNumber().startsWith(FastBeeConstant.SERVER.WM_PREFIX) &&
                    !statusBo.getSerialNumber().startsWith(FastBeeConstant.SERVER.WS_PREFIX)) {
                deviceCache.updateDeviceStatusCache(statusBo);
                remoteManager.pushDeviceStatus(-1L,statusBo.getSerialNumber(), statusBo.getStatus());
            }
        } catch (Exception e) {
            log.error("=>移除客户端失败={}", e.getMessage());
        }
    }

    /**
     * ping判定时间超时
     *
     * @param clientId 客户id
     */
    public static void pingTimeout(String clientId) {
        try {
            removeClient(clientId);
        } catch (Exception e) {
            throw new ServiceException("移除超时客户端失败");
        }
    }

    /**
     * 根据clientId获取客户通道
     *
     * @param clientId 客户端id
     * @return session
     */
    public static Session getSession(String clientId) {
        return sessionStore.getSession(clientId);
    }

    /**
     * 校验Session已经注册通道
     *
     * @param session 客户端
     * @return 结果
     */
    private static boolean handleContext(Session session) {
        if (null == session || null == session.getHandlerContext()) {
            return true;
        }
        return false;
    }


}
