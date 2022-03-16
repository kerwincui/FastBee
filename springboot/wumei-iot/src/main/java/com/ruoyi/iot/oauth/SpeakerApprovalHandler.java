package com.ruoyi.iot.oauth;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.common.util.OAuth2Utils;
import org.springframework.security.oauth2.provider.AuthorizationRequest;
import org.springframework.security.oauth2.provider.OAuth2RequestFactory;
import org.springframework.security.oauth2.provider.approval.Approval;
import org.springframework.security.oauth2.provider.approval.ApprovalStore;
import org.springframework.security.oauth2.provider.approval.ApprovalStoreUserApprovalHandler;
import org.springframework.security.oauth2.provider.client.JdbcClientDetailsService;

import java.util.*;

/**
 * kerwincui
 */
public class SpeakerApprovalHandler extends ApprovalStoreUserApprovalHandler {

    private int approvalExpirySeconds = -1;

    @Autowired
    private ApprovalStore approvalStore;

    public SpeakerApprovalHandler(JdbcClientDetailsService clientDetailsService, ApprovalStore approvalStore, OAuth2RequestFactory oAuth2RequestFactory) {
        this.setApprovalStore(approvalStore);
        this.setClientDetailsService(clientDetailsService);
        this.setRequestFactory(oAuth2RequestFactory);
    }

    @Override
    public AuthorizationRequest updateAfterApproval(AuthorizationRequest authorizationRequest, Authentication userAuthentication) {
        // 获取授权过的范围
        Set<String> requestedScopes = authorizationRequest.getScope();
        Set<String> approvedScopes = new HashSet<String>();
        Set<Approval> approvals = new HashSet<Approval>();
        Date expiry = computeExpiry();

        // 存储授权或拒绝的范围
        Map<String, String> approvalParameters = authorizationRequest.getApprovalParameters();
        for (String requestedScope : requestedScopes) {
            String approvalParameter = OAuth2Utils.SCOPE_PREFIX + requestedScope;
            String value = approvalParameters.get(approvalParameter);
            value = value == null ? "" : value.toLowerCase();
            if ("true".equals(value) || value.startsWith("approve")||value.equals("on")) {
                approvedScopes.add(requestedScope);
                approvals.add(new Approval(userAuthentication.getName(), authorizationRequest.getClientId(),
                        requestedScope, expiry, Approval.ApprovalStatus.APPROVED));
            }
            else {
                approvals.add(new Approval(userAuthentication.getName(), authorizationRequest.getClientId(),
                        requestedScope, expiry, Approval.ApprovalStatus.DENIED));
            }
        }
        approvalStore.addApprovals(approvals);

        boolean approved;
        authorizationRequest.setScope(approvedScopes);
        if (approvedScopes.isEmpty() && !requestedScopes.isEmpty()) {
            approved = false;
        }
        else {
            approved = true;
        }
        authorizationRequest.setApproved(approved);
        return authorizationRequest;
    }

    private Date computeExpiry() {
        Calendar expiresAt = Calendar.getInstance();
        // 默认一个月
        if (approvalExpirySeconds == -1) {
            expiresAt.add(Calendar.MONTH, 1);
        }
        else {
            expiresAt.add(Calendar.SECOND, approvalExpirySeconds);
        }
        return expiresAt.getTime();
    }

}

