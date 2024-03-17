package com.fastbee.data.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.fastbee.iot.domain.EventLog;
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
import com.fastbee.iot.service.IEventLogService;
import com.fastbee.common.utils.poi.ExcelUtil;
import com.fastbee.common.core.page.TableDataInfo;

/**
 * 事件日志Controller
 * 
 * @author kerwincui
 * @date 2023-03-28
 */
@Api(tags = "事件日志")
@RestController
@RequestMapping("/iot/event")
public class EventLogController extends BaseController
{
    @Autowired
    private IEventLogService eventLogService;

    /**
     * 查询事件日志列表
     */
    @ApiOperation("查询事件日志列表")
    @PreAuthorize("@ss.hasPermi('iot:event:list')")
    @GetMapping("/list")
    public TableDataInfo list(EventLog eventLog)
    {
        startPage();
        List<EventLog> list = eventLogService.selectEventLogList(eventLog);
        return getDataTable(list);
    }

    /**
     * 导出事件日志列表
     */
    @ApiOperation("导出事件日志列表")
    @PreAuthorize("@ss.hasPermi('iot:event:export')")
    @Log(title = "事件日志", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, EventLog eventLog)
    {
        List<EventLog> list = eventLogService.selectEventLogList(eventLog);
        ExcelUtil<EventLog> util = new ExcelUtil<EventLog>(EventLog.class);
        util.exportExcel(response, list, "事件日志数据");
    }

    /**
     * 获取事件日志详细信息
     */
    @ApiOperation("获取事件日志详细信息")
    @PreAuthorize("@ss.hasPermi('iot:event:query')")
    @GetMapping(value = "/{logId}")
    public AjaxResult getInfo(@PathVariable("logId") Long logId)
    {
        return success(eventLogService.selectEventLogByLogId(logId));
    }

    /**
     * 新增事件日志
     */
    @ApiOperation("新增事件日志")
    @PreAuthorize("@ss.hasPermi('iot:event:add')")
    @Log(title = "事件日志", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody EventLog eventLog)
    {
        return toAjax(eventLogService.insertEventLog(eventLog));
    }

    /**
     * 修改事件日志
     */
    @ApiOperation("修改事件日志")
    @PreAuthorize("@ss.hasPermi('iot:event:edit')")
    @Log(title = "事件日志", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody EventLog eventLog)
    {
        return toAjax(eventLogService.updateEventLog(eventLog));
    }

    /**
     * 删除事件日志
     */
    @ApiOperation("删除事件日志")
    @PreAuthorize("@ss.hasPermi('iot:event:remove')")
    @Log(title = "事件日志", businessType = BusinessType.DELETE)
	@DeleteMapping("/{logIds}")
    public AjaxResult remove(@PathVariable Long[] logIds)
    {
        return toAjax(eventLogService.deleteEventLogByLogIds(logIds));
    }
}
