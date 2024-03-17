package com.fastbee.server.config;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.enums.ServerType;
import com.fastbee.server.Server;
import com.fastbee.base.codec.Delimiter;
import com.fastbee.base.codec.LengthField;
import com.fastbee.base.codec.MessageDecoder;
import com.fastbee.base.codec.MessageEncoder;
import com.fastbee.base.core.HandlerInterceptor;
import com.fastbee.base.core.HandlerMapping;
import com.fastbee.base.session.SessionManager;
import io.netty.util.NettyRuntime;
import io.netty.util.internal.ObjectUtil;

/**
 * 基础配置类
 * @Author guanshubiao
 * @Date 2022/9/12 20:22
 */
public class NettyConfig {

    public final int workerCore;
    /*boss线程核数*/
    public final int businessCore;
    /*读空闲时间*/
    public final int readerIdleTime;
    /*写空闲时间*/
    public final int writerIdleTime;
    /*读写空闲时间*/
    public final int allIdleTime;
    /*端口*/
    public final Integer port;
    /*TCP/UDP数据最大长度限定*/
    public final Integer maxFrameLength;
    /*基础编码*/
    public final MessageDecoder decoder;
    /*基础解码*/
    public final MessageEncoder encoder;
    public final Delimiter[] delimiters;
    public final LengthField lengthField;
    public final HandlerMapping handlerMapping;
    public final HandlerInterceptor handlerInterceptor;
    public final SessionManager sessionManager;
    /*基础服务端*/
    public Server server;
    public String name;
    /*服务名*/
    public final ServerType type;




    public NettyConfig(int workerGroup,
                       int businessGroup,
                       int readerIdleTime,
                       int writerIdleTime,
                       int allIdleTime,
                       Integer port,
                       Integer maxFrameLength,
                       LengthField lengthField,
                       Delimiter[] delimiters,
                       MessageDecoder decoder,
                       MessageEncoder encoder,
                       HandlerMapping handlerMapping,
                       HandlerInterceptor handlerInterceptor,
                       SessionManager sessionManager,
                       ServerType type,
                       String name,
                       Server server) {

        /*校验值是否正确*/
        ObjectUtil.checkNotNull(port, FastBeeConstant.SERVER.PORT);
        ObjectUtil.checkPositive(port, FastBeeConstant.SERVER.PORT);

        if (ServerType.UDP == type || ServerType.TCP == type){
            ObjectUtil.checkNotNull(decoder, "decoder");
            ObjectUtil.checkNotNull(encoder, "encoder");
            ObjectUtil.checkNotNull(handlerMapping, "handlerMapping");
            ObjectUtil.checkNotNull(handlerInterceptor, "handlerInterceptor");
        }
        if (type == ServerType.TCP){
            ObjectUtil.checkNotNull(maxFrameLength, FastBeeConstant.SERVER.MAXFRAMELENGTH);
            ObjectUtil.checkPositive(maxFrameLength, FastBeeConstant.SERVER.MAXFRAMELENGTH);
            // ObjectUtil.checkNotNull(delimiters,FastBeeConstant.SERVER.DELIMITERS);

        }
        /*获取核数*/
        int processors = NettyRuntime.availableProcessors();
        this.workerCore = workerGroup > 0 ? workerGroup : processors + 2;
        this.businessCore = businessGroup > 0 ? businessGroup : Math.max(1, processors >> 1);
        this.readerIdleTime = readerIdleTime;
        this.writerIdleTime = writerIdleTime;
        this.allIdleTime = allIdleTime;
        this.port = port;
        this.maxFrameLength = maxFrameLength;
        this.lengthField = lengthField;
        this.delimiters = delimiters;
        this.decoder = decoder;
        this.encoder = encoder;
        this.handlerMapping = handlerMapping;
        this.handlerInterceptor = handlerInterceptor;
        this.sessionManager = sessionManager != null ? sessionManager : new SessionManager();
        this.type = type;

        switch (type){
            case MQTT:
            case WEBSOCKET:
                this.name = name != null ? name : ServerType.MQTT.name();
                this.server = server;
                this.server.config = this;
                break;
            default:
        }
    }


    public Server build() {
        return server;
    }

    public static NettyConfig.Builder custom() {
        return new Builder();
    }

    public static class Builder {

        private int workerCore;
        private int businessCore ;
        private int readerIdleTime = 240;
        private int writerIdleTime = 0;
        private int allIdleTime = 0;
        private Integer port;
        private Integer maxFrameLength;
        private LengthField lengthField;
        private Delimiter[] delimiters;
        private MessageDecoder decoder;
        private MessageEncoder encoder;
        private HandlerMapping handlerMapping;
        private HandlerInterceptor handlerInterceptor;
        private SessionManager sessionManager;
        private ServerType type;
        private String name;
        private Server server;

        public Builder() {
        }

        public Builder setThreadGroup(int workerCore, int businessCore) {
            this.workerCore = workerCore;
            this.businessCore = businessCore;
            return this;
        }

        public Builder setIdleStateTime(int readerIdleTime, int writerIdleTime, int allIdleTime) {
            this.readerIdleTime = readerIdleTime;
            this.writerIdleTime = writerIdleTime;
            this.allIdleTime = allIdleTime;
            return this;
        }

        public Builder setPort(Integer port) {
            this.port = port;
            return this;
        }

        public Builder setServer(Server server){
            this.server = server;
            return this;
        }

        public Builder setMaxFrameLength(Integer maxFrameLength) {
            this.maxFrameLength = maxFrameLength;
            return this;
        }

        public Builder setLengthField(LengthField lengthField) {
            this.lengthField = lengthField;
            return this;
        }

        public Builder setDelimiters(byte[][] delimiters) {
            Delimiter[] t = new Delimiter[delimiters.length];
            for (int i = 0; i < delimiters.length; i++) {
                t[i] = new Delimiter(delimiters[i]);
            }
            this.delimiters = t;
            return this;
        }

        public Builder setDelimiters(Delimiter... delimiters) {
            this.delimiters = delimiters;
            return this;
        }

        public Builder setDecoder(MessageDecoder decoder) {
            this.decoder = decoder;
            return this;
        }

        public Builder setEncoder(MessageEncoder encoder) {
            this.encoder = encoder;
            return this;
        }

        public Builder setHandlerMapping(HandlerMapping handlerMapping) {
            this.handlerMapping = handlerMapping;
            return this;
        }

        public Builder setHandlerInterceptor(HandlerInterceptor handlerInterceptor) {
            this.handlerInterceptor = handlerInterceptor;
            return this;
        }

        public Builder setSessionManager(SessionManager sessionManager) {
            this.sessionManager = sessionManager;
            return this;
        }

        public Builder setType(ServerType type){
            this.type = type;
            return this;
        }


        public Builder setName(String name) {
            this.name = name;
            return this;
        }

        public Server build() {
            return new NettyConfig(
                    this.workerCore,
                    this.businessCore,
                    this.readerIdleTime,
                    this.writerIdleTime,
                    this.allIdleTime,
                    this.port,
                    this.maxFrameLength,
                    this.lengthField,
                    this.delimiters,
                    this.decoder,
                    this.encoder,
                    this.handlerMapping,
                    this.handlerInterceptor,
                    this.sessionManager,
                    this.type,
                    this.name,
                    this.server
            ).build();
        }
    }
}
