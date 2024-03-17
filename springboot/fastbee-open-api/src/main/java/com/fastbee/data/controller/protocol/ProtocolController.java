package com.fastbee.data.controller.protocol;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.fastbee.common.annotation.Log;
import com.fastbee.common.core.controller.BaseController;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.enums.BusinessType;
import com.fastbee.iot.domain.Protocol;
import com.fastbee.iot.service.IProtocolService;
import com.fastbee.common.utils.poi.ExcelUtil;
import com.fastbee.common.core.page.TableDataInfo;

/**
 * 协议Controller
 * 
 * @author kerwincui
 * @date 2022-12-07
 */
@Api(tags = "协议")
@RestController
@RequestMapping("/iot/protocol")
public class ProtocolController extends BaseController
{
    @Autowired
    private IProtocolService protocolService;

    /**
     * 查询协议列表
     */
    @ApiOperation("查询协议列表")
    @PreAuthorize("@ss.hasPermi('iot:protocol:list')")
    @GetMapping("/list")
    public TableDataInfo list(Protocol protocol)
    {
        startPage();
        List<Protocol> list = protocolService.selectProtocolList(protocol);
        return getDataTable(list);
    }

    /**
     * 导出协议列表
     */
    @ApiOperation("导出协议列表")
    @PreAuthorize("@ss.hasPermi('iot:protocol:export')")
    @Log(title = "协议", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Protocol protocol)
    {
        List<Protocol> list = protocolService.selectProtocolList(protocol);
        ExcelUtil<Protocol> util = new ExcelUtil<Protocol>(Protocol.class);
        util.exportExcel(response, list, "协议数据");
    }

    /**
     * 获取协议详细信息
     */
    @ApiOperation("获取协议详细信息")
    @PreAuthorize("@ss.hasPermi('iot:protocol:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(protocolService.selectProtocolById(id));
    }

    /**
     * 新增协议
     */
    @ApiOperation("新增协议")
    @PreAuthorize("@ss.hasPermi('iot:protocol:add')")
    @Log(title = "协议", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Protocol protocol)
    {
        return toAjax(protocolService.insertProtocol(protocol));
    }

    /**
     * 修改协议
     */
    @ApiOperation("修改协议")
    @PreAuthorize("@ss.hasPermi('iot:protocol:edit')")
    @Log(title = "协议", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Protocol protocol)
    {
        return toAjax(protocolService.updateProtocol(protocol));
    }

    /**
     * 删除协议
     */
    @ApiOperation("删除协议")
    @PreAuthorize("@ss.hasPermi('iot:protocol:remove')")
    @Log(title = "协议", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(protocolService.deleteProtocolByIds(ids));
    }
}
