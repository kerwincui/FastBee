package com.fastbee.base.session;

import com.fastbee.common.core.protocol.Message;
import com.fastbee.common.enums.ServerType;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.gateway.mq.Topics;
import com.fastbee.base.core.model.Response;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.netty.buffer.ByteBuf;
import io.netty.channel.Channel;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.mqtt.MqttMessageType;
import io.netty.handler.codec.mqtt.MqttVersion;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import reactor.core.publisher.Mono;
import reactor.core.publisher.MonoSink;

import java.net.InetSocketAddress;
import java.util.*;
import java.util.concurrent.RejectedExecutionException;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.function.Function;

/**
 * 会话
 *
 * @Author guanshubiao
 * @Date 2022/9/12 20:22
 */
@Data
@Slf4j
public class Session {

    private  boolean udp;
    private  Function<Session, Boolean> remover;
    protected Channel channel;
    /**
     * 客户端id
     */
    private String clientId;
    private String productId;
    private SessionManager sessionManager;
    private InetSocketAddress remoteAddress;
    private String remoteAddressStr;

    private long creationTime;
    private long lastAccessTime;
    private Map<Object, Object> attributes;

    private String sessionId;
    //原子计数器，报文没有消息流水号的，充当流水号
    private AtomicInteger serialNo = new AtomicInteger(0);
    private int keepAlive = 60;


    /*mqtt版本号*/
    private MqttVersion version;
    /*是否清楚会话*/
    private Boolean cleanSession = false;
    /*mqtt账号*/
    private String username;
    /*是否链接*/
    private Boolean connected = false;
    /*mqtt消息类型*/
    private MqttMessageType mqttMessageType;
    private int keepAliveMax = 120;
    /*主题*/
    private String topicName;
    /*Channel处理类上下文*/
    private ChannelHandlerContext handlerContext;

    private List<Topics> topics;
    private Integer topicCount;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date connected_at;
    private String ip;
    /*服务协议类型 MQTT，TCP UDP COAP*/
    private ServerType serverType;

    public Session(){

    }

    public Session(SessionManager sessionManager,
                   Channel channel,
                   InetSocketAddress remoteAddress,
                   Function<Session, Boolean> remover,
                   boolean udp,
                   ServerType serverType) {
        this.channel = channel;
        this.creationTime = DateUtils.getTimestamp();
        this.lastAccessTime = creationTime;
        this.sessionManager = sessionManager;
        this.remoteAddress = remoteAddress;
        this.remoteAddressStr = remoteAddress.toString();
        this.remover = remover;
        this.udp = udp;
        this.serverType = serverType;
        this.ip = remoteAddress.getHostName();
        this.connected = true;
        this.connected_at = DateUtils.getNowDate();
        if (sessionManager != null && sessionManager.getSessionKeys() != null) {
            this.attributes = new EnumMap(sessionManager.getSessionKeys());
        } else {
            this.attributes = new TreeMap<>();
        }
    }

    /**
     * 判断设备是否已经注册上线
     */
    public boolean isRegistered() {
        return clientId != null;
    }

    /*设备端注册*/
    public void register(Message message) {
        register(message.getClientId(), message);
    }

    public void register(String clientId, Message message) {
        //已经注册，不再发送注册包数据
        if (isRegistered()){
            return;
        }
        if (clientId == null) {
            throw new ServiceException("客户端注册clientId不能为空");
        }
        this.clientId = clientId.toUpperCase();
        if (sessionManager != null) {
            sessionManager.add(this);
        }
    }

    public Object getAttribute(Object name) {
        return attributes.get(name);
    }

    public void setAttribute(Object name, Object value) {
        attributes.put(name, value);
    }

    /**
     * 获取最后上线时间
     */
    public long access() {
        return lastAccessTime = DateUtils.getTimestamp();
    }

    /**
     * 获取远程端口
     */
    public InetSocketAddress remoteAddress() {
        return remoteAddress;
    }

    /**
     * 获取流水号
     */
    public int nextSerialNO() {
        int current;
        int next;
        do {
            current = serialNo.get();
            next = current > 0xffff ? 0 : current;
        } while (!serialNo.compareAndSet(current, next + 1));
        return next;
    }

    /**
     * 处理离线方法
     */
    public void invalidate() {
        if (isRegistered() && sessionManager != null) {
            sessionManager.remove(this);
        }
        remover.apply(this);
    }

    public boolean isUdp() {
        return udp;
    }

    private final Map<String, MonoSink> topicSubscribers = new HashMap<>();

    private static final Mono rejected = Mono.error(new RejectedExecutionException("设备端暂无响应"));

    /**
     * 异步发送通知类消息
     * 同步发送 mono.block()
     * 订阅回调 mono.doOnSuccess(处理成功).doOnError(处理异常).subscribe(开始订阅)
     */
    public Mono<Void> notify(Message message) {
        return mono(channel.writeAndFlush(Packet.of(this, message)));
    }

    public Mono<Void> notify(ByteBuf message) {
        return mono(channel.writeAndFlush(Packet.of(this, message)));
    }

    public static Mono<Void> mono(ChannelFuture channelFuture) {
        return Mono.create(sink -> channelFuture.addListener(future -> {
            if (future.isSuccess()) {
                sink.success();
            } else {
                sink.error(future.cause());
            }
        }));
    }

    /**
     * 异步发送消息，接收响应
     * 同步接收 mono.block()
     * 订阅回调 mono.doOnSuccess(处理成功).doOnError(处理异常).subscribe(开始订阅)
     */
    public <T> Mono<T> request(Message message, Class<T> responseClass) {
        String key = requestKey(message, responseClass);
        Mono<T> subscribe = this.subscribe(key);
        if (subscribe == null) {
            return rejected;
        }
        ChannelFuture channelFuture = channel.writeAndFlush(Packet.of(this, message));
        return Mono.create(sink -> channelFuture.addListener(future -> {
            if (future.isSuccess()) {
                sink.success(future);
            } else {
                sink.error(future.cause());
            }
        })).then(subscribe).doFinally(signal -> unsubscribe(key));
    }

    /**
     * 消息响应
     */
    public boolean response(Message message){
        MonoSink monoSink = topicSubscribers.get(responseKey(message));
        if (monoSink != null){
            monoSink.success(message);
            return true;
        }
        return false;
    }

    /**
     * 订阅
     */
    private Mono subscribe(String key) {
        synchronized (topicSubscribers) {
            if (!topicSubscribers.containsKey(key)) {
                return Mono.create(sink -> topicSubscribers.put(key, sink));
            }
        }
        return null;
    }

    /**
     * 取消订阅
     */
    private void unsubscribe(String key) {
        topicSubscribers.remove(key);
    }

    /*生成流水号*/
    private static String requestKey(Message request, Class responseClass) {
        String className = responseClass.getName();
        if (Response.class.isAssignableFrom(responseClass)) {
            String serNo = request.getSerNo();
            return new StringBuffer(34).append(className).append('.').append(serNo).toString();
        }
        return className;
    }

    /*返回流水号*/
    private static String responseKey(Object response) {
        String className = response.getClass().getName();
        if (response instanceof Response) {
            int serialNo = ((Response) response).getResponseSerialNo();
            return new StringBuffer(34).append(className).append('.').append(serialNo).toString();
        }
        return className;
    }

}
