package com.fastbee.common.core.domain.model;

import lombok.Data;

import java.io.Serializable;

/**
 * MQTT 客户端认证主体。
 *
 * <p>认证阶段只校验凭据是否合法，这里额外记录"这条连接代表谁"，供 PUBLISH 阶段做 topic 归属校验。
 * web / phone 客户端使用平台登录 JWT 作为 MQTT 密码，若不绑定用户身份，任意一个登录用户都能向
 * 任意设备的 topic 发布消息，进而触发该产品的规则脚本执行。</p>
 *
 * @author fastbee security
 */
@Data
public class MqttClientPrincipal implements Serializable {

    private static final long serialVersionUID = 1L;

    public enum ClientType {
        /** 平台内部服务端，配置账号密码认证 */
        SERVER,
        /** Web 端 / 移动端，登录 JWT 认证 */
        WEB,
        /** 设备端，一机一密认证 */
        DEVICE
    }

    private String clientId;

    private ClientType clientType;

    /** WEB 类型时对应的平台用户id，其余类型为 null */
    private Long userId;

    /** 是否为超级管理员，管理员不受设备归属限制 */
    private boolean admin;

    /** Redis login identifier, never the raw JWT or password. */
    private String sessionId;

    public static MqttClientPrincipal of(String clientId, ClientType clientType) {
        MqttClientPrincipal principal = new MqttClientPrincipal();
        principal.setClientId(clientId);
        principal.setClientType(clientType);
        return principal;
    }

    public static MqttClientPrincipal ofWeb(String clientId, Long userId, boolean admin) {
        MqttClientPrincipal principal = of(clientId, ClientType.WEB);
        principal.setUserId(userId);
        principal.setAdmin(admin);
        return principal;
    }

    public boolean isWeb() {
        return clientType == ClientType.WEB;
    }
}
