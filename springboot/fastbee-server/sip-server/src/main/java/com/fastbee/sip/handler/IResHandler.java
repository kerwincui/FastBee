package com.fastbee.sip.handler;

import javax.sip.ResponseEvent;
import java.text.ParseException;

public interface IResHandler {
    public void processMsg(ResponseEvent evt) throws ParseException;
}
