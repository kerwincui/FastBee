package com.fastbee.sip.handler.req.message.response.cmdType;

import com.fastbee.common.utils.DateUtils;
import com.fastbee.sip.domain.SipDevice;
import com.fastbee.sip.domain.SipDeviceChannel;
import com.fastbee.sip.enums.ChannelType;
import com.fastbee.sip.enums.DeviceChannelStatus;
import com.fastbee.sip.handler.req.ReqAbstractHandler;
import com.fastbee.sip.handler.req.message.IMessageHandler;
import com.fastbee.sip.handler.req.message.response.ResponseMessageHandler;
import com.fastbee.sip.service.ISipDeviceChannelService;
import com.fastbee.sip.util.XmlUtil;
import lombok.extern.slf4j.Slf4j;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;

import javax.sip.InvalidArgumentException;
import javax.sip.RequestEvent;
import javax.sip.SipException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.Iterator;
import java.util.Objects;
@Slf4j
@Component
public class CatalogHandler extends ReqAbstractHandler implements InitializingBean, IMessageHandler {

    @Autowired
    private ResponseMessageHandler responseMessageHandler;

    @Autowired
    private ISipDeviceChannelService sipDeviceChannelService;
    @Override
    public void handlerCmdType(RequestEvent evt, SipDevice device, Element element) {
        try {
            Element rootElement = getRootElement(evt);
            Element deviceListElement = rootElement.element("DeviceList");
            if (deviceListElement == null) {
                return;
            }
            Iterator<Element> deviceListIterator = deviceListElement.elementIterator();
            //List<SipDeviceChannel> channels = new ArrayList<>();
            if (deviceListIterator != null) {
                // 遍历DeviceList
                while (deviceListIterator.hasNext()) {
                    SipDeviceChannel deviceChannel = new SipDeviceChannel();
                    Element itemDevice = deviceListIterator.next();
                    Element channelDeviceElement = itemDevice.element("DeviceID");
                    if (channelDeviceElement == null) {
                        log.warn("缺少 DeviceID");
                        continue;
                    }
                    String channelId = channelDeviceElement.getTextTrim();
                    if (ObjectUtils.isEmpty(channelId)) {
                        log.warn("缺少 DeviceID");
                        continue;
                    }
                    //Status
                    Element statusElement = itemDevice.element("Status");
                    if (statusElement != null) {
                        String status = statusElement.getTextTrim().trim();
                        if (status.equals("ON") || status.equals("On") || status.equals("ONLINE") || status.equals("OK")) {
                            deviceChannel.setStatus(DeviceChannelStatus.online.getValue());
                        }
                        if (status.equals("OFF") || status.equals("Off") || status.equals("OFFLINE")) {
                            deviceChannel.setStatus(DeviceChannelStatus.offline.getValue());
                        }
                    } else {
                        deviceChannel.setStatus(DeviceChannelStatus.offline.getValue());
                    }

                    ChannelType channelType = ChannelType.Other;
                    if (channelId.length() <= 8) {
                        channelType = ChannelType.CivilCode;
                        deviceChannel.setHasaudio(0);
                    }else {
                        if (channelId.length() == 20) {
                            int code = Integer.parseInt(channelId.substring(10, 13));
                            switch (code){
                                case 215:
                                    channelType = ChannelType.BusinessGroup;
                                    deviceChannel.setHasaudio(0);
                                    break;
                                case 216:
                                    channelType = ChannelType.VirtualOrganization;
                                    deviceChannel.setHasaudio(0);
                                    break;
                                case 136:
                                case 137:
                                case 138:
                                    deviceChannel.setHasaudio(1);
                                    break;
                                default:
                                    deviceChannel.setHasaudio(0);
                                    break;

                            }
                        }
                    }
                    deviceChannel.setDeviceSipId(device.getDeviceSipId());
                    deviceChannel.setChannelSipId(channelId);

                    //name
                    Element channdelNameElement = itemDevice.element("Name");
                    String channelName = channdelNameElement != null ? channdelNameElement.getTextTrim() : "";
                    deviceChannel.setChannelName(channelName);
                    //CivilCode
                    String civilCode = XmlUtil.getText(itemDevice, "CivilCode");
                    deviceChannel.setCivilcode(civilCode);
                    if (channelType == ChannelType.CivilCode && civilCode == null) {
                        deviceChannel.setParental(1);
                        // 行政区划如果没有传递具体值，则推测一个
                        if (channelId.length() > 2) {
                            deviceChannel.setCivilcode(channelId.substring(0, channelId.length() - 2));
                        }
                    }
                    if (channelType.equals(ChannelType.CivilCode)) {
                        // 行政区划其他字段没必要识别了，默认在线即可
                        deviceChannel.setStatus(1);
                        deviceChannel.setParental(1);
                        sipDeviceChannelService.updateChannel(device.getDeviceSipId(), deviceChannel);
                        continue;
                    }
                    //parentID
                    String parentId = XmlUtil.getText(itemDevice, "ParentID");
                    //String businessGroupID = XmlUtil.getText(itemDevice, "BusinessGroupID");
                    if (parentId != null) {
                        if (parentId.contains("/")) {
                            String lastParentId = parentId.substring(parentId.lastIndexOf("/") + 1);
                            deviceChannel.setParentid(lastParentId);
                        }else {
                            deviceChannel.setParentid(parentId);
                        }
                        // 兼容设备通道信息中自己为自己父节点的情况
                        if (deviceChannel.getParentid().equals(deviceChannel.getChannelSipId())) {
                            deviceChannel.setParentid(null);
                        }
                    }

                    // Parental
                    String parental = XmlUtil.getText(itemDevice, "Parental");
                    // 由于海康会错误的发送65535作为这里的取值,所以这里除非是0否则认为是1
                    if (!ObjectUtils.isEmpty(parental) && parental.length() == 1 && Integer.parseInt(parental) == 0) {
                        deviceChannel.setParental(0);
                    }else {
                        deviceChannel.setParental(1);
                    }

                    if (deviceChannel.getRegisterTime() == null) {
                        deviceChannel.setRegisterTime(DateUtils.getNowDate());
                    }
                    deviceChannel.setManufacture(XmlUtil.getText(itemDevice, "Manufacturer"));
                    deviceChannel.setModel(XmlUtil.getText(itemDevice, "Model"));
                    deviceChannel.setOwner(XmlUtil.getText(itemDevice, "Owner"));
                    deviceChannel.setBlock(XmlUtil.getText(itemDevice, "Block"));
                    deviceChannel.setAddress(XmlUtil.getText(itemDevice, "Address"));
                    deviceChannel.setIpaddress(XmlUtil.getText(itemDevice, "IPAddress"));
                    if (XmlUtil.getText(itemDevice, "Port") == null || Objects.equals(XmlUtil.getText(itemDevice, "Port"), "")) {
                        deviceChannel.setPort(0);
                    } else {
                        deviceChannel.setPort(Integer.parseInt(XmlUtil.getText(itemDevice, "Port")));
                    }
                    deviceChannel.setPassword(XmlUtil.getText(itemDevice, "Password"));

                    if (XmlUtil.getText(itemDevice, "Longitude") == null || Objects.equals(XmlUtil.getText(itemDevice, "Longitude"), "")) {
                        deviceChannel.setLongitude(BigDecimal.valueOf(0.00));
                    } else {
                        deviceChannel.setLongitude(BigDecimal.valueOf(Double.parseDouble(XmlUtil.getText(itemDevice, "Longitude"))));
                    }
                    if (XmlUtil.getText(itemDevice, "Latitude") == null || Objects.equals(XmlUtil.getText(itemDevice, "Latitude"), "")) {
                        deviceChannel.setLatitude(BigDecimal.valueOf(0.00));
                    } else {
                        deviceChannel.setLatitude(BigDecimal.valueOf(Double.parseDouble(XmlUtil.getText(itemDevice, "Latitude"))));
                    }

                    if (XmlUtil.getText(itemDevice, "PTZType") == null || "".equals(XmlUtil.getText(itemDevice, "PTZType"))) {
                        //兼容INFO中的信息
                        Element info = itemDevice.element("Info");
                        if(XmlUtil.getText(info, "PTZType") == null || "".equals(XmlUtil.getText(info, "PTZType"))){
                            deviceChannel.setPtztype(0L);
                        } else {
                            deviceChannel.setPtztype(Long.parseLong(XmlUtil.getText(info, "PTZType")));
                        }
                    } else {
                        deviceChannel.setPtztype(Long.parseLong(XmlUtil.getText(itemDevice, "PTZType")));
                    }

                    //更新到数据库
                    sipDeviceChannelService.updateChannel(device.getDeviceSipId(), deviceChannel);
                    //channels.add(deviceChannel);
                }
                // 发布设备property到emqx
                //mqttService.publishChannelsProperty(device.getDeviceSipId(),channels);
                // 回复200 OK
                responseAck(evt);
            }

        } catch (ParseException | SipException | InvalidArgumentException | DocumentException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        String cmdType = "Catalog";
        responseMessageHandler.addHandler(cmdType, this);
    }
}
