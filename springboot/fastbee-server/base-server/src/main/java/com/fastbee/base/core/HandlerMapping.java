package com.fastbee.base.core;

import com.fastbee.base.core.hanler.BaseHandler;

/**
 * 消息处理接口
 * @author bill
 */
public interface HandlerMapping {

    BaseHandler getHandler(int messageId);
}
