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
import com.ruoyi.system.domain.TUserAccountInfo;
import com.ruoyi.system.service.ITUserAccountInfoService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 小程序用户Controller
 *
 * @author wxy
 * @date 2021-08-26
 */
@RestController
@RequestMapping("/system/info")
public class TUserAccountInfoController extends BaseController {
    @Autowired
    private ITUserAccountInfoService tUserAccountInfoService;

    /**
     * 查询小程序用户列表
     */
    @PreAuthorize("@ss.hasPermi('system:info:list')")
    @GetMapping("/list")
    public TableDataInfo list(TUserAccountInfo tUserAccountInfo) {
        startPage();
        List<TUserAccountInfo> list = tUserAccountInfoService.selectTUserAccountInfoList(tUserAccountInfo);
        return getDataTable(list);
    }

    /**
     * 导出小程序用户列表
     */
    @PreAuthorize("@ss.hasPermi('system:info:export')")
    @Log(title = "小程序用户", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(TUserAccountInfo tUserAccountInfo) {
        List<TUserAccountInfo> list = tUserAccountInfoService.selectTUserAccountInfoList(tUserAccountInfo);
        ExcelUtil<TUserAccountInfo> util = new ExcelUtil<TUserAccountInfo>(TUserAccountInfo.class);
        return util.exportExcel(list, "info");
    }

    /**
     * 获取小程序用户详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:info:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return AjaxResult.success(tUserAccountInfoService.selectTUserAccountInfoById(id));
    }

    /**
     * 新增小程序用户
     */
    @PreAuthorize("@ss.hasPermi('system:info:add')")
    @Log(title = "小程序用户", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody TUserAccountInfo tUserAccountInfo) {
        return toAjax(tUserAccountInfoService.insertTUserAccountInfo(tUserAccountInfo));
    }

    /**
     * 修改小程序用户
     */
    @PreAuthorize("@ss.hasPermi('system:info:edit')")
    @Log(title = "小程序用户", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody TUserAccountInfo tUserAccountInfo) {
        return toAjax(tUserAccountInfoService.updateTUserAccountInfo(tUserAccountInfo));
    }

    /**
     * 删除小程序用户
     */
    @PreAuthorize("@ss.hasPermi('system:info:remove')")
    @Log(title = "小程序用户", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(tUserAccountInfoService.deleteTUserAccountInfoByIds(ids));
    }
}
