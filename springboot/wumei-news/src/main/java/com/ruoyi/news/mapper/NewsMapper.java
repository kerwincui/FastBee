package com.ruoyi.news.mapper;

import com.ruoyi.news.domain.News;

import java.util.List;

/**
 * 新闻Mapper接口
 * 
 * @author kerwincui
 * @date 2022-04-07
 */
public interface NewsMapper 
{
    /**
     * 查询新闻
     * 
     * @param newsId 新闻主键
     * @return 新闻
     */
    public News selectNewsByNewsId(Long newsId);

    /**
     * 查询新闻列表
     * 
     * @param news 新闻
     * @return 新闻集合
     */
    public List<News> selectNewsList(News news);

    /**
     * 新增新闻
     * 
     * @param news 新闻
     * @return 结果
     */
    public int insertNews(News news);

    /**
     * 修改新闻
     * 
     * @param news 新闻
     * @return 结果
     */
    public int updateNews(News news);

    /**
     * 删除新闻
     * 
     * @param newsId 新闻主键
     * @return 结果
     */
    public int deleteNewsByNewsId(Long newsId);

    /**
     * 批量删除新闻
     * 
     * @param newsIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteNewsByNewsIds(Long[] newsIds);


    /**
     * 关联分类和新闻
     *
     * @param newsIds 需要删除的数据主键集合
     * @return 结果
     */

}
