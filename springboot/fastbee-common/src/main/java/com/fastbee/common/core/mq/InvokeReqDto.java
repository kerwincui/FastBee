package com.fastbee.common.core.mq;

import com.alibaba.fastjson2.JSONObject;
import com.fastbee.common.utils.DateUtils;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.Map;

/**
 * @author gsb
 * @date 2022/12/5 11:26
 */
@Data
public class InvokeReqDto {

    @NotNull(message = "设备编号不能为空")
    @ApiModelProperty(value = "设备编号")
    private String serialNumber;

    @NotNull(message = "标识符不能为空")
    @ApiModelProperty(value = "标识符")
    private String identifier;
    /**消息体*/
    @ApiModelProperty(value = "消息体")
    private JSONObject value;
    /**远程消息体*/
    @ApiModelProperty(value = "远程调用消息体")
    private Map<String,Object> remoteCommand;
    /**设备超时时间*/
    @ApiModelProperty(value = "设备超时响应时间，默认10s")
    private Integer timeOut = 10;

    @ApiModelProperty(value = "下发物模型类型")
    @NotNull
    private Integer type;

    @ApiModelProperty(value = "是否是影子模式")
    @NotNull
    private Boolean isShadow;

    private String dataType;

    @NotNull(message = "产品id不能为空")
    @ApiModelProperty(value = "产品id")
    private Long productId;
    /**从机编号*/
    private Integer slaveId;
    /**
     * 显示的值
     */
    private String showValue;

    /**
     * 物模型名称
     */
    private String modelName;

    private Date timestamp = DateUtils.getNowDate();
}
