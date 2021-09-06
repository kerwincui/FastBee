package com.ruoyi.system.controller;

import java.util.List;

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
import com.ruoyi.system.domain.IotDeviceUserRelation;
import com.ruoyi.system.service.IIotDeviceUserRelationService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 【请填写功能名称】Controller
 *
 * @author wxy
 * @date 2021-08-27
 */
@RestController
@RequestMapping("/system/relation")
public class IotDeviceUserRelationController extends BaseController {
    @Autowired
    private IIotDeviceUserRelationService iotDeviceUserRelationService;

/**
 * 查询【请填写功能名称】列表
 */
@PreAuthorize("@ss.hasPermi('system:relation:list')")
@GetMapping("/list")
        public TableDataInfo list(IotDeviceUserRelation iotDeviceUserRelation) {
        startPage();
        List<IotDeviceUserRelation> list = iotDeviceUserRelationService.selectIotDeviceUserRelationList(iotDeviceUserRelation);
        return getDataTable(list);
    }
    
    /**
     * 导出【请填写功能名称】列表
     */
    @PreAuthorize("@ss.hasPermi('system:relation:export')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(IotDeviceUserRelation iotDeviceUserRelation) {
        List<IotDeviceUserRelation> list = iotDeviceUserRelationService.selectIotDeviceUserRelationList(iotDeviceUserRelation);
        ExcelUtil<IotDeviceUserRelation> util = new ExcelUtil<IotDeviceUserRelation>(IotDeviceUserRelation. class);
        return util.exportExcel(list, "relation");
    }

    /**
     * 获取【请填写功能名称】详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:relation:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(iotDeviceUserRelationService.selectIotDeviceUserRelationById(id));
    }

    /**
     * 新增【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:relation:add')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody IotDeviceUserRelation iotDeviceUserRelation) {
        return toAjax(iotDeviceUserRelationService.insertIotDeviceUserRelation(iotDeviceUserRelation));
    }

    /**
     * 修改【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:relation:edit')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody IotDeviceUserRelation iotDeviceUserRelation) {
        return toAjax(iotDeviceUserRelationService.updateIotDeviceUserRelation(iotDeviceUserRelation));
    }

    /**
     * 删除【请填写功能名称】
     */
    @PreAuthorize("@ss.hasPermi('system:relation:remove')")
    @Log(title = "【请填写功能名称】", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(iotDeviceUserRelationService.deleteIotDeviceUserRelationByIds(ids));
    }
}
