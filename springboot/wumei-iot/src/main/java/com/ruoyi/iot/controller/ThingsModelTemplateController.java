package com.ruoyi.iot.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
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
import com.ruoyi.iot.domain.ThingsModelTemplate;
import com.ruoyi.iot.service.IThingsModelTemplateService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

import static com.ruoyi.common.utils.SecurityUtils.getLoginUser;

/**
 * 通用物模型Controller
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@RestController
@RequestMapping("/iot/template")
@Api(tags = "通用物模型")
public class ThingsModelTemplateController extends BaseController
{
    @Autowired
    private IThingsModelTemplateService thingsModelTemplateService;

    /**
     * 查询通用物模型列表
     */
    @PreAuthorize("@ss.hasPermi('iot:template:list')")
    @GetMapping("/list")
    @ApiOperation("通用物模型分页列表")
    public TableDataInfo list(ThingsModelTemplate thingsModelTemplate)
    {
        startPage();
        return getDataTable(thingsModelTemplateService.selectThingsModelTemplateList(thingsModelTemplate));
    }

    /**
     * 导出通用物模型列表
     */
    @PreAuthorize("@ss.hasPermi('iot:template:export')")
    @Log(title = "通用物模型", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出通用物模型")
    public void export(HttpServletResponse response, ThingsModelTemplate thingsModelTemplate)
    {
        List<ThingsModelTemplate> list = thingsModelTemplateService.selectThingsModelTemplateList(thingsModelTemplate);
        ExcelUtil<ThingsModelTemplate> util = new ExcelUtil<ThingsModelTemplate>(ThingsModelTemplate.class);
        util.exportExcel(response, list, "通用物模型数据");
    }

    /**
     * 获取通用物模型详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:template:query')")
    @GetMapping(value = "/{templateId}")
    @ApiOperation("获取通用物模型详情")
    public AjaxResult getInfo(@PathVariable("templateId") Long templateId)
    {
        return AjaxResult.success(thingsModelTemplateService.selectThingsModelTemplateByTemplateId(templateId));
    }

    /**
     * 新增通用物模型
     */
    @PreAuthorize("@ss.hasPermi('iot:template:add')")
    @Log(title = "通用物模型", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("添加通用物模型")
    public AjaxResult add(@RequestBody ThingsModelTemplate thingsModelTemplate)
    {
        return toAjax(thingsModelTemplateService.insertThingsModelTemplate(thingsModelTemplate));
    }

    /**
     * 修改通用物模型
     */
    @PreAuthorize("@ss.hasPermi('iot:template:edit')")
    @Log(title = "通用物模型", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改通用物模型")
    public AjaxResult edit(@RequestBody ThingsModelTemplate thingsModelTemplate)
    {
        return toAjax(thingsModelTemplateService.updateThingsModelTemplate(thingsModelTemplate));
    }

    /**
     * 删除通用物模型
     */
    @PreAuthorize("@ss.hasPermi('iot:template:remove')")
    @Log(title = "通用物模型", businessType = BusinessType.DELETE)
	@DeleteMapping("/{templateIds}")
    @ApiOperation("批量删除通用物模型")
    public AjaxResult remove(@PathVariable Long[] templateIds)
    {
        return toAjax(thingsModelTemplateService.deleteThingsModelTemplateByTemplateIds(templateIds));
    }
}
