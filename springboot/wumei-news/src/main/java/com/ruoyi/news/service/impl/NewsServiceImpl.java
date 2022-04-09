package com.ruoyi.news.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.ruoyi.news.domain.News;
import com.ruoyi.news.domain.NewsAndClassify;
import com.ruoyi.news.mapper.NewsAndClassifyMapper;
import com.ruoyi.news.mapper.NewsMapper;
import com.ruoyi.news.service.INewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 新闻Service业务层处理
 * 
 * @author kerwincui
 * @date 2022-04-07
 */
@Service
public class NewsServiceImpl implements INewsService
{
    @Autowired
    private NewsMapper newsMapper;

    @Autowired
    private NewsAndClassifyMapper classifyMapper;

    /**
     * 查询新闻
     * 
     * @param newsId 新闻主键
     * @return 新闻
     */
    @Override
    public News selectNewsByNewsId(Long newsId)
    {
        return newsMapper.selectNewsByNewsId(newsId);
    }

    /**
     * 查询新闻列表
     * 
     * @param news 新闻
     * @return 新闻
     */
    @Override
    public List<News> selectNewsList(News news)
    {

        if (news.getClassifyId() != null && news.getClassifyId().size() == 1  ){
            Long classifyIds =news.getClassifyId().get(0);
            news.setClassifyIds(classifyIds);
        }
        return newsMapper.selectNewsList(news);
    }

    /**
     * 新增新闻
     * 
     * @param news 新闻
     * @return 结果
     */
    @Override
    public int insertNews(News news)
    {
        int i = newsMapper.insertNews(news);

        //循环添加关联表
        for (Long classifyId : news.getClassifyId()) {
            NewsAndClassify newsAndClassify = new NewsAndClassify();
            newsAndClassify.setNewId(news.getNewsId());
            newsAndClassify.setClassifyId(classifyId);
            classifyMapper.insertNewsAndClassify(newsAndClassify);
        }
        return i;
    }

    /**
     * 修改新闻
     * 
     * @param news 新闻
     * @return 结果
     */
    @Override
    public int updateNews(News news)
    {
        int i = newsMapper.updateNews(news);
        //清空绑定分类数据
        classifyMapper.deleteNewsAndClassifyByNewId(news.getNewsId());

        //循环添加关联表
        if(news.getClassifyId() != null && news.getClassifyId().size() > 0){
            for (Long classifyId : news.getClassifyId()) {
                NewsAndClassify newsAndClassify = new NewsAndClassify();
                newsAndClassify.setNewId(news.getNewsId());
                newsAndClassify.setClassifyId(classifyId);
                classifyMapper.insertNewsAndClassify(newsAndClassify);
            }
        }
        return i;
    }

    /**
     * 批量删除新闻
     * 
     * @param newsIds 需要删除的新闻主键
     * @return 结果
     */
    @Override
    public int deleteNewsByNewsIds(Long[] newsIds)
    {
        //循环删除绑定的新闻分类
        for (int i = 0; i < newsIds.length ; i++) {
            classifyMapper.deleteNewsAndClassifyByNewId(newsIds[i]);
        }

        return newsMapper.deleteNewsByNewsIds(newsIds);
    }

    /**
     * 删除新闻信息
     * 
     * @param newsId 新闻主键
     * @return 结果
     */
    @Override
    public int deleteNewsByNewsId(Long newsId)
    {
        return newsMapper.deleteNewsByNewsId(newsId);
    }
}
