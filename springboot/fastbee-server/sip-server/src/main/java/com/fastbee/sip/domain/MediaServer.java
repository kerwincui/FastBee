package com.fastbee.sip.domain;

import com.fastbee.common.annotation.Excel;
import com.fastbee.common.core.domain.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 流媒体服务器配置对象 media_server
 *
 * @author zhuangpeng.li
 * @date 2022-11-30
 */
@ApiModel(value = "MediaServer", description = "流媒体服务器配置对象 media_server")
@Data
public class MediaServer extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 流媒体配置ID */
    @ApiModelProperty("流媒体配置ID")
    private Long id;

    @ApiModelProperty("服务器标识")
    private String serverId;

    /** 租户ID */
    @ApiModelProperty("租户ID")
    @Excel(name = "租户ID")
    private Long tenantId;

    /** 租户名称 */
    @ApiModelProperty("租户名称")
    @Excel(name = "租户名称")
    private String tenantName;

    /** 是否系统通用（0-否，1-是） */
    @ApiModelProperty(value = "是否系统通用", notes = "（0-否，1-是）")
    @Excel(name = "是否系统通用", readConverterExp = "0=-否，1-是")
    private Integer isSys;

    /** 使能开关 */
    @ApiModelProperty("使能开关")
    @Excel(name = "使能开关")
    private Integer enabled;

    /** 默认播放协议 */
    @ApiModelProperty("默认播放协议")
    @Excel(name = "默认播放协议")
    private String protocol;

    @ApiModelProperty("回调服务器地址")
    @Excel(name = "回调服务器地址")
    private String hookurl;

    /** 服务器ip */
    @ApiModelProperty("服务器ip")
    @Excel(name = "服务器ip")
    private String ip;

    /** 服务器域名 */
    @ApiModelProperty("服务器域名")
    @Excel(name = "服务器域名")
    private String domain;

    /** 流媒体密钥 */
    @ApiModelProperty("流媒体密钥")
    @Excel(name = "流媒体密钥")
    private String secret;

    /** http端口 */
    @ApiModelProperty("http端口")
    @Excel(name = "http端口")
    private Long portHttp;

    /** ws端口 */
    @ApiModelProperty("ws端口")
    @Excel(name = "HTTPS端口")
    private Long portHttps;

    /** rtmp端口 */
    @ApiModelProperty("rtmp端口")
    @Excel(name = "rtmp端口")
    private Long portRtmp;

    /** rtsp端口 */
    @ApiModelProperty("rtsp端口")
    @Excel(name = "rtsp端口")
    private Long portRtsp;

    @ApiModelProperty("RTP收流端口")
    @Excel(name = "RTP收流端口（单端口模式有用）")
    private Long rtpProxyPort;

    @ApiModelProperty("是否使用多端口模式")
    @Excel(name = "是否使用多端口模式")
    private Integer rtpEnable;

    /** rtp端口范围 */
    @ApiModelProperty("rtp端口范围")
    @Excel(name = "rtp端口范围")
    private String rtpPortRange;

    @ApiModelProperty("是否自动同步配置ZLM")
    @Excel(name = "是否自动同步配置ZLM")
    private Integer autoConfig;

    @ApiModelProperty("状态")
    @Excel(name = "状态")
    private Integer status;

    @ApiModelProperty("录像服务端口")
    @Excel(name = "录像服务端口")
    private Long recordPort;

    /** 删除标志（0代表存在 2代表删除） */
    @ApiModelProperty("删除标志")
    private String delFlag;
}
