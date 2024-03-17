package com.fastbee.base.util;


import com.fastbee.base.session.Session;
import io.netty.channel.Channel;
import io.netty.util.AttributeKey;


/**
 * channel和pipeline桥梁Attribute信息构建
 * @author gsb
 * @date 2022/10/7 18:40
 */
public class AttributeUtils {

    /*存储客户端连接信息*/
    private static final AttributeKey<Object> SESSION_KEY = AttributeKey.valueOf("session");
    /*存储客户端id*/
    private static final AttributeKey<Object> CLIENT_ID_KEY = AttributeKey.valueOf("clientId");


    /*添加session*/
    public static void setSession(Channel channel, Session session){
        channel.attr(SESSION_KEY).set(session);
    }

    /*获取session*/
    public static Session getSession(Channel channel){
        return (Session) channel.attr(SESSION_KEY).get();
    }

    /*添加clientId*/
    public static void setClientId(Channel channel, String clientId){
        channel.attr(CLIENT_ID_KEY).set(clientId);
    }

    /*获取clientId*/
    public static String getClientId(Channel channel){
        return (String) channel.attr(CLIENT_ID_KEY).get();
    }

}
