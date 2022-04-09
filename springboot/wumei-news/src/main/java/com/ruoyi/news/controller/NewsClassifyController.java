package com.ruoyi.news.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.common.core.domain.entity.NewsClassify;
import com.ruoyi.news.service.INewsClassifyService;
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
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 新闻分类Controller
 * 
 * @author kerwincui
 * @date 2022-04-07
 */
@RestController
@RequestMapping("/news/classify")
public class NewsClassifyController extends BaseController
{
    @Autowired
    private INewsClassifyService newsClassifyService;

    /**
     * 查询新闻分类列表
     */
    @PreAuthorize("@ss.hasPermi('news:classify:list')")
    @GetMapping("/list")
    public TableDataInfo list(NewsClassify newsClassify)
    {
        startPage();
        List<NewsClassify> list = newsClassifyService.selectNewsClassifyList(newsClassify);
        return getDataTable(list);
    }

    /**
     * 导出新闻分类列表
     */
    @PreAuthorize("@ss.hasPermi('news:classify:export')")
    @Log(title = "新闻分类", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, NewsClassify newsClassify)
    {
        List<NewsClassify> list = newsClassifyService.selectNewsClassifyList(newsClassify);
        ExcelUtil<NewsClassify> util = new ExcelUtil<NewsClassify>(NewsClassify.class);
        util.exportExcel(response, list, "新闻分类数据");
    }

    /**
     * 获取新闻分类详细信息
     */
    @PreAuthorize("@ss.hasPermi('news:classify:query')")
    @GetMapping(value = "/{classifyId}")
    public AjaxResult getInfo(@PathVariable("classifyId") Long classifyId)
    {
        return AjaxResult.success(newsClassifyService.selectNewsClassifyByClassifyId(classifyId));
    }

    /**
     * 新增新闻分类
     */
    @PreAuthorize("@ss.hasPermi('news:classify:add')")
    @Log(title = "新闻分类", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody NewsClassify newsClassify)
    {
        return toAjax(newsClassifyService.insertNewsClassify(newsClassify));
    }

    /**
     * 修改新闻分类
     */
    @PreAuthorize("@ss.hasPermi('news:classify:edit')")
    @Log(title = "新闻分类", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody NewsClassify newsClassify)
    {
        return toAjax(newsClassifyService.updateNewsClassify(newsClassify));
    }

    /**
     * 删除新闻分类
     */
    @PreAuthorize("@ss.hasPermi('news:classify:remove')")
    @Log(title = "新闻分类", businessType = BusinessType.DELETE)
	@DeleteMapping("/{classifyIds}")
    public AjaxResult remove(@PathVariable Long[] classifyIds)
    {
        return AjaxResult.success(newsClassifyService.deleteNewsClassifyByClassifyIds(classifyIds));
    }

    /**
     * 获取分类下拉树列表
     */
    @GetMapping("/treeselect")
    public AjaxResult treeselect( NewsClassify newsClassify)
    {
        List<NewsClassify> newsClassifies = newsClassifyService.selectClassifyList(newsClassify);
        return AjaxResult.success(newsClassifyService.buildClassifyTreeSelect(newsClassifies));
    }

    /**
     * 加载对应新闻分类列表树
     */
    @GetMapping(value = "/newsClassifyTreeselect/{newsId}")
    public AjaxResult newsClassifyTreeselect(@PathVariable("newsId") Long newsId)
    {
        NewsClassify newsClassify = new NewsClassify();
        List<NewsClassify> classifies = newsClassifyService.selectClassifyList(newsClassify);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("checkedKeys", newsClassifyService.selectClassifyListByNewsId(newsId));
        ajax.put("menus", newsClassifyService.buildClassifyTreeSelect(classifies));
        return ajax;
    }


}
