package com.fastbee.data.controller.wechat;

import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.exception.ServiceException;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.common.wechat.WeChatLoginBody;
import com.fastbee.common.wechat.WeChatLoginResult;
import com.fastbee.iot.wechat.WeChatService;
import com.fastbee.iot.wechat.vo.WxBindReqVO;
import com.fastbee.iot.wechat.vo.WxCancelBindReqVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 微信相关控制器
 * @author fastb
 * @date 2023-07-31 11:29
 */
@Api(tags = "微信相关模块")
@RestController
@RequestMapping("/wechat")
public class WeChatController {

    @Resource
    private WeChatService weChatService;

    /**
     * 移动应用微信登录
     * @param weChatLoginBody 微信登录参数
     * @return 登录结果
     */
    @ApiOperation("移动应用微信登录")
    @PostMapping("/mobileLogin")
    public AjaxResult mobileLogin(@RequestBody WeChatLoginBody weChatLoginBody) {
        return AjaxResult.success(weChatService.mobileLogin(weChatLoginBody));
    }

    /**
     * 小程序微信登录
     * @param weChatLoginBody 微信登录参数
     * @return 登录结果
     */
    @ApiOperation("小程序微信登录")
    @PostMapping("/miniLogin")
    public AjaxResult miniLogin(@RequestBody WeChatLoginBody weChatLoginBody) {
        WeChatLoginResult weChatLoginResult = weChatService.miniLogin(weChatLoginBody);
        return AjaxResult.success(weChatLoginResult);
    }

    /**
     * 小程序、移动应用微信绑定
     * @param wxBindReqVO 微信绑定传参类型
     * @return 结果
     */
    @ApiOperation("小程序、移动应用微信绑定")
    @PostMapping("/bind")
    public AjaxResult bind(@RequestBody WxBindReqVO wxBindReqVO) {
        if (StringUtils.isEmpty(wxBindReqVO.getSourceClient())) {
            throw new ServiceException("请传入验证方式");
        }
        return weChatService.bind(wxBindReqVO);
    }

    /**
     * 取消所有微信绑定
     * @param wxCancelBindReqVO 微信解绑传参类型
     * @return 结果
     */
    @ApiOperation("取消所有微信绑定")
    @PostMapping("/cancelBind")
    public AjaxResult cancelBind(@RequestBody WxCancelBindReqVO wxCancelBindReqVO) {
        if (wxCancelBindReqVO.getVerifyType() == null) {
            throw new ServiceException("请传入验证方式");
        }
        return weChatService.cancelBind(wxCancelBindReqVO);
    }

    /**
     * 网站应用获取微信绑定二维码信息
     * @return 二维码信息
     */
    @ApiOperation("网站应用获取微信绑定二维码信息")
    @GetMapping("/getWxBindQr")
    public AjaxResult getWxBindQr(HttpServletRequest httpServletRequest) {
        // 返回二维码信息
        return weChatService.getWxBindQr(httpServletRequest);
    }

    /**
     * 网站应用内微信扫码绑定回调接口
     * @param code 用户凭证
     * @param state 时间戳
     * @param httpServletRequest 请求信息
     * @param httpServletResponse 响应信息
     */
    @ApiOperation("网站应用内微信扫码绑定回调地址")
    @GetMapping("/wxBind/callback")
    public void wxBindCallback(String code, String state, String wxBindId, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException {
        //回调接口
        httpServletResponse.sendRedirect(weChatService.wxBindCallback(code, state, wxBindId, httpServletRequest, httpServletResponse));
    }

    /**
     * 网站应用获取微信绑定结果信息
     * @param wxBindMsgId 微信绑定结果信息id
     * @return msg
     */
    @ApiOperation("网站应用获取微信绑定结果信息")
    @GetMapping("/getWxBindMsg")
    public AjaxResult getWxBindMsg(String wxBindMsgId) {
        if (StringUtils.isEmpty(wxBindMsgId)) {
            return AjaxResult.error("请传入wxBindMsgId");
        }
        // 返回二维码信息
        return weChatService.getWxBindMsg(wxBindMsgId);
    }
}
