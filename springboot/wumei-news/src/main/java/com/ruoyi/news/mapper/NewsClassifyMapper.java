package com.ruoyi.news.mapper;

import com.ruoyi.common.core.domain.entity.NewsClassify;

import java.util.List;

/**
 * 新闻分类Mapper接口
 * 
 * @author kerwincui
 * @date 2022-04-07
 */
public interface NewsClassifyMapper 
{
    /**
     * 查询新闻分类
     * 
     * @param classifyId 新闻分类主键
     * @return 新闻分类
     */
    public NewsClassify selectNewsClassifyByClassifyId(Long classifyId);

    /**
     * 查询新闻分类列表
     * 
     * @param newsClassify 新闻分类
     * @return 新闻分类集合
     */
    public List<NewsClassify> selectNewsClassifyList(NewsClassify newsClassify);

    /**
     * 新增新闻分类
     * 
     * @param newsClassify 新闻分类
     * @return 结果
     */
    public int insertNewsClassify(NewsClassify newsClassify);

    /**
     * 修改新闻分类
     * 
     * @param newsClassify 新闻分类
     * @return 结果
     */
    public int updateNewsClassify(NewsClassify newsClassify);

    /**
     * 删除新闻分类
     * 
     * @param classifyId 新闻分类主键
     * @return 结果
     */
    public int deleteNewsClassifyByClassifyId(Long classifyId);

    /**
     * 批量删除新闻分类
     * 
     * @param classifyIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteNewsClassifyByClassifyIds(Long[] classifyIds);


}
