package com.ruoyi.news.mapper;

import com.ruoyi.news.domain.NewsAndClassify;

import java.util.List;

/**
 * 新闻分类Mapper接口
 * 
 * @author kerwincui
 * @date 2022-04-08
 */
public interface NewsAndClassifyMapper 
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
     * @param newId 新闻分类主键
     * @return 新闻分类
     */
    public List<NewsAndClassify> selectNewsAndClassifysByNewId(Long newId);




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
     * 删除新闻分类
     * 
     * @param newId 新闻分类主键
     * @return 结果
     */
    public int deleteNewsAndClassifyByNewId(Long newId);


    /**
     * 批量删除新闻分类
     * 
     * @param newIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteNewsAndClassifyByNewIds(Long[] newIds);
}
