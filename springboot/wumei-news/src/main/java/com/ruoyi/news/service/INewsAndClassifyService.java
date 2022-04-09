package com.ruoyi.news.service;

import java.util.List;
import com.ruoyi.news.domain.NewsAndClassify;

/**
 * 新闻分类Service接口
 * 
 * @author kerwincui
 * @date 2022-04-08
 */
public interface INewsAndClassifyService 
{
    /**
     * 查询新闻分类
     * 
     * @param newId 新闻分类主键
     * @return 新闻分类
     */
    public NewsAndClassify selectNewsAndClassifyByNewId(Long newId);


    /**
     * 查询新闻分类
     *
     * @param classifyId 分类主键
     * @return 新闻分类
     */
    public NewsAndClassify selectNewsAndClassifyByClassifyId(Long classifyId);

    /**
     * 查询新闻分类列表
     * 
     * @param newsAndClassify 新闻分类
     * @return 新闻分类集合
     */
    public List<NewsAndClassify> selectNewsAndClassifyList(NewsAndClassify newsAndClassify);

    /**
     * 新增新闻分类
     * 
     * @param newsAndClassify 新闻分类
     * @return 结果
     */
    public int insertNewsAndClassify(NewsAndClassify newsAndClassify);

    /**
     * 修改新闻分类
     * 
     * @param newsAndClassify 新闻分类
     * @return 结果
     */
    public int updateNewsAndClassify(NewsAndClassify newsAndClassify);

    /**
     * 批量删除新闻分类
     * 
     * @param newIds 需要删除的新闻分类主键集合
     * @return 结果
     */
    public int deleteNewsAndClassifyByNewIds(Long[] newIds);

    /**
     * 删除新闻分类信息
     * 
     * @param newId 新闻分类主键
     * @return 结果
     */
    public int deleteNewsAndClassifyByNewId(Long newId);
}
