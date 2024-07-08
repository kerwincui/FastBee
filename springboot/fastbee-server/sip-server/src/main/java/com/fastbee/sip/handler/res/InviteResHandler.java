package com.fastbee.sip.handler.res;

import com.fastbee.sip.handler.IResHandler;
import com.fastbee.sip.server.IGBListener;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sip.Dialog;
import javax.sip.InvalidArgumentException;
import javax.sip.ResponseEvent;
import javax.sip.SipException;
import javax.sip.address.SipURI;
import javax.sip.header.CSeqHeader;
import javax.sip.header.ViaHeader;
import javax.sip.message.Request;
import javax.sip.message.Response;
import java.text.ParseException;

@Slf4j
@Component
public class InviteResHandler implements InitializingBean,IResHandler {

    @Autowired
    private IGBListener sipListener;

    @Override
    public void processMsg(ResponseEvent evt) throws ParseException {
        Response response = evt.getResponse();
        Dialog dialog = evt.getDialog();
        CSeqHeader cseq = (CSeqHeader) response.getHeader(CSeqHeader.NAME);
        Request reqAck = null;
        try {
            reqAck = dialog.createAck(cseq.getSeqNumber());
            SipURI requestURI = (SipURI) reqAck.getRequestURI();
            ViaHeader viaHeader = (ViaHeader) response.getHeader(ViaHeader.NAME);
            requestURI.setHost(viaHeader.getHost());
            requestURI.setPort(viaHeader.getPort());
            reqAck.setRequestURI(requestURI);
            dialog.sendAck(reqAck);
        } catch (InvalidArgumentException | SipException | ParseException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        String method = "INVITE";
        sipListener.addResponseProcessor(method,this);
    }
}
