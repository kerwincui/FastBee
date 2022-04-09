package com.ruoyi.news.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import com.alibaba.fastjson.JSONObject;
import com.ruoyi.common.core.domain.TreeSelect;
import com.ruoyi.common.core.domain.entity.NewsClassify;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.news.domain.NewsAndClassify;
import com.ruoyi.news.mapper.NewsAndClassifyMapper;
import com.ruoyi.news.mapper.NewsClassifyMapper;
import com.ruoyi.news.service.INewsClassifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 新闻分类Service业务层处理
 * 
 * @author kerwincui
 * @date 2022-04-07
 */
@Service
public class NewsClassifyServiceImpl implements INewsClassifyService
{
    @Autowired
    private NewsClassifyMapper newsClassifyMapper;

    @Autowired
    private NewsAndClassifyMapper newsAndClassifyMapper;

    /**
     * 查询新闻分类
     * 
     * @param classifyId 新闻分类主键
     * @return 新闻分类
     */
    @Override
    public NewsClassify selectNewsClassifyByClassifyId(Long classifyId)
    {
        return newsClassifyMapper.selectNewsClassifyByClassifyId(classifyId);
    }

    /**
     * 查询新闻分类列表
     * 
     * @param newsClassify 新闻分类
     * @return 新闻分类
     */
    @Override
    public List<NewsClassify> selectNewsClassifyList(NewsClassify newsClassify)
    {
        return newsClassifyMapper.selectNewsClassifyList(newsClassify);
    }

    /**
     * 新增新闻分类
     * 
     * @param newsClassify 新闻分类
     * @return 结果
     */
    @Override
    public int insertNewsClassify(NewsClassify newsClassify)
    {
        newsClassify.setCreateTime(DateUtils.getNowDate());
        return newsClassifyMapper.insertNewsClassify(newsClassify);
    }

    /**
     * 修改新闻分类
     * 
     * @param newsClassify 新闻分类
     * @return 结果
     */
    @Override
    public int updateNewsClassify(NewsClassify newsClassify)
    {
        newsClassify.setUpdateTime(DateUtils.getNowDate());
        return newsClassifyMapper.updateNewsClassify(newsClassify);
    }

    /**
     * 批量删除新闻分类
     * 
     * @param classifyIds 需要删除的新闻分类主键
     * @return 结果
     */
    @Override
    public String deleteNewsClassifyByClassifyIds(Long[] classifyIds)
    {
        List<String> jsonObjectList = new ArrayList<>();
        for (int i = 0; i < classifyIds.length; i++) {

            NewsAndClassify newsAndClassify = newsAndClassifyMapper.selectNewsAndClassifyByClassifyId(classifyIds[i]);
            if(newsAndClassify != null){
                jsonObjectList.add("分类主键ID："+classifyIds[i]+"  存在新闻,请先删除新闻");
            }else{
                int count = newsClassifyMapper.deleteNewsClassifyByClassifyIds(classifyIds);
                if(count > 1){
                    jsonObjectList.add("分类主键ID："+classifyIds[i]+"  删除成功");
                }else{
                    jsonObjectList.add("分类主键ID："+classifyIds[i]+"删除失败");
                }

            }

        }

        return String.join(";",jsonObjectList);
    }

    /**
     * 删除新闻分类信息
     * 
     * @param classifyId 新闻分类主键
     * @return 结果
     */
    @Override
    public int deleteNewsClassifyByClassifyId(Long classifyId)
    {
        return newsClassifyMapper.deleteNewsClassifyByClassifyId(classifyId);
    }

    /**
     * 查询分类列表
     *
     * @param newsClassify 分类信息
     * @return 分类列表
     */
    @Override
    public List<NewsClassify> selectClassifyList(NewsClassify newsClassify) {
        return newsClassifyMapper.selectNewsClassifyList(newsClassify);
    }

    /**
     * 构建前端所需要下拉树结构
     *
     * @param newsClassify 分类列表
     * @return 下拉树结构列表
     */
    @Override
    public List<TreeSelect> buildClassifyTreeSelect(List<NewsClassify> newsClassify)
    {
        List<NewsClassify> menuTrees = buildClassifyTree(newsClassify);
        return menuTrees.stream().map(TreeSelect::new).collect(Collectors.toList());
    }


    /**
     * 构建前端所需要树结构
     *
     * @param newsClassify 分类列表
     * @return 树结构列表
     */
    @Override
    public List<NewsClassify> buildClassifyTree(List<NewsClassify> newsClassify)
    {
        List<NewsClassify> returnList = new ArrayList<NewsClassify>();
        for (Iterator<NewsClassify> iterator = newsClassify.iterator(); iterator.hasNext();)
        {
            NewsClassify classify = (NewsClassify) iterator.next();
            // 如果是顶级节点, 遍历该父节点的所有子节点
            returnList.add(classify);
        }
        if (returnList.isEmpty())
        {
            returnList = newsClassify;
        }
        return returnList;
    }

    /**
     * 根据新闻ID查询分类树信息
     *
     * @param newsId 角色ID
     * @return 选中分类列表
     */
    @Override
    public List<Integer> selectClassifyListByNewsId(Long newsId)
    {
        NewsAndClassify newsAndClassify = new NewsAndClassify();
        newsAndClassify.setNewId(newsId);
        List<Integer> classifyList = new ArrayList<>();
        for (NewsAndClassify andClassify : newsAndClassifyMapper.selectNewsAndClassifyList(newsAndClassify)) {
            classifyList.add(Math.toIntExact(andClassify.getClassifyId()));
        }

        return classifyList;
    }


}
