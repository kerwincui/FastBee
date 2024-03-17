package com.fastbee.data.controller;

import com.fastbee.common.annotation.Log;
import com.fastbee.common.core.controller.BaseController;
import com.fastbee.common.core.domain.AjaxResult;
import com.fastbee.common.core.page.TableDataInfo;
import com.fastbee.common.enums.BusinessType;
import com.fastbee.common.utils.poi.ExcelUtil;
import com.fastbee.iot.domain.Product;
import com.fastbee.iot.model.ChangeProductStatusModel;
import com.fastbee.iot.model.IdAndName;
import com.fastbee.iot.service.IProductService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 产品Controller
 *
 * @author kerwincui
 * @date 2021-12-16
 */
@Api(tags = "产品管理")
@RestController
@RequestMapping("/iot/product")
public class ProductController extends BaseController
{
    @Autowired
    private IProductService productService;

    /**
     * 查询产品列表
     */
    @GetMapping("/list")
    @ApiOperation("产品分页列表")
    public TableDataInfo list(Product product)
    {
        startPage();
        return getDataTable(productService.selectProductList(product));
    }

    /**
     * 查询产品简短列表
     */
    @PreAuthorize("@ss.hasPermi('iot:product:list')")
    @GetMapping("/shortList")
    @ApiOperation("产品简短列表")
    public AjaxResult shortList(Product product)
    {

        List<IdAndName>  list = productService.selectProductShortList();
        return AjaxResult.success(list);
    }

    /**
     * 导出产品列表
     */
    @PreAuthorize("@ss.hasPermi('iot:product:export')")
    @Log(title = "产品", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出产品")
    public void export(HttpServletResponse response, Product product)
    {
        List<Product> list = productService.selectProductList(product);
        ExcelUtil<Product> util = new ExcelUtil<Product>(Product.class);
        util.exportExcel(response, list, "产品数据");
    }

    /**
     * 获取产品详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:product:query')")
    @GetMapping(value = "/{productId}")
    @ApiOperation("获取产品详情")
    public AjaxResult getInfo(@PathVariable("productId") Long productId)
    {
        return AjaxResult.success(productService.selectProductByProductId(productId));
    }

    /**
     * 新增产品
     */
    @PreAuthorize("@ss.hasPermi('iot:product:add')")
    @Log(title = "添加产品", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("添加产品")
    public AjaxResult add(@RequestBody Product product)
    {
        return AjaxResult.success(productService.insertProduct(product));
    }

    /**
     * 修改产品
     */
    @PreAuthorize("@ss.hasPermi('iot:product:edit')")
    @Log(title = "修改产品", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改产品")
    public AjaxResult edit(@RequestBody Product product)
    {
        return toAjax(productService.updateProduct(product));
    }

    /**
     * 获取产品下面的设备数量
     */
    @PreAuthorize("@ss.hasPermi('iot:product:query')")
    @GetMapping("/deviceCount/{productId}")
    @ApiOperation("获取产品下面的设备数量")
    public AjaxResult deviceCount(@PathVariable Long productId)
    {
        return AjaxResult.success(productService.selectDeviceCountByProductId(productId));
    }

    /**
     * 发布产品
     */
    @PreAuthorize("@ss.hasPermi('iot:product:add')")
    @Log(title = "更新产品状态", businessType = BusinessType.UPDATE)
    @PutMapping("/status")
    @ApiOperation("更新产品状态")
    public AjaxResult changeProductStatus(@RequestBody ChangeProductStatusModel model)
    {
        return productService.changeProductStatus(model);
    }

    /**
     * 删除产品
     */
    @PreAuthorize("@ss.hasPermi('iot:product:remove')")
    @Log(title = "产品", businessType = BusinessType.DELETE)
	@DeleteMapping("/{productIds}")
    @ApiOperation("批量删除产品")
    public AjaxResult remove(@PathVariable Long[] productIds)
    {
        return productService.deleteProductByProductIds(productIds);
    }


    /**
     * 查询采集点模板关联的所有产品
     */
    @PreAuthorize("@ss.hasPermi('iot:product:list')")
    @GetMapping("/queryByTemplateId")
    @ApiOperation("查询采集点模板id关联的所有产品")
    public AjaxResult queryByTemplateId(@RequestParam Long templateId){
        return AjaxResult.success(productService.selectByTempleId(templateId));
    }
}
