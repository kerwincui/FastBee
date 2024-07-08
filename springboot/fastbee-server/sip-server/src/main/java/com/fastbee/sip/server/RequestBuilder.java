package com.fastbee.sip.server;

import javax.sip.header.AuthorizationHeader;
import javax.sip.header.CallIdHeader;
import javax.sip.message.Request;

public interface RequestBuilder {

    RequestBuilder requestLine(String sipId, String host, int port);

    RequestBuilder user(String user);

    RequestBuilder via(String host, int port, String transport, String viaTag);

    RequestBuilder from(String sipId, String domain, String fromTag);

    RequestBuilder to(String user, String domain, String toTag);

    RequestBuilder contact(String user, int port);

    RequestBuilder subject(String subject);

    RequestBuilder cSeq(int cSeq);

    RequestBuilder method(String method);

    RequestBuilder contentxml(byte[] content);

    RequestBuilder contentsdp(byte[] content);

    RequestBuilder authorization(AuthorizationHeader header);

    Request build(CallIdHeader callId);

    default RequestBuilder invite() {
        return method(Request.INVITE);
    }

    default RequestBuilder message() {
        return method(Request.MESSAGE);
    }

    default RequestBuilder subscribe() {
        return method(Request.SUBSCRIBE);
    }

}

