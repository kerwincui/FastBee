package com.fastbee.iot.oauth.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.common.util.OAuth2Utils;
import org.springframework.security.oauth2.provider.AuthorizationRequest;
import org.springframework.security.oauth2.provider.ClientDetails;
import org.springframework.security.oauth2.provider.approval.Approval;
import org.springframework.security.oauth2.provider.approval.ApprovalStore;
import org.springframework.security.oauth2.provider.client.JdbcClientDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.security.Principal;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * kerwincui
 */
@Controller
@SessionAttributes("authorizationRequest")
public class ConfirmAccessController {
    @Autowired
    private JdbcClientDetailsService clientDetailsService;
    @Autowired
    private ApprovalStore            approvalStore;

    @RequestMapping("/oauth/confirm_access")
    public String getAccessConfirmation(Map<String, Object> model, Principal principal ) {
        AuthorizationRequest clientAuth = (AuthorizationRequest) model.remove("authorizationRequest");
        ClientDetails client = clientDetailsService.loadClientByClientId(clientAuth.getClientId());

        Map<String, String> scopes = new LinkedHashMap<String, String>();
        for (String scope : clientAuth.getScope()) {
            scopes.put(OAuth2Utils.SCOPE_PREFIX + scope, "false");
        }
        for (Approval approval : approvalStore.getApprovals(principal.getName(), client.getClientId())) {
            if (clientAuth.getScope().contains(approval.getScope())) {
                scopes.put(OAuth2Utils.SCOPE_PREFIX + approval.getScope(),
                        approval.getStatus() == Approval.ApprovalStatus.APPROVED ? "true" : "false");
            }
        }
        model.put("auth_request", clientAuth);
        model.put("client", client);
        model.put("scopes", scopes);
        return "oauth/access_confirmation";
    }
}
