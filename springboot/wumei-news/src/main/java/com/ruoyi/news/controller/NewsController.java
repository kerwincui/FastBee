package com.ruoyi.news.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.news.domain.News;
import com.ruoyi.news.service.INewsService;
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
 * 新闻Controller
 * 
 * @author kerwincui
 * @date 2022-04-07
 */
@RestController
@RequestMapping("/news/news")
public class NewsController extends BaseController
{
    @Autowired
    private INewsService newsService;

    /**
     * 查询新闻列表
     */
    @PreAuthorize("@ss.hasPermi('news:consult:list')")
    @GetMapping("/list")
    public TableDataInfo list(News news)
    {
        startPage();
        List<News> list = newsService.selectNewsList(news);
        return getDataTable(list);
    }

    /**
     * 导出新闻列表
     */
    @PreAuthorize("@ss.hasPermi('news:consult:export')")
    @Log(title = "新闻", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, News news)
    {
        List<News> list = newsService.selectNewsList(news);
        ExcelUtil<News> util = new ExcelUtil<News>(News.class);
        util.exportExcel(response, list, "新闻数据");
    }

    /**
     * 获取新闻详细信息
     */
    @PreAuthorize("@ss.hasPermi('news:consult:query')")
    @GetMapping(value = "/{newsId}")
    public AjaxResult getInfo(@PathVariable("newsId") Long newsId)
    {
        return AjaxResult.success(newsService.selectNewsByNewsId(newsId));
    }

    /**
     * 新增新闻
     */
    @PreAuthorize("@ss.hasPermi('news:consult:add')")
    @Log(title = "新闻", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody News news)
    {
        return toAjax(newsService.insertNews(news));
    }

    /**
     * 修改新闻
     */
    @PreAuthorize("@ss.hasPermi('news:consult:edit')")
    @Log(title = "新闻", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody News news)
    {
        return toAjax(newsService.updateNews(news));
    }

    /**
     * 删除新闻
     */
    @PreAuthorize("@ss.hasPermi('news:consult:remove')")
    @Log(title = "新闻", businessType = BusinessType.DELETE)
	@DeleteMapping("/{newsIds}")
    public AjaxResult remove(@PathVariable Long[] newsIds)
    {
        return toAjax(newsService.deleteNewsByNewsIds(newsIds));
    }
}
