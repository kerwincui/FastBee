package com.ruoyi.iot.controller;

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
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.iot.domain.SocialPlatform;
import com.ruoyi.iot.service.ISocialPlatformService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 第三方登录平台控制Controller
 *
 * @author kerwincui
 * @date 2022-04-11
 */
@Api(tags = "第三方登录平台")
@RestController
@RequestMapping("/iot/platform")
public class SocialPlatformController extends BaseController {
    @Autowired
    private ISocialPlatformService socialPlatformService;

    /**
     * 查询第三方登录平台控制列表
     */
    @PreAuthorize("@ss.hasPermi('iot:platform:list')")
    @GetMapping("/list")
    @ApiOperation("第三方登录平台分页列表")
    public TableDataInfo list(SocialPlatform socialPlatform) {
        startPage();
        List<SocialPlatform> list = socialPlatformService.selectSocialPlatformList(socialPlatform);
        return getDataTable(list);
    }

    /**
     * 导出第三方登录平台控制列表
     */
    @PreAuthorize("@ss.hasPermi('iot:platform:export')")
    @Log(title = "第三方登录平台控制", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SocialPlatform socialPlatform) {
        List<SocialPlatform> list = socialPlatformService.selectSocialPlatformList(socialPlatform);
        ExcelUtil<SocialPlatform> util = new ExcelUtil<SocialPlatform>(SocialPlatform.class);
        util.exportExcel(response, list, "第三方登录平台控制数据");
    }

    /**
     * 获取第三方登录平台控制详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:platform:query')")
    @GetMapping(value = "/{socialPlatformId}")
    public AjaxResult getInfo(@PathVariable("socialPlatformId") Long socialPlatformId) {
        return AjaxResult.success(socialPlatformService.selectSocialPlatformBySocialPlatformId(socialPlatformId));
    }

    /**
     * 新增第三方登录平台控制
     */
    @PreAuthorize("@ss.hasPermi('iot:platform:add')")
    @Log(title = "第三方登录平台控制", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SocialPlatform socialPlatform) {
        socialPlatform.setCreateBy(getUsername());
        return toAjax(socialPlatformService.insertSocialPlatform(socialPlatform));
    }

    /**
     * 修改第三方登录平台控制
     */
    @PreAuthorize("@ss.hasPermi('iot:platform:edit')")
    @Log(title = "第三方登录平台控制", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SocialPlatform socialPlatform) {
        socialPlatform.setUpdateBy(getUsername());
        return toAjax(socialPlatformService.updateSocialPlatform(socialPlatform));
    }

    /**
     * 删除第三方登录平台控制
     */
    @PreAuthorize("@ss.hasPermi('iot:platform:remove')")
    @Log(title = "第三方登录平台控制", businessType = BusinessType.DELETE)
    @DeleteMapping("/{socialPlatformIds}")
    public AjaxResult remove(@PathVariable Long[] socialPlatformIds) {
        return toAjax(socialPlatformService.deleteSocialPlatformBySocialPlatformIds(socialPlatformIds));
    }
}
