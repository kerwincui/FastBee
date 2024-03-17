package com.fastbee.data.controller;

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
import com.fastbee.iot.domain.FunctionLog;
import com.fastbee.iot.service.IFunctionLogService;
import com.fastbee.common.utils.poi.ExcelUtil;
import com.fastbee.common.core.page.TableDataInfo;

/**
 * 设备服务下发日志Controller
 * 
 * @author kerwincui
 * @date 2022-10-22
 */
@Api(tags = "设备服务下发日志")
@RestController
@RequestMapping("/iot/log")
public class FunctionLogController extends BaseController
{
    @Autowired
    private IFunctionLogService functionLogService;

    /**
     * 查询设备服务下发日志列表
     */
    @ApiOperation("查询设备服务下发日志列表")
    @PreAuthorize("@ss.hasPermi('iot:log:list')")
    @GetMapping("/list")
    public TableDataInfo list(FunctionLog functionLog)
    {
        startPage();
        List<FunctionLog> list = functionLogService.selectFunctionLogList(functionLog);
        return getDataTable(list);
    }

    /**
     * 导出设备服务下发日志列表
     */
    @ApiOperation("导出设备服务下发日志列表")
    @PreAuthorize("@ss.hasPermi('iot:log:export')")
    @Log(title = "设备服务下发日志", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, FunctionLog functionLog)
    {
        List<FunctionLog> list = functionLogService.selectFunctionLogList(functionLog);
        ExcelUtil<FunctionLog> util = new ExcelUtil<FunctionLog>(FunctionLog.class);
        util.exportExcel(response, list, "设备服务下发日志数据");
    }

    /**
     * 获取设备服务下发日志详细信息
     */
    @ApiOperation("获取设备服务下发日志详细信息")
    @PreAuthorize("@ss.hasPermi('iot:log:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return AjaxResult.success(functionLogService.selectFunctionLogById(id));
    }

    /**
     * 新增设备服务下发日志
     */
    @ApiOperation("新增设备服务下发日志")
    @PreAuthorize("@ss.hasPermi('iot:log:add')")
    @Log(title = "设备服务下发日志", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody FunctionLog functionLog)
    {
        return toAjax(functionLogService.insertFunctionLog(functionLog));
    }

    /**
     * 修改设备服务下发日志
     */
    @ApiOperation("修改设备服务下发日志")
    @PreAuthorize("@ss.hasPermi('iot:log:edit')")
    @Log(title = "设备服务下发日志", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody FunctionLog functionLog)
    {
        return toAjax(functionLogService.updateFunctionLog(functionLog));
    }

    /**
     * 删除设备服务下发日志
     */
    @ApiOperation("删除设备服务下发日志")
    @PreAuthorize("@ss.hasPermi('iot:log:remove')")
    @Log(title = "设备服务下发日志", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(functionLogService.deleteFunctionLogByIds(ids));
    }
}
