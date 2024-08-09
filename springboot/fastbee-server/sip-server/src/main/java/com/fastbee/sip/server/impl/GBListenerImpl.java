package com.fastbee.sip.server.impl;

import com.fastbee.sip.handler.IReqHandler;
import com.fastbee.sip.handler.IResHandler;
import com.fastbee.sip.server.IGBListener;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import javax.sip.*;
import javax.sip.header.CSeqHeader;
import javax.sip.message.Response;
import java.text.ParseException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@Component
public class GBListenerImpl implements IGBListener {

    private static final Map<String, IReqHandler> requestProcessorMap = new ConcurrentHashMap<>();
    private static final Map<String, IResHandler> responseProcessorMap = new ConcurrentHashMap<>();

    public void addRequestProcessor(String method, IReqHandler processor) {
        requestProcessorMap.put(method, processor);
    }

    public void addResponseProcessor(String method, IResHandler processor) {
        responseProcessorMap.put(method, processor);
    }

    @Override
    @Async("taskExecutor")
    public void processRequest(RequestEvent evt) {
        String method = evt.getRequest().getMethod();
        IReqHandler sipRequestProcessor = requestProcessorMap.get(method);
        if (sipRequestProcessor == null) {
            log.warn("不支持方法{}的request", method);
            return;
        }
        requestProcessorMap.get(method).processMsg(evt);
    }

    @Override
    @Async("taskExecutor")
    public void processResponse(ResponseEvent evt) {
        //处理响应消息
        Response response = evt.getResponse();
        int status = response.getStatusCode();
        // 响应成功
        if ((status >= Response.OK) && (status < Response.MULTIPLE_CHOICES)) {
            log.info("response：{},",response.getReasonPhrase());
            CSeqHeader cseqHeader = (CSeqHeader) evt.getResponse().getHeader(CSeqHeader.NAME);
            String method = cseqHeader.getMethod();
            log.info("接收response响应！status：{},message:{},method:{}",status,response.getReasonPhrase(),method);
            IResHandler sipRequestProcessor = responseProcessorMap.get(method);
            if (sipRequestProcessor != null) {
                try {
                    sipRequestProcessor.processMsg(evt);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        } else if ((status >= Response.TRYING) && (status < Response.OK)) {
            log.info("接收response响应！status：{},,message:{}",status,response.getReasonPhrase());
        } else {
            log.warn("接收到失败的response响应！status：{},,message:{}",status,response.getReasonPhrase());
        }
    }

    @Override
    public void processTimeout(TimeoutEvent timeoutEvent) {
        log.info("processTimeout：{}", timeoutEvent);
    }

    @Override
    public void processIOException(IOExceptionEvent ioExceptionEvent) {
        //log.debug("processIOException：{}", ioExceptionEvent);
    }

    @Override
    public void processTransactionTerminated(TransactionTerminatedEvent transactionTerminatedEvent) {
        //log.debug("processTransactionTerminated：{}", transactionTerminatedEvent);
    }

    @Override
    public void processDialogTerminated(DialogTerminatedEvent dialogTerminatedEvent) {
        //log.debug("processDialogTerminated：{}", dialogTerminatedEvent);
    }
}
