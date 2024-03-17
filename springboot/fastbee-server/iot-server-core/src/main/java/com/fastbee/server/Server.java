package com.fastbee.server;


import com.fastbee.server.config.NettyConfig;
import io.netty.bootstrap.AbstractBootstrap;
import io.netty.channel.ChannelFuture;
import io.netty.channel.EventLoopGroup;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.ExecutorService;

/**
 * 基础服务器启动类
 *
 * @Author guanshubiao
 * @Date 2022/9/12 20:22
 */
@Slf4j
@NoArgsConstructor
public abstract class Server {

    protected EventLoopGroup bossGroup;
    protected EventLoopGroup workerGroup;
    protected ExecutorService businessService;
    protected boolean isRunning;
    public NettyConfig config;



    protected Server(NettyConfig config){
        this.config = config;
    }

    /*初始化方法*/
    protected abstract AbstractBootstrap initialize();


    public synchronized boolean start() {
        if (isRunning) {
            log.warn("=>服务:{},在端口:{},已经运行", config.name, config.port);
            return isRunning;
        }
        AbstractBootstrap bootstrap = initialize();
        ChannelFuture future = bootstrap.bind(config.port).awaitUninterruptibly();
        future.channel().closeFuture().addListener(event -> {
            if (isRunning) {
                stop();
            }
        });
        if (isRunning = future.isSuccess()) {
            log.info("=>服务:{},在端口:{},启动成功！", config.name, config.port);
            return isRunning;
        }

        if (future.cause() != null) {
            log.error("服务启动失败", future.cause());
        }
        return isRunning;
    }


    public synchronized void stop() {

        isRunning = false;
        bossGroup.shutdownGracefully();
        if (workerGroup != null) {
            workerGroup.shutdownGracefully();
        }
        if (businessService != null) {
            businessService.shutdown();
        }
        log.warn("=>服务:{},在端口:{},已经停止！", config.name, config.port);
    }


}
