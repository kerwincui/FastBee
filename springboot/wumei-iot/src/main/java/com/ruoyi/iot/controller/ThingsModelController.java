package com.ruoyi.iot.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.iot.model.ImportThingsModelInput;
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
import com.ruoyi.iot.domain.ThingsModel;
import com.ruoyi.iot.service.IThingsModelService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 物模型Controller
 * 
 * @author kerwincui
 * @date 2021-12-16
 */
@RestController
@RequestMapping("/iot/model")
@Api(tags="产品物模型")
public class ThingsModelController extends BaseController
{
    @Autowired
    private IThingsModelService thingsModelService;

    /**
     * 查询物模型列表
     */
    @PreAuthorize("@ss.hasPermi('iot:device:list')")
    @GetMapping("/list")
    @ApiOperation("产品物模型分页列表")
    public TableDataInfo list(ThingsModel thingsModel)
    {
        startPage();
        List<ThingsModel> list = thingsModelService.selectThingsModelList(thingsModel);
        return getDataTable(list);
    }

    /**
     * 获取物模型详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:device:query')")
    @GetMapping(value = "/{modelId}")
    @ApiOperation("获取产品物模型详情")
    public AjaxResult getInfo(@PathVariable("modelId") Long modelId)
    {
        return AjaxResult.success(thingsModelService.selectThingsModelByModelId(modelId));
    }

    /**
     * 新增物模型
     */
    @PreAuthorize("@ss.hasPermi('iot:device:add')")
    @Log(title = "物模型", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("添加产品物模型")
    public AjaxResult add(@RequestBody ThingsModel thingsModel)
    {
        int result=thingsModelService.insertThingsModel(thingsModel);
        if(result==1){
            return AjaxResult.success();
        }else if(result==2){
            return AjaxResult.error("产品下的标识符不能重复");
        }else{
            return AjaxResult.error();
        }
    }

    @Log(title = "导入物模型",businessType = BusinessType.INSERT)
    @PostMapping("/import")
    @ApiOperation("导入通用物模型")
    public AjaxResult ImportByTemplateIds(@RequestBody ImportThingsModelInput input){
        int repeatCount=thingsModelService.importByTemplateIds(input);
        if(repeatCount==0){
            return AjaxResult.success("数据导入成功");
        }else{
            return AjaxResult.success(repeatCount+"条数据未导入，标识符重复");
        }
    }

    /**
     * 修改物模型
     */
    @PreAuthorize("@ss.hasPermi('iot:device:edit')")
    @Log(title = "物模型", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改产品物模型")
    public AjaxResult edit(@RequestBody ThingsModel thingsModel)
    {
        int result=thingsModelService.updateThingsModel(thingsModel);
        if(result==1){
            return AjaxResult.success();
        }else if(result==2){
            return AjaxResult.error("产品下的标识符不能重复");
        }else{
            return AjaxResult.error();
        }
    }

    /**
     * 删除物模型
     */
    @PreAuthorize("@ss.hasPermi('iot:device:remove')")
    @Log(title = "物模型", businessType = BusinessType.DELETE)
	@DeleteMapping("/{modelIds}")
    @ApiOperation("批量删除产品物模型")
    public AjaxResult remove(@PathVariable Long[] modelIds)
    {
        return toAjax(thingsModelService.deleteThingsModelByModelIds(modelIds));
    }

    /**
     * 获取缓存的JSON物模型
     */
    @PreAuthorize("@ss.hasPermi('iot:device:query')")
    @GetMapping(value = "/cache/{productId}")
    @ApiOperation("获取缓存的JSON物模型")
    public AjaxResult getCacheThingsModelByProductId(@PathVariable("productId") Long productId)
    {
        return AjaxResult.success("操作成功",thingsModelService.getCacheThingsModelByProductId(productId));
    }
}
