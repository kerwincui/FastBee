/******************************************************************************
 * 作者：kerwincui
 * 时间：2021-06-08
 * 邮箱：164770707@qq.com
 * 源码地址：https://gitee.com/kerwincui/wumei-smart
 * author: kerwincui
 * create: 2021-06-08
 * email：164770707@qq.com
 * source:https://github.com/kerwincui/wumei-smart
 ******************************************************************************/
package com.ruoyi.system.controller;

import java.util.List;

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
import com.ruoyi.system.domain.IotGroup;
import com.ruoyi.system.service.IIotGroupService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 分组Controller
 * 
 * @author kerwincui
 * @date 2021-05-18
 */
@Api(value="设备分组",tags="设备分组")
@RestController
@RequestMapping("/system/group")
public class IotGroupController extends BaseController
{
    @Autowired
    private IIotGroupService iotGroupService;

    /**
     * 查询分组列表
     */
    @ApiOperation(value = "分组列表", notes = "分组列表")
    @PreAuthorize("@ss.hasPermi('system:group:list')")
    @GetMapping("/list")
    public TableDataInfo list(IotGroup iotGroup)
    {
        startPage();
        List<IotGroup> list = iotGroupService.selectIotGroupList(iotGroup);
        return getDataTable(list);
    }

    /**
     * 导出分组列表
     */
    @ApiOperation(value = "导出分组", notes = "导出分组")
    @PreAuthorize("@ss.hasPermi('system:group:export')")
    @Log(title = "分组", businessType = BusinessType.EXPORT)
    @GetMapping("/export")
    public AjaxResult export(IotGroup iotGroup)
    {
        List<IotGroup> list = iotGroupService.selectIotGroupList(iotGroup);
        ExcelUtil<IotGroup> util = new ExcelUtil<IotGroup>(IotGroup.class);
        return util.exportExcel(list, "group");
    }

    /**
     * 获取分组详细信息
     */
    @ApiOperation(value = "获取分组详情", notes = "获取分组详情")
    @PreAuthorize("@ss.hasPermi('system:group:query')")
    @GetMapping(value = "/{groupId}")
    public AjaxResult getInfo(@PathVariable("groupId") Long groupId)
    {
        return AjaxResult.success(iotGroupService.selectIotGroupById(groupId));
    }

    /**
     * 新增分组
     */
    @ApiOperation(value = "新增分组", notes = "新增分组")
    @PreAuthorize("@ss.hasPermi('system:group:add')")
    @Log(title = "分组", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody IotGroup iotGroup)
    {
        return toAjax(iotGroupService.insertIotGroup(iotGroup));
    }

    /**
     * 修改分组
     */
    @ApiOperation(value = "修改分组", notes = "修改分组")
    @PreAuthorize("@ss.hasPermi('system:group:edit')")
    @Log(title = "分组", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody IotGroup iotGroup)
    {
        return toAjax(iotGroupService.updateIotGroup(iotGroup));
    }

    /**
     * 删除分组
     */
    @ApiOperation(value = "删除分组", notes = "删除分组")
    @PreAuthorize("@ss.hasPermi('system:group:remove')")
    @Log(title = "分组", businessType = BusinessType.DELETE)
	@DeleteMapping("/{groupIds}")
    public AjaxResult remove(@PathVariable Long[] groupIds)
    {
        return toAjax(iotGroupService.deleteIotGroupByIds(groupIds));
    }
}
