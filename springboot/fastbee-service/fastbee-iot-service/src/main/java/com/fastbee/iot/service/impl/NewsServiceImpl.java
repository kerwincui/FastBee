package com.fastbee.iot.service.impl;

import java.util.ArrayList;
import java.util.List;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.mapper.NewsCategoryMapper;
import com.fastbee.iot.model.CategoryNews;
import com.fastbee.iot.model.IdAndName;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fastbee.iot.mapper.NewsMapper;
import com.fastbee.iot.domain.News;
import com.fastbee.iot.service.INewsService;

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
     * 查询置顶新闻资讯列表
     *
     * @return 新闻资讯
     */
    @Override
    public List<CategoryNews> selectTopNewsList()
    {
        List<CategoryNews> categoryNewsList =new ArrayList<>();
        List<News> newsList=newsMapper.selectTopNewsList();
        for(int i=0;i<newsList.size();i++){
            boolean isAdd=false;
            for(int j=0;j<categoryNewsList.size();j++){
                if(newsList.get(i).getCategoryId().longValue()==categoryNewsList.get(j).getCategoryId().longValue()){
                    categoryNewsList.get(j).getNewsList().add(newsList.get(i));
                    isAdd=true;
                    break;
                }
            }
            if(!isAdd) {
                CategoryNews categoryNews = new CategoryNews();
                categoryNews.setCategoryId(newsList.get(i).getCategoryId());
                categoryNews.setCategoryName(newsList.get(i).getCategoryName());
                categoryNews.getNewsList().add(newsList.get(i));
                categoryNewsList.add(categoryNews);
            }
        }
        return categoryNewsList;
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
