package com.fastbee.sip.server;

import com.fastbee.sip.domain.SipConfig;
import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.model.InviteInfo;
import com.fastbee.sip.service.ISipCacheService;
import com.fastbee.sip.util.SipUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;

import javax.sip.*;
import javax.sip.address.Address;
import javax.sip.address.SipURI;
import javax.sip.header.*;
import javax.sip.message.Request;
import java.text.ParseException;
import java.util.ArrayList;

@Component
public class ReqMsgHeaderBuilder {
    @Autowired
    private SipFactory sipFactory;

    @Autowired
    @Qualifier(value = "udpSipServer")
    private SipProvider sipserver;

    @Autowired
    private ISipCacheService sipCacheService;

    public Request createInviteRequest(SipDevice device, SipConfig sipConfig, String channelId, String content, String ssrc, String fromTag) throws ParseException, InvalidArgumentException, PeerUnavailableException {
        Request request = null;
        // 请求行
        SipURI requestLine = sipFactory.createAddressFactory().createSipURI(channelId, device.getHostAddress());
        // via
        ArrayList<ViaHeader> viaHeaders = new ArrayList<ViaHeader>();
        ViaHeader viaHeader = sipFactory.createHeaderFactory().createViaHeader(device.getIp(), device.getPort(),
                device.getTransport(), SipUtil.getNewViaTag());
        viaHeader.setRPort();
        viaHeaders.add(viaHeader);
        // from
        SipURI fromSipURI = sipFactory.createAddressFactory().createSipURI(sipConfig.getServerSipid(),
                sipConfig.getDomain());
        Address fromAddress = sipFactory.createAddressFactory().createAddress(fromSipURI);
        FromHeader fromHeader = sipFactory.createHeaderFactory().createFromHeader(fromAddress, fromTag); // 必须要有标记，否则无法创建会话，无法回应ack
        // to
        SipURI toSipURI = sipFactory.createAddressFactory().createSipURI(channelId, sipConfig.getDomain());
        Address toAddress = sipFactory.createAddressFactory().createAddress(toSipURI);
        ToHeader toHeader = sipFactory.createHeaderFactory().createToHeader(toAddress, null);

        // callid
        CallIdHeader callIdHeader = sipserver.getNewCallId();

        // Forwards
        MaxForwardsHeader maxForwards = sipFactory.createHeaderFactory().createMaxForwardsHeader(70);

        // ceq
        CSeqHeader cSeqHeader = sipFactory.createHeaderFactory().createCSeqHeader(sipCacheService.getCSEQ(sipConfig.getServerSipid()), Request.INVITE);
        request = sipFactory.createMessageFactory().createRequest(requestLine, Request.INVITE, callIdHeader, cSeqHeader,
                fromHeader, toHeader, viaHeaders, maxForwards);

        Address concatAddress = sipFactory.createAddressFactory().createAddress(sipFactory.createAddressFactory()
                .createSipURI(sipConfig.getServerSipid(), sipConfig.getIp() + ":" + sipConfig.getPort()));

        request.addHeader(sipFactory.createHeaderFactory().createContactHeader(concatAddress));
        // Subject
        SubjectHeader subjectHeader = sipFactory.createHeaderFactory()
                .createSubjectHeader(String.format("%s:%s,%s:%s", channelId, ssrc, sipConfig.getIp(), 0));
        request.addHeader(subjectHeader);
        ContentTypeHeader contentTypeHeader = sipFactory.createHeaderFactory().createContentTypeHeader("APPLICATION",
                "SDP");
        request.setContent(content, contentTypeHeader);
        return request;
    }

    public Request createByeRequest(SipDevice device, SipConfig sipConfig, String channelId, InviteInfo invite) throws ParseException, InvalidArgumentException, PeerUnavailableException {
        Request request = null;
        //请求行
        SipURI requestLine = SipFactory.getInstance().createAddressFactory().createSipURI(channelId, device.getHostAddress());
        // via
        ArrayList<ViaHeader> viaHeaders = new ArrayList<ViaHeader>();
        ViaHeader viaHeader = sipFactory.createHeaderFactory().createViaHeader(device.getIp(), device.getPort(),
                device.getTransport(), SipUtil.getNewViaTag());
        viaHeader.setRPort();
        viaHeaders.add(viaHeader);
        //from
        SipURI fromSipURI = SipFactory.getInstance().createAddressFactory().createSipURI(sipConfig.getServerSipid(), sipConfig.getDomain());
        Address fromAddress = SipFactory.getInstance().createAddressFactory().createAddress(fromSipURI);
        FromHeader fromHeader = SipFactory.getInstance().createHeaderFactory().createFromHeader(fromAddress, invite.getFromTag());
        //to
        SipURI toSipURI = SipFactory.getInstance().createAddressFactory().createSipURI(channelId, device.getHostAddress());
        Address toAddress = SipFactory.getInstance().createAddressFactory().createAddress(toSipURI);
        ToHeader toHeader = SipFactory.getInstance().createHeaderFactory().createToHeader(toAddress, SipUtil.getNewTag());
        //Forwards
        MaxForwardsHeader maxForwards = SipFactory.getInstance().createHeaderFactory().createMaxForwardsHeader(70);
        //ceq
        CSeqHeader cSeqHeader = SipFactory.getInstance().createHeaderFactory().createCSeqHeader(sipCacheService.getCSEQ(sipConfig.getServerSipid()), Request.BYE);
        CallIdHeader callIdHeader = SipFactory.getInstance().createHeaderFactory().createCallIdHeader(invite.getCallId());
        request = SipFactory.getInstance().createMessageFactory().createRequest(requestLine, Request.BYE, callIdHeader, cSeqHeader, fromHeader, toHeader, viaHeaders, maxForwards);

        Address concatAddress = sipFactory.createAddressFactory().createAddress(sipFactory.createAddressFactory()
                .createSipURI(sipConfig.getServerSipid(), sipConfig.getIp() + ":" + sipConfig.getPort()));
        request.addHeader(sipFactory.createHeaderFactory().createContactHeader(concatAddress));
        return request;
    }
}
