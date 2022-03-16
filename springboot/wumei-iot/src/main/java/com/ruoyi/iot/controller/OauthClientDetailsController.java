package com.ruoyi.iot.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
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
import com.ruoyi.iot.domain.OauthClientDetails;
import com.ruoyi.iot.service.IOauthClientDetailsService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 云云对接Controller
 * 
 * @author kerwincui
 * @date 2022-02-07
 */
@RestController
@RequestMapping("/iot/clientDetails")
public class OauthClientDetailsController extends BaseController
{
    @Autowired
    private IOauthClientDetailsService oauthClientDetailsService;

    /**
     * 查询云云对接列表
     */
    @PreAuthorize("@ss.hasPermi('iot:clientDetails:list')")
    @GetMapping("/list")
    public TableDataInfo list(OauthClientDetails oauthClientDetails)
    {
        startPage();
        List<OauthClientDetails> list = oauthClientDetailsService.selectOauthClientDetailsList(oauthClientDetails);
        return getDataTable(list);
    }

    /**
     * 导出云云对接列表
     */
    @PreAuthorize("@ss.hasPermi('iot:clientDetails:export')")
    @Log(title = "云云对接", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, OauthClientDetails oauthClientDetails)
    {
        List<OauthClientDetails> list = oauthClientDetailsService.selectOauthClientDetailsList(oauthClientDetails);
        ExcelUtil<OauthClientDetails> util = new ExcelUtil<OauthClientDetails>(OauthClientDetails.class);
        util.exportExcel(response, list, "云云对接数据");
    }

    /**
     * 获取云云对接详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:clientDetails:query')")
    @GetMapping(value = "/{clientId}")
    public AjaxResult getInfo(@PathVariable("clientId") String clientId)
    {
        return AjaxResult.success(oauthClientDetailsService.selectOauthClientDetailsByClientId(clientId));
    }

    /**
     * 新增云云对接
     */
    @PreAuthorize("@ss.hasPermi('iot:clientDetails:add')")
    @Log(title = "云云对接", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody OauthClientDetails oauthClientDetails)
    {
        return toAjax(oauthClientDetailsService.insertOauthClientDetails(oauthClientDetails));
    }

    /**
     * 修改云云对接
     */
    @PreAuthorize("@ss.hasPermi('iot:clientDetails:edit')")
    @Log(title = "云云对接", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody OauthClientDetails oauthClientDetails)
    {
        return toAjax(oauthClientDetailsService.updateOauthClientDetails(oauthClientDetails));
    }

    /**
     * 删除云云对接
     */
    @PreAuthorize("@ss.hasPermi('iot:clientDetails:remove')")
    @Log(title = "云云对接", businessType = BusinessType.DELETE)
	@DeleteMapping("/{clientIds}")
    public AjaxResult remove(@PathVariable String[] clientIds)
    {
        return toAjax(oauthClientDetailsService.deleteOauthClientDetailsByClientIds(clientIds));
    }
}
