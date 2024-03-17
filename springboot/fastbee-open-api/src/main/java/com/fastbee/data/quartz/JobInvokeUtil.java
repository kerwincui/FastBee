package com.fastbee.data.quartz;

import com.alibaba.fastjson2.JSON;
import com.fastbee.common.core.thingsModel.ThingsModelSimpleItem;
import com.fastbee.common.utils.spring.SpringUtils;
import com.fastbee.iot.domain.DeviceJob;
import com.fastbee.iot.model.Action;
import com.fastbee.mq.service.IMqttMessagePublish;

import java.util.ArrayList;
import java.util.List;

/**
 * 任务执行工具
 *
 * @author kerwincui
 */
public class JobInvokeUtil {

    /**获取消息推送接口*/
    private static IMqttMessagePublish messagePublish = SpringUtils.getBean(IMqttMessagePublish.class);


    /**
     * 执行方法
     *
     * @param deviceJob 系统任务
     */
    public static void invokeMethod(DeviceJob deviceJob) throws Exception {
        if (deviceJob.getJobType() == 1) {
            System.out.println("------------------------执行定时任务-----------------------------");
            List<Action> actions = JSON.parseArray(deviceJob.getActions(), Action.class);
            List<ThingsModelSimpleItem> propertys = new ArrayList<>();
            List<ThingsModelSimpleItem> functions = new ArrayList<>();
            for (int i = 0; i < actions.size(); i++) {
                ThingsModelSimpleItem model = new ThingsModelSimpleItem();
                model.setId(actions.get(i).getId());
                model.setValue(actions.get(i).getValue());
                model.setRemark("设备定时");
                if (actions.get(i).getType() == 1) {
                    propertys.add(model);
                } else if (actions.get(i).getType() == 2) {
                    functions.add(model);
                }
            }
            // 发布属性
            if (propertys.size() > 0) {
                messagePublish.publishProperty(deviceJob.getProductId(), deviceJob.getSerialNumber(), propertys, 0);
            }
            // 发布功能
            if (functions.size() > 0) {
                messagePublish.publishFunction(deviceJob.getProductId(), deviceJob.getSerialNumber(), functions, 0);
            }

        } else if (deviceJob.getJobType() == 2) {

        } else if (deviceJob.getJobType() == 3) {
            System.out.println("------------------------定时执行场景联动-----------------------------");
            List<Action> actions = JSON.parseArray(deviceJob.getActions(), Action.class);
            for (int i = 0; i < actions.size(); i++) {
                ThingsModelSimpleItem model = new ThingsModelSimpleItem();
                model.setId(actions.get(i).getId());
                model.setValue(actions.get(i).getValue());
                model.setRemark("场景联动定时触发");
                if (actions.get(i).getType() == 1) {
                    List<ThingsModelSimpleItem> propertys = new ArrayList<>();
                    propertys.add(model);
                    messagePublish.publishProperty(actions.get(i).getProductId(), actions.get(i).getSerialNumber(), propertys, 0);
                } else if (actions.get(i).getType() == 2) {
                    List<ThingsModelSimpleItem> functions = new ArrayList<>();
                    functions.add(model);
                    messagePublish.publishFunction(actions.get(i).getProductId(), actions.get(i).getSerialNumber(), functions, 0);
                }
            }
        }
    }
}
