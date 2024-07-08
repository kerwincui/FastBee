package com.fastbee.sip.handler.req.message.response.cmdType;

import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.handler.req.ReqAbstractHandler;
import com.fastbee.sip.handler.req.message.IMessageHandler;
import com.fastbee.sip.handler.req.message.response.ResponseMessageHandler;
import com.fastbee.sip.model.RecordItem;
import com.fastbee.sip.model.RecordList;
import com.fastbee.sip.server.RecordCacheManager;
import com.fastbee.sip.service.ISipCacheService;
import com.fastbee.sip.util.SipUtil;
import com.fastbee.sip.util.XmlUtil;
import lombok.extern.slf4j.Slf4j;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.sip.InvalidArgumentException;
import javax.sip.RequestEvent;
import javax.sip.SipException;
import java.text.ParseException;
import java.util.Iterator;
import java.util.concurrent.locks.ReentrantLock;
@Slf4j
@Component
public class RecordInfoHandler extends ReqAbstractHandler implements InitializingBean, IMessageHandler {

    @Autowired
    private ResponseMessageHandler responseMessageHandler;

    @Autowired
    private ISipCacheService sipCacheService;

    @Autowired
    private RecordCacheManager recordCacheManager;
    @Override
    public void handlerCmdType(RequestEvent evt, SipDevice device, Element element) {
        try {
            // 回复200 OK
            responseAck(evt);
            Element rootElement = getRootElement(evt);
            String deviceId = rootElement.element("DeviceID").getText();
            String sn = XmlUtil.getText(rootElement, "SN");
            String sumNum = XmlUtil.getText(rootElement, "SumNum");
            String recordkey = deviceId + ":" + sn;
            int recordnum = 0;
            RecordList recordList = recordCacheManager.get(recordkey);
            recordList.setDeviceID(deviceId);
            Element recordListElement = rootElement.element("RecordList");
            if (recordListElement == null || sumNum == null || sumNum.equals("")) {
                log.info("无录像数据");
            } else {
                Iterator<Element> recordListIterator = recordListElement.elementIterator();
                if (recordListIterator != null) {
                    while (recordListIterator.hasNext()) {
                        Element itemRecord = recordListIterator.next();
                        Element recordElement = itemRecord.element("DeviceID");
                        if (recordElement == null) {
                            continue;
                        }
                        RecordItem item = new RecordItem();
                        item.setStart(SipUtil.ISO8601Totimestamp(XmlUtil.getText(itemRecord, "StartTime")));
                        item.setEnd(SipUtil.ISO8601Totimestamp(XmlUtil.getText(itemRecord, "EndTime")));
                        recordList.addItem(item);
                        recordnum++;
                    }
                }
            }
            log.info("getSumNum:{}", recordList.getSumNum());
            if (recordList.getSumNum() + recordnum == Integer.parseInt(sumNum)) {
                //时间合并 保存到redia
                recordList.mergeItems();
                log.info("mergeItems recordList:{}", recordList);
                recordCacheManager.remove(recordkey);
                sipCacheService.setRecordList(recordkey, recordList);
                //发布设备property到emqx
            } else {
                recordList.setSumNum(recordList.getSumNum() + recordnum);
                recordCacheManager.put(recordkey, recordList);
            }
        } catch (DocumentException | SipException | InvalidArgumentException | ParseException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        String cmdType = "RecordInfo";
        responseMessageHandler.addHandler(cmdType, this);
    }
}
