package com.fastbee.data.controller.media;

import com.fastbee.common.annotation.Log;
import com.fastbee.common.core.controller.BaseController;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.page.TableDataInfo;
import com.fastbee.common.enums.BusinessType;
import com.fastbee.common.utils.poi.ExcelUtil;
import com.fastbee.sip.domain.SipDeviceChannel;
import com.fastbee.sip.service.ISipDeviceChannelService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 监控设备通道信息Controller
 *
 * @author zhuangpeng.li
 * @date 2022-10-07
 */
@Api(tags = "监控设备通道信息")
@RestController
@RequestMapping("/sip/channel")
public class SipDeviceChannelController extends BaseController
{
    @Autowired
    private ISipDeviceChannelService sipDeviceChannelService;

    /**
     * 查询监控设备通道信息列表
     */
    @ApiOperation("查询监控设备通道信息列表")
    @PreAuthorize("@ss.hasPermi('iot:video:list')")
    @GetMapping("/list")
    public TableDataInfo list(SipDeviceChannel sipDeviceChannel)
    {
        startPage();
        List<SipDeviceChannel> list = sipDeviceChannelService.selectSipDeviceChannelList(sipDeviceChannel);
        return getDataTable(list);
    }

    /**
     * 导出监控设备通道信息列表
     */
    @ApiOperation("导出监控设备通道信息列表")
    @PreAuthorize("@ss.hasPermi('iot:video:list')")
    @Log(title = "监控设备通道信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SipDeviceChannel sipDeviceChannel)
    {
        List<SipDeviceChannel> list = sipDeviceChannelService.selectSipDeviceChannelList(sipDeviceChannel);
        ExcelUtil<SipDeviceChannel> util = new ExcelUtil<SipDeviceChannel>(SipDeviceChannel.class);
        util.exportExcel(response, list, "监控设备通道信息数据");
    }

    /**
     * 获取监控设备通道信息详细信息
     */
    @ApiOperation("获取监控设备通道信息详细信息")
    @PreAuthorize("@ss.hasPermi('iot:video:query')")
    @GetMapping(value = "/{channelId}")
    public AjaxResult getInfo(@PathVariable("channelId") Long channelId)
    {
        return AjaxResult.success(sipDeviceChannelService.selectSipDeviceChannelByChannelId(channelId));
    }

    /**
     * 新增监控设备通道信息
     */
    @ApiOperation("新增监控设备通道信息")
    @PreAuthorize("@ss.hasPermi('iot:video:add')")
    @Log(title = "监控设备通道信息", businessType = BusinessType.INSERT)
    @PostMapping(value = "/{createNum}")
    public AjaxResult add(@PathVariable("createNum") Long createNum, @RequestBody SipDeviceChannel sipDeviceChannel) {
        return AjaxResult.success("操作成功", sipDeviceChannelService.insertSipDeviceChannelGen(createNum, sipDeviceChannel));
    }

    /**
     * 修改监控设备通道信息
     */
    @ApiOperation("修改监控设备通道信息")
    @PreAuthorize("@ss.hasPermi('iot:video:edit')")
    @Log(title = "监控设备通道信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SipDeviceChannel sipDeviceChannel)
    {
        return toAjax(sipDeviceChannelService.updateSipDeviceChannel(sipDeviceChannel));
    }

    /**
     * 删除监控设备通道信息
     */
    @ApiOperation("删除监控设备通道信息")
    @PreAuthorize("@ss.hasPermi('iot:video:remove')")
    @Log(title = "监控设备通道信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{channelIds}")
    public AjaxResult remove(@PathVariable Long[] channelIds)
    {
        return toAjax(sipDeviceChannelService.deleteSipDeviceChannelByChannelIds(channelIds));
    }
}
