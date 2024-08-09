package com.fastbee.sip.handler.req;

import com.fastbee.sip.handler.IReqHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.sip.RequestEvent;

@Slf4j
@Component
public class UnknowReqHandler extends ReqAbstractHandler implements IReqHandler {

    @Override
    public void processMsg(RequestEvent evt) {
        log.warn("Unknow the method! Method:" + evt.getRequest().getMethod());
    }
}
