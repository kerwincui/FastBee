package com.ruoyi.iot.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
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
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.iot.domain.AlertLog;
import com.ruoyi.iot.service.IAlertLogService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 设备告警Controller
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
@RestController
@RequestMapping("/iot/alertLog")
public class AlertLogController extends BaseController
{
    @Autowired
    private IAlertLogService alertLogService;

    /**
     * 查询设备告警列表
     */
    @PreAuthorize("@ss.hasPermi('iot:alert:list')")
    @GetMapping("/list")
    public TableDataInfo list(AlertLog alertLog)
    {
        startPage();
        List<AlertLog> list = alertLogService.selectAlertLogList(alertLog);
        return getDataTable(list);
    }

    /**
     * 导出设备告警列表
     */
    @PreAuthorize("@ss.hasPermi('iot:alert:export')")
    @Log(title = "设备告警", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, AlertLog alertLog)
    {
        List<AlertLog> list = alertLogService.selectAlertLogList(alertLog);
        ExcelUtil<AlertLog> util = new ExcelUtil<AlertLog>(AlertLog.class);
        util.exportExcel(response, list, "设备告警数据");
    }

    /**
     * 获取设备告警详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:alert:query')")
    @GetMapping(value = "/{alertLogId}")
    public AjaxResult getInfo(@PathVariable("alertLogId") Long alertLogId)
    {
        return AjaxResult.success(alertLogService.selectAlertLogByAlertLogId(alertLogId));
    }

    /**
     * 新增设备告警
     */
    @PreAuthorize("@ss.hasPermi('iot:alert:add')")
    @Log(title = "设备告警", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AlertLog alertLog)
    {
        return toAjax(alertLogService.insertAlertLog(alertLog));
    }

    /**
     * 修改设备告警
     */
    @PreAuthorize("@ss.hasPermi('iot:alert:edit')")
    @Log(title = "设备告警", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AlertLog alertLog)
    {
        return toAjax(alertLogService.updateAlertLog(alertLog));
    }

    /**
     * 删除设备告警
     */
    @PreAuthorize("@ss.hasPermi('iot:alert:remove')")
    @Log(title = "设备告警", businessType = BusinessType.DELETE)
	@DeleteMapping("/{alertLogIds}")
    public AjaxResult remove(@PathVariable Long[] alertLogIds)
    {
        return toAjax(alertLogService.deleteAlertLogByAlertLogIds(alertLogIds));
    }
}
