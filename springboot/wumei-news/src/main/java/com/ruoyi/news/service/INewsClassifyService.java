package com.ruoyi.news.service;

import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.NewsClassify;

import java.util.List;

/**
 * 新闻分类Service接口
 * 
 * @author kerwincui
 * @date 2022-04-07
 */
public interface INewsClassifyService 
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
     * 批量删除新闻分类
     * 
     * @param classifyIds 需要删除的新闻分类主键集合
     * @return 结果
     */
    public String deleteNewsClassifyByClassifyIds(Long[] classifyIds);

    /**
     * 删除新闻分类信息
     * 
     * @param classifyId 新闻分类主键
     * @return 结果
     */
    public int deleteNewsClassifyByClassifyId(Long classifyId);


    /**
     * 查询分类列表
     *
     * @param newsClassify 分类信息
     * @return 分类列表
     */
    public List<NewsClassify> selectClassifyList(NewsClassify newsClassify);


    /**
     * 构建前端所需要下拉树结构
     *
     * @param newsClassify 分类列表
     * @return 下拉树结构列表
     */
    public List<TreeSelect> buildClassifyTreeSelect(List<NewsClassify> newsClassify);


    /**
     * 构建前端所需要树结构
     *
     * @param menus 分类列表
     * @return 树结构列表
     */
    public List<NewsClassify> buildClassifyTree(List<NewsClassify> menus);




    /**
     * 根据新闻ID查询分类树信息
     *
     * @param newsId 角色ID
     * @return 选中分类列表
     */
    public List<Integer> selectClassifyListByNewsId(Long newsId);

}
