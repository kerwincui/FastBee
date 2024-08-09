package com.fastbee.sip.service;

import com.fastbee.sip.enums.SessionType;
import com.fastbee.sip.model.InviteInfo;
import com.fastbee.sip.model.VideoSessionInfo;

import java.util.List;

public interface IInviteService {

    void updateInviteInfo(VideoSessionInfo sinfo, InviteInfo inviteInfo);

    InviteInfo getInviteInfo(SessionType type,
                             String deviceId,
                             String channelId,
                             String stream);

    List<InviteInfo> getInviteInfoAll(SessionType type, String deviceId, String channelId, String stream);

    InviteInfo getInviteInfoBySSRC(String ssrc);

    void removeInviteInfo(SessionType type,
                          String deviceId,
                          String channelId,
                          String stream);
}
