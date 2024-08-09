package com.fastbee.sip.server.impl;

import com.fastbee.sip.server.RequestBuilder;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;

import javax.sip.SipFactory;
import javax.sip.address.Address;
import javax.sip.address.SipURI;
import javax.sip.header.*;
import javax.sip.message.Request;
import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
public class RequestBuilderImpl implements RequestBuilder {
    private SipFactory sipFactory;
    private String host;
    private int port;
    private String user;
    private String method;
    private boolean transportTcp;
    private long cSeq = 1L;
    private final List<ViaHeader> viaHeaders = new ArrayList<>();

    private ContactHeader contactHeader;
    private SubjectHeader subjectHeader;
    private FromHeader fromHeader;
    private ToHeader toHeader;
    private AuthorizationHeader authorizationHeader;
    private ContentTypeHeader contentTypeHeader;
    private byte[] content;
    private SipURI requestLine;

    public RequestBuilderImpl(SipFactory sipFactory) {
        this.sipFactory = sipFactory;
    }

    @Override
    @SneakyThrows
    public RequestBuilder requestLine(String sipId, String host, int port) {
        requestLine = sipFactory.createAddressFactory().createSipURI(sipId, host + ":" + port);
        return this;
    }

    @Override
    public RequestBuilder user(String user) {
        this.user = user;
        return this;
    }

    @Override
    public RequestBuilder method(String method) {
        this.method = method;
        return this;
    }

    @Override
    @SneakyThrows
    public RequestBuilder via(String host,
                              int port,
                              String transport,
                              String viaTag) {
        this.port = port;
        this.transportTcp = "TCP".equals(transport);
        this.host = host;
        ViaHeader viaHeader = sipFactory.createHeaderFactory()
                .createViaHeader(host, port, transport, viaTag);
        viaHeader.setRPort();
        viaHeaders.add(viaHeader);
        return this;
    }

    @Override
    @SneakyThrows
    public RequestBuilder from(String sipId,
                               String domain,
                               String fromTag) {
        SipURI from = sipFactory.createAddressFactory().createSipURI(sipId, domain);
        Address fromAddress = sipFactory.createAddressFactory().createAddress(from);
        fromHeader = sipFactory.createHeaderFactory()
                .createFromHeader(fromAddress, fromTag);
        return this;
    }

    @Override
    @SneakyThrows
    public RequestBuilder to(String sipId,
                             String domain,
                             String toTag) {
        SipURI from = sipFactory.createAddressFactory().createSipURI(sipId, domain);
        Address fromAddress = sipFactory.createAddressFactory().createAddress(from);
        toHeader = sipFactory.createHeaderFactory()
                .createToHeader(fromAddress, toTag);

        return this;
    }

    @Override
    @SneakyThrows
    public RequestBuilder contact(String user, int port) {
        Address concatAddress = sipFactory.createAddressFactory()
                .createAddress(sipFactory.createAddressFactory()
                        .createSipURI(user, user + ":" + port));
        contactHeader = sipFactory.createHeaderFactory().createContactHeader(concatAddress);
        return this;
    }

    @Override
    public RequestBuilder cSeq(int cSeq) {
        this.cSeq = cSeq;
        return this;
    }

    @Override
    @SneakyThrows
    public RequestBuilder subject(String subject) {
        subjectHeader = sipFactory.createHeaderFactory()
                .createSubjectHeader(subject);

        return this;
    }

    @Override
    @SneakyThrows
    public RequestBuilder contentxml(byte[] content) {
        contentTypeHeader = sipFactory.createHeaderFactory()
                .createContentTypeHeader("APPLICATION", "MANSCDP+xml");
        this.content = content;
        return this;
    }

    @Override
    @SneakyThrows
    public RequestBuilder contentsdp(byte[] content) {
        contentTypeHeader = sipFactory.createHeaderFactory()
                .createContentTypeHeader("APPLICATION", "SDP");
        this.content = content;
        return this;
    }

    @Override
    public RequestBuilder authorization(AuthorizationHeader header) {
        this.authorizationHeader = header;
        return this;
    }

    @Override
    @SneakyThrows
    public Request build(CallIdHeader callId) {
        //请求行
        SipURI requestLine = this.requestLine == null ? sipFactory.createAddressFactory()
                .createSipURI(user, host + ":" + port)
                : this.requestLine;

        //callid
        CallIdHeader callIdHeader = callId;

        //Forwards
        MaxForwardsHeader maxForwards = sipFactory.createHeaderFactory().createMaxForwardsHeader(70);

        //ceq
        CSeqHeader cSeqHeader = sipFactory.createHeaderFactory().createCSeqHeader(cSeq, method);
        Request request = sipFactory.createMessageFactory()
                .createRequest(requestLine, method, callIdHeader, cSeqHeader, fromHeader, toHeader, viaHeaders, maxForwards);
        //Authorization
        if (this.authorizationHeader != null) {
            request.addHeader(this.authorizationHeader);
        }
        //Contact
        if (contactHeader != null) {
            request.addHeader(contactHeader);
        }
        // Subject
        if (subjectHeader != null) {
            request.addHeader(subjectHeader);
        }
        //Content
        if (content != null) {
            request.setContent(content, contentTypeHeader);
        }

        return request;

    }
}
