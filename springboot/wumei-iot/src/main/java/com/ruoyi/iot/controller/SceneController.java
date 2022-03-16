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
import com.ruoyi.iot.domain.Scene;
import com.ruoyi.iot.service.ISceneService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 场景联动Controller
 * 
 * @author kerwincui
 * @date 2022-01-13
 */
@RestController
@RequestMapping("/iot/scene")
public class SceneController extends BaseController
{
    @Autowired
    private ISceneService sceneService;

    /**
     * 查询场景联动列表
     */
    @PreAuthorize("@ss.hasPermi('iot:scene:list')")
    @GetMapping("/list")
    public TableDataInfo list(Scene scene)
    {
        startPage();
        List<Scene> list = sceneService.selectSceneList(scene);
        return getDataTable(list);
    }

    /**
     * 导出场景联动列表
     */
    @PreAuthorize("@ss.hasPermi('iot:scene:export')")
    @Log(title = "场景联动", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Scene scene)
    {
        List<Scene> list = sceneService.selectSceneList(scene);
        ExcelUtil<Scene> util = new ExcelUtil<Scene>(Scene.class);
        util.exportExcel(response, list, "场景联动数据");
    }

    /**
     * 获取场景联动详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:scene:query')")
    @GetMapping(value = "/{sceneId}")
    public AjaxResult getInfo(@PathVariable("sceneId") Long sceneId)
    {
        return AjaxResult.success(sceneService.selectSceneBySceneId(sceneId));
    }

    /**
     * 新增场景联动
     */
    @PreAuthorize("@ss.hasPermi('iot:scene:add')")
    @Log(title = "场景联动", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Scene scene)
    {
        return toAjax(sceneService.insertScene(scene));
    }

    /**
     * 修改场景联动
     */
    @PreAuthorize("@ss.hasPermi('iot:scene:edit')")
    @Log(title = "场景联动", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Scene scene)
    {
        return toAjax(sceneService.updateScene(scene));
    }

    /**
     * 删除场景联动
     */
    @PreAuthorize("@ss.hasPermi('iot:scene:remove')")
    @Log(title = "场景联动", businessType = BusinessType.DELETE)
	@DeleteMapping("/{sceneIds}")
    public AjaxResult remove(@PathVariable Long[] sceneIds)
    {
        return toAjax(sceneService.deleteSceneBySceneIds(sceneIds));
    }
}
