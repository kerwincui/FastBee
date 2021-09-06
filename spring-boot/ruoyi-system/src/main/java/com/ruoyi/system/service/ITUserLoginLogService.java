package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.TUserLoginLog;

/**
 * 【请填写功能名称】Service接口
 *
 * @author wxy
 * @date 2021-08-26
 */
public interface ITUserLoginLogService {
    /**
     * 查询【请填写功能名称】
     *
     * @param id 【请填写功能名称】ID
     * @return 【请填写功能名称】
     */
    public TUserLoginLog selectTUserLoginLogById(Long id);

    /**
     * 查询【请填写功能名称】列表
     *
     * @param tUserLoginLog 【请填写功能名称】
     * @return 【请填写功能名称】集合
     */
    public List<TUserLoginLog> selectTUserLoginLogList(TUserLoginLog tUserLoginLog);

    /**
     * 新增【请填写功能名称】
     *
     * @param tUserLoginLog 【请填写功能名称】
     * @return 结果
     */
    public int insertTUserLoginLog(TUserLoginLog tUserLoginLog);

    /**
     * 修改【请填写功能名称】
     *
     * @param tUserLoginLog 【请填写功能名称】
     * @return 结果
     */
    public int updateTUserLoginLog(TUserLoginLog tUserLoginLog);

    /**
     * 批量删除【请填写功能名称】
     *
     * @param ids 需要删除的【请填写功能名称】ID
     * @return 结果
     */
    public int deleteTUserLoginLogByIds(Long[] ids);

    /**
     * 删除【请填写功能名称】信息
     *
     * @param id 【请填写功能名称】ID
     * @return 结果
     */
    public int deleteTUserLoginLogById(Long id);
}
