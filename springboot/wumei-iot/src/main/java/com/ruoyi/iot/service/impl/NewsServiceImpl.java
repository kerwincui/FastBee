package com.ruoyi.iot.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.iot.mapper.NewsMapper;
import com.ruoyi.iot.domain.News;
import com.ruoyi.iot.service.INewsService;

/**
 * 新闻资讯Service业务层处理
 * 
 * @author kerwincui
 * @date 2022-04-09
 */
@Service
public class NewsServiceImpl implements INewsService 
{
    @Autowired
    private NewsMapper newsMapper;

    /**
     * 查询新闻资讯
     * 
     * @param newsId 新闻资讯主键
     * @return 新闻资讯
     */
    @Override
    public News selectNewsByNewsId(Long newsId)
    {
        return newsMapper.selectNewsByNewsId(newsId);
    }

    /**
     * 查询新闻资讯列表
     * 
     * @param news 新闻资讯
     * @return 新闻资讯
     */
    @Override
    public List<News> selectNewsList(News news)
    {
        return newsMapper.selectNewsList(news);
    }

    /**
     * 新增新闻资讯
     * 
     * @param news 新闻资讯
     * @return 结果
     */
    @Override
    public int insertNews(News news)
    {
        news.setCreateTime(DateUtils.getNowDate());
        return newsMapper.insertNews(news);
    }

    /**
     * 修改新闻资讯
     * 
     * @param news 新闻资讯
     * @return 结果
     */
    @Override
    public int updateNews(News news)
    {
        news.setUpdateTime(DateUtils.getNowDate());
        return newsMapper.updateNews(news);
    }

    /**
     * 批量删除新闻资讯
     * 
     * @param newsIds 需要删除的新闻资讯主键
     * @return 结果
     */
    @Override
    public int deleteNewsByNewsIds(Long[] newsIds)
    {
        return newsMapper.deleteNewsByNewsIds(newsIds);
    }

    /**
     * 删除新闻资讯信息
     * 
     * @param newsId 新闻资讯主键
     * @return 结果
     */
    @Override
    public int deleteNewsByNewsId(Long newsId)
    {
        return newsMapper.deleteNewsByNewsId(newsId);
    }
}
