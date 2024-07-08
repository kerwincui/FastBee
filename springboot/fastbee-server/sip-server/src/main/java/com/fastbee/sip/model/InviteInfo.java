package com.fastbee.sip.model;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class InviteInfo {
    private String ssrc;
    private String callId;
    private String fromTag;
    private String viaTag;
    private int port;
}
