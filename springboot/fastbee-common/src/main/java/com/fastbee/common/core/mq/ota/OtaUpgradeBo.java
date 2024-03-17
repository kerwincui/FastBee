package com.fastbee.common.core.mq.ota;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * OTA远程升级
 * @author gsb
 * @date 2022/10/10 10:22
 */
@Data
@Builder
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class OtaUpgradeBo {

    /**OTAId*/
    private Long otaId;
    @NotNull(message = "上传地址为空")
    private String otaUrl;
    @NotNull(message = "固件版本号不能为空")
    private String firmwareVersion;
    private String firmwareName;
    @NotNull(message = "流水号不能为空")
    private String seqNo;
    @NotNull(message = "产品ID不能为空")
    private Long productId;
    private String signType = "16md5";
    @NotNull(message = "签名不能为空")
    private String signCode;
    /*产品名称*/
    private String productName;
    private String fileBase64;
    private Integer pushType;
    /*设备编码，逐个升级*/
    private String serialNumber;
    private String deviceName;
    /*任务ID*/
    private Long taskId;
    /*消息id*/
    private String messageId;
    /*平台描述消息*/
    private String msg;
}
