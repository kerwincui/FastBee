package com.ruoyi.news.service.impl;

import java.util.List;

import com.ruoyi.news.domain.NewsAndClassify;
import com.ruoyi.news.mapper.NewsAndClassifyMapper;
import com.ruoyi.news.service.INewsAndClassifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 新闻分类Service业务层处理
 * 
 * @author kerwincui
 * @date 2022-04-08
 */
@Service
public class NewsAndClassifyServiceImpl implements INewsAndClassifyService
{
    @Autowired
    private NewsAndClassifyMapper newsAndClassifyMapper;

    /**
     * 查询新闻分类
     * 
     * @param newId 新闻分类主键
     * @return 新闻分类
     */
    @Override
    public NewsAndClassify selectNewsAndClassifyByNewId(Long newId)
    {
        return newsAndClassifyMapper.selectNewsAndClassifyByNewId(newId);
    }


    /**
     * 查询新闻分类
     *
     * @param classifyId 分类主键
     * @return 新闻分类
     */
    @Override
    public NewsAndClassify selectNewsAndClassifyByClassifyId(Long classifyId) {
        return null;
    }

    /**
     * 查询新闻分类列表
     * 
     * @param newsAndClassify 新闻分类
     * @return 新闻分类
     */
    @Override
    public List<NewsAndClassify> selectNewsAndClassifyList(NewsAndClassify newsAndClassify)
    {
        return newsAndClassifyMapper.selectNewsAndClassifyList(newsAndClassify);
    }

    /**
     * 新增新闻分类
     * 
     * @param newsAndClassify 新闻分类
     * @return 结果
     */
    @Override
    public int insertNewsAndClassify(NewsAndClassify newsAndClassify)
    {
        return newsAndClassifyMapper.insertNewsAndClassify(newsAndClassify);
    }

    /**
     * 修改新闻分类
     * 
     * @param newsAndClassify 新闻分类
     * @return 结果
     */
    @Override
    public int updateNewsAndClassify(NewsAndClassify newsAndClassify)
    {
        return newsAndClassifyMapper.updateNewsAndClassify(newsAndClassify);
    }

    /**
     * 批量删除新闻分类
     * 
     * @param newIds 需要删除的新闻分类主键
     * @return 结果
     */
    @Override
    public int deleteNewsAndClassifyByNewIds(Long[] newIds)
    {
        return newsAndClassifyMapper.deleteNewsAndClassifyByNewIds(newIds);
    }

    /**
     * 删除新闻分类信息
     * 
     * @param newId 新闻分类主键
     * @return 结果
     */
    @Override
    public int deleteNewsAndClassifyByNewId(Long newId)
    {
        return newsAndClassifyMapper.deleteNewsAndClassifyByNewId(newId);
    }
}
