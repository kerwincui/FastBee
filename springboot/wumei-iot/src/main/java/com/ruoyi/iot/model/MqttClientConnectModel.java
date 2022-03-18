package com.ruoyi.iot.model;

/**
 * 客户端连接模型
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
public class MqttClientConnectModel
{
    /** 事件名称（固定为："client_connected" "client_disconnected"） **/
    private String action;

    /** 客户端 ClientId **/
    private String clientid;

    /** 客户端 Username，不存在时该值为 "undefined" **/
    private String username;

    /** 客户端源 IP 地址 **/
    private String ipaddress;

    /** 客户端申请的心跳保活时间 **/
    private Integer keepalive;

    /** 协议版本号 **/
    private Integer proto_ver;

    /** 时间戳(秒) **/
    private Long connected_at;

    /** 错误原因 **/
    private String reason;

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getClientid() {
        return clientid;
    }

    public void setClientid(String clientid) {
        this.clientid = clientid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getIpaddress() {
        return ipaddress;
    }

    public void setIpaddress(String ipaddress) {
        this.ipaddress = ipaddress;
    }

    public Integer getKeepalive() {
        return keepalive;
    }

    public void setKeepalive(Integer keepalive) {
        this.keepalive = keepalive;
    }

    public Integer getProto_ver() {
        return proto_ver;
    }

    public void setProto_ver(Integer proto_ver) {
        this.proto_ver = proto_ver;
    }

    public Long getConnected_at() {
        return connected_at;
    }

    public void setConnected_at(Long connected_at) {
        this.connected_at = connected_at;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
