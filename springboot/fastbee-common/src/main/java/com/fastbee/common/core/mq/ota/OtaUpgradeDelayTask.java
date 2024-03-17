package com.fastbee.common.core.mq.ota;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fastbee.common.utils.DateUtils;
import lombok.Data;
import org.springframework.lang.NonNull;

import java.lang.reflect.Member;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Delayed;
import java.util.concurrent.TimeUnit;

/**
 * ota升级发送,实现Delayed延时接口
 *
 * @author bill
 */
@Data
public class OtaUpgradeDelayTask implements Delayed {

    /*固件id*/
    private Long firmwareId;
    private List<String> devices;
    /*任务id*/
    private Long taskId;
    /*开始升级时间*/
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date startTime;


    /**
     * 设置延迟执行时间 开始升级时间 -当前时间
     *
     * @param unit
     * @return
     */
    @Override
    public long getDelay(TimeUnit unit) {
        return startTime.getTime() - DateUtils.getTimestamp();
    }

    @Override
    public int compareTo(Delayed o) {
        OtaUpgradeDelayTask delayTask = (OtaUpgradeDelayTask) o;
        //比较
        long diff = this.startTime.getTime() - delayTask.startTime.getTime();
        if (diff <= 0) {
            return -1;
        } else {
            return 1;
        }
    }
}
