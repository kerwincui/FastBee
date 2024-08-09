package com.fastbee.sip.handler.req;

import gov.nist.javax.sip.SipStackImpl;
import gov.nist.javax.sip.message.SIPRequest;
import gov.nist.javax.sip.message.SIPResponse;
import gov.nist.javax.sip.stack.SIPServerTransaction;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.ArrayUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import javax.sip.*;
import javax.sip.header.FromHeader;
import javax.sip.header.HeaderFactory;
import javax.sip.header.ToHeader;
import javax.sip.header.ViaHeader;
import javax.sip.message.MessageFactory;
import javax.sip.message.Request;
import javax.sip.message.Response;
import java.io.ByteArrayInputStream;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Slf4j
public abstract class ReqAbstractHandler {
    @Autowired
    @Qualifier(value = "udpSipServer")
    private SipProvider udpSipServer;

    public ServerTransaction getServerTransaction(RequestEvent evt) {
        Request request = evt.getRequest();
        ServerTransaction serverTransaction = evt.getServerTransaction();
        // 判断TCP还是UDP
        boolean isTcp = false;
        ViaHeader reqViaHeader = (ViaHeader) request.getHeader(ViaHeader.NAME);
        String transport = reqViaHeader.getTransport();
        if (transport.equals("TCP")) {
            isTcp = true;
        }

        if (serverTransaction == null) {
            try {
                if (!isTcp) {
                    SipStackImpl stack = (SipStackImpl)udpSipServer.getSipStack();
                    serverTransaction = (SIPServerTransaction) stack.findTransaction((SIPRequest)request, true);
                    if (serverTransaction == null) {
                        serverTransaction = udpSipServer.getNewServerTransaction(request);
                    }
                }
            } catch (TransactionAlreadyExistsException | TransactionUnavailableException e) {
                e.printStackTrace();
            }
        }
        return serverTransaction;
    }

    public HeaderFactory getHeaderFactory() {
        try {
            return SipFactory.getInstance().createHeaderFactory();
        } catch (PeerUnavailableException e) {
            e.printStackTrace();
        }
        return null;
    }

    public MessageFactory getMessageFactory() {
        try {
            return SipFactory.getInstance().createMessageFactory();
        } catch (PeerUnavailableException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void responseAck(RequestEvent evt) throws SipException, InvalidArgumentException, ParseException {
        Response response = getMessageFactory().createResponse(Response.OK, evt.getRequest());
        getServerTransaction(evt).sendResponse(response);
    }

    public SIPResponse responseAck(ServerTransaction serverTransaction, int statusCode) throws SipException, InvalidArgumentException, ParseException {
        return responseAck(serverTransaction, statusCode, null);
    }

    public SIPResponse responseAck(ServerTransaction serverTransaction, int statusCode, String msg) throws SipException, InvalidArgumentException, ParseException {
        ToHeader toHeader = (ToHeader) serverTransaction.getRequest().getHeader(ToHeader.NAME);
        if (toHeader.getTag() == null) {
            toHeader.setTag(String.valueOf(System.currentTimeMillis()));
        }
        SIPResponse response = (SIPResponse)getMessageFactory().createResponse(statusCode, serverTransaction.getRequest());
        if (msg != null) {
            response.setReasonPhrase(msg);
        }
        serverTransaction.sendResponse(response);
        if (statusCode >= 200 && !"NOTIFY".equalsIgnoreCase(serverTransaction.getRequest().getMethod())) {
            if (serverTransaction.getDialog() != null) {
                serverTransaction.getDialog().delete();
            }
        }
        return response;
    }

    public Element getRootElement(RequestEvent evt) throws DocumentException {
        return getRootElement(evt, "gb2312");
    }
    public Element getRootElement(RequestEvent evt, String charset) throws DocumentException {
        if (charset == null) {
            charset = "gb2312";
        }
        Request request = evt.getRequest();
        SAXReader reader = new SAXReader();
        reader.setEncoding(charset);
        // 对海康出现的未转义字符做处理。
        String[] destStrArray = new String[]{"&lt;","&gt;","&amp;","&apos;","&quot;"};
        char despChar = '&'; // 或许可扩展兼容其他字符
        byte destBye = (byte) despChar;
        List<Byte> result = new ArrayList<>();
        byte[] rawContent = request.getRawContent();
        if (rawContent == null) {
            FromHeader fromHeader = (FromHeader) request.getHeader(FromHeader.NAME);
            log.error("rawContent is null,from:{} length:{}",fromHeader.toString(),request.getContentLength());
            return null;
        }
        for (int i = 0; i < rawContent.length; i++) {
            if (rawContent[i] == destBye) {
                boolean resul = false;
                for (String destStr : destStrArray) {
                    if (i + destStr.length() <= rawContent.length) {
                        byte[] bytes = Arrays.copyOfRange(rawContent, i, i + destStr.length());
                        resul = resul || (Arrays.equals(bytes,destStr.getBytes()));
                    }
                }
                if (resul) {
                    result.add(rawContent[i]);
                }
            } else {
                result.add(rawContent[i]);
            }
        }
        Byte[] bytes = new Byte[0];
        byte[] bytesResult = ArrayUtils.toPrimitive(result.toArray(bytes));
        String content = new String(bytesResult);
        //过滤掉非法字符
        String ret = XMLChars(content);
        Document xml = reader.read(new ByteArrayInputStream(bytesResult));
        return xml.getRootElement();

    }
    public String XMLChars(String s) {
        if (s == null || "".equals(s)) {
            return s;
        }
        return s.replaceAll("[\\x00-\\x08\\x0b-\\x0c\\x0e-\\x1f]", "");
    }

}
