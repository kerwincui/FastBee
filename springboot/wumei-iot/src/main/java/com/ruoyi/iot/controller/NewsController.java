package com.ruoyi.iot.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.iot.model.CategoryNews;
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
import com.ruoyi.iot.domain.News;
import com.ruoyi.iot.service.INewsService;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 新闻资讯Controller
 * 
 * @author kerwincui
 * @date 2022-04-09
 */
@Api(tags = "新闻资讯")
@RestController
@RequestMapping("/iot/news")
public class NewsController extends BaseController
{
    @Autowired
    private INewsService newsService;

    /**
     * 查询新闻资讯列表
     */
    @PreAuthorize("@ss.hasPermi('iot:news:list')")
    @GetMapping("/list")
    @ApiOperation("新闻分页列表")
    public TableDataInfo list(News news)
    {
        startPage();
        List<News> list = newsService.selectNewsList(news);
        return getDataTable(list);
    }

    /**
     * 查询轮播的新闻资讯
     */
    @PreAuthorize("@ss.hasPermi('iot:news:list')")
    @GetMapping("/bannerList")
    @ApiOperation("轮播新闻列表")
    public AjaxResult bannerList()
    {
        News news=new News();
        news.setIsBanner(1);
        news.setStatus(1);
        List<News> list = newsService.selectNewsList(news);
        return AjaxResult.success(list);
    }

    /**
     * 查询置顶的新闻资讯
     */
    @PreAuthorize("@ss.hasPermi('iot:news:list')")
    @GetMapping("/topList")
    @ApiOperation("置顶新闻列表")
    public AjaxResult topList()
    {
        List<CategoryNews> list = newsService.selectTopNewsList();
        return AjaxResult.success(list);
    }

    /**
     * 导出新闻资讯列表
     */
    @PreAuthorize("@ss.hasPermi('iot:news:export')")
    @Log(title = "新闻资讯", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, News news)
    {
        List<News> list = newsService.selectNewsList(news);
        ExcelUtil<News> util = new ExcelUtil<News>(News.class);
        util.exportExcel(response, list, "新闻资讯数据");
    }

    /**
     * 获取新闻资讯详细信息
     */
    @PreAuthorize("@ss.hasPermi('iot:news:query')")
    @GetMapping(value = "/{newsId}")
    @ApiOperation("新闻详情")
    public AjaxResult getInfo(@PathVariable("newsId") Long newsId)
    {
        return AjaxResult.success(newsService.selectNewsByNewsId(newsId));
    }

    /**
     * 新增新闻资讯
     */
    @PreAuthorize("@ss.hasPermi('iot:news:add')")
    @Log(title = "新闻资讯", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("添加新闻资讯")
    public AjaxResult add(@RequestBody News news)
    {
        return toAjax(newsService.insertNews(news));
    }

    /**
     * 修改新闻资讯
     */
    @PreAuthorize("@ss.hasPermi('iot:news:edit')")
    @Log(title = "新闻资讯", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改新闻资讯")
    public AjaxResult edit(@RequestBody News news)
    {
        return toAjax(newsService.updateNews(news));
    }

    /**
     * 删除新闻资讯
     */
    @PreAuthorize("@ss.hasPermi('iot:news:remove')")
    @Log(title = "新闻资讯", businessType = BusinessType.DELETE)
	@DeleteMapping("/{newsIds}")
    @ApiOperation("删除新闻资讯")
    public AjaxResult remove(@PathVariable Long[] newsIds)
    {
        return toAjax(newsService.deleteNewsByNewsIds(newsIds));
    }
}
