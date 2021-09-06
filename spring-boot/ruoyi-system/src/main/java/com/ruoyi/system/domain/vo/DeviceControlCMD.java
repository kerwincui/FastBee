package com.ruoyi.system.domain.vo;

import lombok.Data;

/**
 * 类名: DeviceControlCMD
 * 描述: 设备控制指令参数
 * 时间: 2021-08-26,0026 18:54
 * 开发人: admin
 */
@Data
public class DeviceControlCMD {
   private Long deviceId;
    String deviceNum;
    String cmd;
}
