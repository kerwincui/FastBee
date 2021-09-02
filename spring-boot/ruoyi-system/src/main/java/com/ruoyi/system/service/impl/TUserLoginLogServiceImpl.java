package com.ruoyi.system.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TUserLoginLogMapper;
import com.ruoyi.system.domain.TUserLoginLog;
import com.ruoyi.system.service.ITUserLoginLogService;

/**
 * 【请填写功能名称】Service业务层处理
 *
 * @author wxy
 * @date 2021-08-26
 */
@Service
public class TUserLoginLogServiceImpl implements ITUserLoginLogService {
    @Autowired
    private TUserLoginLogMapper tUserLoginLogMapper;

    /**
     * 查询【请填写功能名称】
     *
     * @param id 【请填写功能名称】ID
     * @return 【请填写功能名称】
     */
    @Override
    public TUserLoginLog selectTUserLoginLogById(Long id) {
        return tUserLoginLogMapper.selectTUserLoginLogById(id);
    }

    /**
     * 查询【请填写功能名称】列表
     *
     * @param tUserLoginLog 【请填写功能名称】
     * @return 【请填写功能名称】
     */
    @Override
    public List<TUserLoginLog> selectTUserLoginLogList(TUserLoginLog tUserLoginLog) {
        return tUserLoginLogMapper.selectTUserLoginLogList(tUserLoginLog);
    }

    /**
     * 新增【请填写功能名称】
     *
     * @param tUserLoginLog 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int insertTUserLoginLog(TUserLoginLog tUserLoginLog) {
        return tUserLoginLogMapper.insertTUserLoginLog(tUserLoginLog);
    }

    /**
     * 修改【请填写功能名称】
     *
     * @param tUserLoginLog 【请填写功能名称】
     * @return 结果
     */
    @Override
    public int updateTUserLoginLog(TUserLoginLog tUserLoginLog) {
        return tUserLoginLogMapper.updateTUserLoginLog(tUserLoginLog);
    }

    /**
     * 批量删除【请填写功能名称】
     *
     * @param ids 需要删除的【请填写功能名称】ID
     * @return 结果
     */
    @Override
    public int deleteTUserLoginLogByIds(Long[] ids) {
        return tUserLoginLogMapper.deleteTUserLoginLogByIds(ids);
    }

    /**
     * 删除【请填写功能名称】信息
     *
     * @param id 【请填写功能名称】ID
     * @return 结果
     */
    @Override
    public int deleteTUserLoginLogById(Long id) {
        return tUserLoginLogMapper.deleteTUserLoginLogById(id);
    }
}
