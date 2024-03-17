package com.fastbee.iot.mapper;

import java.util.List;
import com.fastbee.iot.domain.News;
import org.springframework.stereotype.Repository;

/**
 * 新闻资讯Mapper接口
 * 
 * @author kerwincui
 * @date 2022-04-09
 */
@Repository
public interface NewsMapper 
{
    /**
     * 查询新闻资讯
     * 
     * @param newsId 新闻资讯主键
     * @return 新闻资讯
     */
    public News selectNewsByNewsId(Long newsId);

    /**
     * 查询新闻资讯列表
     * 
     * @param news 新闻资讯
     * @return 新闻资讯集合
     */
    public List<News> selectNewsList(News news);

    /**
     * 查询置顶新闻资讯列表
     *
     * @return 新闻资讯集合
     */
    public List<News> selectTopNewsList();

    /**
     * 新增新闻资讯
     * 
     * @param news 新闻资讯
     * @return 结果
     */
    public int insertNews(News news);

    /**
     * 修改新闻资讯
     * 
     * @param news 新闻资讯
     * @return 结果
     */
    public int updateNews(News news);

    /**
     * 删除新闻资讯
     * 
     * @param newsId 新闻资讯主键
     * @return 结果
     */
    public int deleteNewsByNewsId(Long newsId);

    /**
     * 批量删除新闻资讯
     * 
     * @param newsIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteNewsByNewsIds(Long[] newsIds);
}
