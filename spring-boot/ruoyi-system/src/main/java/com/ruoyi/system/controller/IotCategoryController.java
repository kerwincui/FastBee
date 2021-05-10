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
import com.ruoyi.system.domain.IotCategory;
import com.ruoyi.system.service.IIotCategoryService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 设备分类Controller
 * 
 * @author kerwincui
 * @date 2021-05-07
 */
@RestController
@RequestMapping("/system/category")
public class IotCategoryController extends BaseController
{
    @Autowired
    private IIotCategoryService iotCategoryService;

    /**
     * 查询设备分类列表
     */
    @PreAuthorize("@ss.hasPermi('system:category:list')")
    @GetMapping("/list")
    public TableDataInfo list(IotCategory iotCategory)
    {
        startPage();
        List<IotCategory> list = iotCategoryService.selectIotCategoryList(iotCategory);
        return getDataTable(list);
    }

    /**
     * 导出设备分类列表
     */
    @PreAuthorize("@ss.hasPermi('system:category:export')")
    @Log(title = "设备分类", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(IotCategory iotCategory)
    {
        List<IotCategory> list = iotCategoryService.selectIotCategoryList(iotCategory);
        ExcelUtil<IotCategory> util = new ExcelUtil<IotCategory>(IotCategory.class);
        return util.exportExcel(list, "category");
    }

    /**
     * 获取设备分类详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:category:query')")
    @GetMapping(value = "/{categoryId}")
    public AjaxResult getInfo(@PathVariable("categoryId") Long categoryId)
    {
        return AjaxResult.success(iotCategoryService.selectIotCategoryById(categoryId));
    }

    /**
     * 新增设备分类
     */
    @PreAuthorize("@ss.hasPermi('system:category:add')")
    @Log(title = "设备分类", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody IotCategory iotCategory)
    {
        return toAjax(iotCategoryService.insertIotCategory(iotCategory));
    }

    /**
     * 修改设备分类
     */
    @PreAuthorize("@ss.hasPermi('system:category:edit')")
    @Log(title = "设备分类", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody IotCategory iotCategory)
    {
        return toAjax(iotCategoryService.updateIotCategory(iotCategory));
    }

    /**
     * 删除设备分类
     */
    @PreAuthorize("@ss.hasPermi('system:category:remove')")
    @Log(title = "设备分类", businessType = BusinessType.DELETE)
	@DeleteMapping("/{categoryIds}")
    public AjaxResult remove(@PathVariable Long[] categoryIds)
    {
        return toAjax(iotCategoryService.deleteIotCategoryByIds(categoryIds));
    }
}
