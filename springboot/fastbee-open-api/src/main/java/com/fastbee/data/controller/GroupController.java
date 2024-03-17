package com.fastbee.data.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.fastbee.iot.domain.DeviceGroup;
import com.fastbee.iot.model.DeviceGroupInput;
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
import com.fastbee.iot.domain.Group;
import com.fastbee.iot.service.IGroupService;
import com.fastbee.common.utils.poi.ExcelUtil;
import com.fastbee.common.core.page.TableDataInfo;

/**
 * 设备分组Controller
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@Api(tags = "设备分组")
@RestController
@RequestMapping("/iot/group")
public class GroupController extends BaseController
{
    @Autowired
    private IGroupService groupService;

    /**
     * 查询设备分组列表
     */
    @PreAuthorize("@ss.hasPermi('iot:group:list')")
    @GetMapping("/list")
    @ApiOperation("分组分页列表")
    public TableDataInfo list(Group group)
    {
        startPage();
        return getDataTable(groupService.selectGroupList(group));
    }

    /**
     * 导出设备分组列表
     */
    @PreAuthorize("@ss.hasPermi('iot:group:export')")
    @Log(title = "分组", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出分组")
    public void export(HttpServletResponse response, Group group)
    {
        List<Group> list = groupService.selectGroupList(group);
        ExcelUtil<Group> util = new ExcelUtil<Group>(Group.class);
        util.exportExcel(response, list, "设备分组数据");
    }

    /**
     * 获取设备分组详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:group:query')")
    @GetMapping(value = "/{groupId}")
    @ApiOperation("获取分组详情")
    public AjaxResult getInfo(@PathVariable("groupId") Long groupId)
    {
        return AjaxResult.success(groupService.selectGroupByGroupId(groupId));
    }

    /**
     * 获取分组下的所有关联设备ID数组
     */
    @PreAuthorize("@ss.hasPermi('iot:group:query')")
    @GetMapping(value = "/getDeviceIds/{groupId}")
    @ApiOperation("获取分组下的所有关联设备ID数组")
    public AjaxResult getDeviceIds(@PathVariable("groupId") Long groupId)
    {
        return AjaxResult.success(groupService.selectDeviceIdsByGroupId(groupId));
    }

    /**
     * 新增设备分组
     */
    @PreAuthorize("@ss.hasPermi('iot:group:add')")
    @Log(title = "分组", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("添加分组")
    public AjaxResult add(@RequestBody Group group)
    {
        return toAjax(groupService.insertGroup(group));
    }

    /**
     * 更新分组下的关联设备
     * @param input
     * @return
     */
    @PreAuthorize("@ss.hasPermi('iot:group:edit')")
    @Log(title = "设备分组", businessType = BusinessType.UPDATE)
    @PutMapping("/updateDeviceGroups")
    @ApiOperation("更新分组下的关联设备")
    public AjaxResult updateDeviceGroups(@RequestBody DeviceGroupInput input){
        return toAjax(groupService.updateDeviceGroups(input));
    }

    /**
     * 修改设备分组
     */
    @PreAuthorize("@ss.hasPermi('iot:group:edit')")
    @Log(title = "分组", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改分组")
    public AjaxResult edit(@RequestBody Group group)
    {
        return toAjax(groupService.updateGroup(group));
    }

    /**
     * 删除设备分组
     */
    @PreAuthorize("@ss.hasPermi('iot:group:remove')")
    @Log(title = "分组", businessType = BusinessType.DELETE)
	@DeleteMapping("/{groupIds}")
    @ApiOperation("批量删除设备分组")
    public AjaxResult remove(@PathVariable Long[] groupIds)
    {
        return toAjax(groupService.deleteGroupByGroupIds(groupIds));
    }
}
