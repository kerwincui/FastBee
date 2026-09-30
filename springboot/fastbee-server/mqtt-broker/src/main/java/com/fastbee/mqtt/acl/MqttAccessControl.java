package com.fastbee.mqtt.acl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.common.core.domain.model.MqttClientPrincipal;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.domain.DeviceUser;
import com.fastbee.iot.mapper.DeviceMapper;
import com.fastbee.iot.mapper.DeviceUserMapper;
import com.fastbee.mqtt.auth.AuthService;
import org.springframework.stereotype.Component;
import javax.annotation.Resource;
import java.util.*;

/** Reuse the platform's owner, tenant and shared-model permissions, with live login state. */
@Component
public class MqttAccessControl {
    @Resource private AuthService authService;
    @Resource private DeviceMapper deviceMapper;
    @Resource private DeviceUserMapper deviceUserMapper;

    public boolean canPublish(MqttClientPrincipal principal, String topic) { return canPublish(principal, topic, null); }
    public boolean canPublish(MqttClientPrincipal principal, String topic, String payload) { return allowed(principal, topic, payload, false); }
    public boolean canSubscribe(MqttClientPrincipal principal, String topic) { return allowed(principal, topic, null, true); }

    private boolean allowed(MqttClientPrincipal principal, String topic, String payload, boolean subscribe) {
        if (principal == null || principal.getClientType() == null) return false;
        if (!principal.isWeb()) return true;
        try {
            SysUser user = authService.currentWebUser(principal);
            if (user == null || topic == null) return false;
            if (user.isAdmin()) return subscribe || topic.indexOf('#') < 0 && topic.indexOf('+') < 0;
            String[] parts = topic.split("/", -1);
            if (parts.length < 4 || !parts[0].isEmpty() || parts[1].isEmpty() || parts[2].isEmpty()
                    || parts[1].contains("+") || parts[1].contains("#") || parts[2].contains("+") || parts[2].contains("#")) return false;
            if (!subscribe && (topic.contains("+") || topic.contains("#"))) return false;
            Device device = deviceMapper.selectDeviceBySerialNumber(parts[2]);
            if (device == null || !String.valueOf(device.getProductId()).equals(parts[1])) return false;
            if (Objects.equals(device.getUserId(), user.getUserId())) return true;
            if (Objects.equals(device.getTenantId(), user.getUserId()) && user.getRoles() != null
                    && user.getRoles().stream().anyMatch(r -> "tenant".equals(r.getRoleKey()))) return true;
            DeviceUser share = deviceUserMapper.selectDeviceUserByDeviceIdAndUserId(device.getDeviceId(), user.getUserId());
            if (share == null || "2".equals(share.getDelFlag())) return false;
            if (Integer.valueOf(1).equals(share.getIsOwner())) return true;
            // Viewing a shared device retains its established subscription behavior.
            if (subscribe) return true;
            Set<String> permissions = new HashSet<>();
            if (share.getPerms() != null) for (String p : share.getPerms().split(",")) permissions.add(p.trim());
            String suffix = String.join("/", Arrays.copyOfRange(parts, 3, parts.length));
            if ("monitor/get".equals(suffix)) return permissions.contains("monitor");
            if (!"property/get".equals(suffix) && !"function/get".equals(suffix)) return false;
            if (payload == null) return false;
            Object body = JSON.parse(payload);
            JSONArray values = body instanceof JSONArray ? (JSONArray) body : new JSONArray(Collections.singletonList(body));
            if (values.isEmpty()) return false;
            for (Object value : values) {
                if (!(value instanceof JSONObject)) return false;
                String identifier = ((JSONObject) value).getString("id");
                if (identifier == null || !permissions.contains(identifier)) return false;
            }
            return true;
        } catch (RuntimeException e) {
            // Malformed topics, revoked state or unavailable authorization storage must fail closed.
            return false;
        }
    }
}
