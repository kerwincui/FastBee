package com.fastbee.data.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.fastbee.common.core.domain.entity.SysRole;
import com.fastbee.common.core.domain.entity.SysUser;
import com.fastbee.iot.domain.ThingsModel;
import com.fastbee.iot.domain.VarTemp;
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
import com.fastbee.iot.domain.ThingsModelTemplate;
import com.fastbee.iot.service.IThingsModelTemplateService;
import com.fastbee.common.utils.poi.ExcelUtil;
import com.fastbee.common.core.page.TableDataInfo;
import org.springframework.web.multipart.MultipartFile;

import static com.fastbee.common.utils.SecurityUtils.getLoginUser;

/**
 * 通用物模型Controller
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@RestController
@RequestMapping("/iot/template")
@Api(tags = "通用物模型")
public class ThingsModelTemplateController extends BaseController {
    @Autowired
    private IThingsModelTemplateService thingsModelTemplateService;

    /**
     * 查询通用物模型列表
     */
    @PreAuthorize("@ss.hasPermi('iot:template:list')")
    @GetMapping("/list")
    @ApiOperation("通用物模型分页列表")
    public TableDataInfo list(ThingsModelTemplate thingsModelTemplate) {
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
    public void export(HttpServletResponse response, ThingsModelTemplate thingsModelTemplate) {
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
    public AjaxResult getInfo(@PathVariable("templateId") Long templateId) {
        return AjaxResult.success(thingsModelTemplateService.selectThingsModelTemplateByTemplateId(templateId));
    }

    /**
     * 新增通用物模型
     */
    @PreAuthorize("@ss.hasPermi('iot:template:add')")
    @Log(title = "通用物模型", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("添加通用物模型")
    public AjaxResult add(@RequestBody ThingsModelTemplate thingsModelTemplate) {
        return toAjax(thingsModelTemplateService.insertThingsModelTemplate(thingsModelTemplate));
    }

    /**
     * 修改通用物模型
     */
    @PreAuthorize("@ss.hasPermi('iot:template:edit')")
    @Log(title = "通用物模型", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改通用物模型")
    public AjaxResult edit(@RequestBody ThingsModelTemplate thingsModelTemplate) {
        return toAjax(thingsModelTemplateService.updateThingsModelTemplate(thingsModelTemplate));
    }

    /**
     * 删除通用物模型
     */
    @PreAuthorize("@ss.hasPermi('iot:template:remove')")
    @Log(title = "通用物模型", businessType = BusinessType.DELETE)
    @DeleteMapping("/{templateIds}")
    @ApiOperation("批量删除通用物模型")
    public AjaxResult remove(@PathVariable Long[] templateIds) {
        return toAjax(thingsModelTemplateService.deleteThingsModelTemplateByTemplateIds(templateIds));
    }

    @ApiOperation(value = "物模型导入模板")
    @PostMapping("/temp")
    public void temp(HttpServletResponse response) {
        ExcelUtil<ThingsModelTemplate> excelUtil = new ExcelUtil<>(ThingsModelTemplate.class);
        excelUtil.importTemplateExcel(response, "采集点");
    }


    /**
     * 导入采集点
     */
    @PreAuthorize("@ss.hasPermi('iot:template:add')")
    @ApiOperation(value = "采集点导入")
    @PostMapping(value = "/importData")
    public AjaxResult importData(MultipartFile file, String tempSlaveId) throws Exception {
        ExcelUtil<ThingsModelTemplate> excelUtil = new ExcelUtil<>(ThingsModelTemplate.class);
        List<ThingsModelTemplate> list = excelUtil.importExcel(file.getInputStream());
        String result = thingsModelTemplateService.importData(list, tempSlaveId);
        return AjaxResult.success(result);
    }

    /**
     * 根据模板id查询采集点数据
     */
    @ApiOperation("根据模板id查询采集点数据")
    @PreAuthorize("@ss.hasPermi('iot:template:query')")
    @GetMapping("/getPoints")
    public TableDataInfo getPoints(VarTemp varTemp) {
        startPage();
        List<ThingsModelTemplate> result = thingsModelTemplateService.selectAllByTemplateId(varTemp.getTemplateId());
        return getDataTable(result);
    }
}
