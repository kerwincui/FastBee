package com.fastbee.sip.server;

import com.fastbee.sip.handler.IReqHandler;
import com.fastbee.sip.handler.IResHandler;

import javax.sip.SipListener;

public interface IGBListener extends SipListener {
    public void addRequestProcessor(String method, IReqHandler processor);
    public void addResponseProcessor(String method, IResHandler processor);
}
