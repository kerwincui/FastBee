package com.ruoyi.system.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.TUserAccountInfoMapper;
import com.ruoyi.system.domain.TUserAccountInfo;
import com.ruoyi.system.service.ITUserAccountInfoService;

/**
 * 小程序用户Service业务层处理
 *
 * @author wxy
 * @date 2021-08-26
 */
@Service
public class TUserAccountInfoServiceImpl implements ITUserAccountInfoService {
    @Autowired
    private TUserAccountInfoMapper tUserAccountInfoMapper;

    /**
     * 查询小程序用户
     *
     * @param id 小程序用户ID
     * @return 小程序用户
     */
    @Override
    public TUserAccountInfo selectTUserAccountInfoById(Long id) {
        return tUserAccountInfoMapper.selectTUserAccountInfoById(id);
    }

    /**
     * 查询小程序用户列表
     *
     * @param tUserAccountInfo 小程序用户
     * @return 小程序用户
     */
    @Override
    public List<TUserAccountInfo> selectTUserAccountInfoList(TUserAccountInfo tUserAccountInfo) {
        return tUserAccountInfoMapper.selectTUserAccountInfoList(tUserAccountInfo);
    }

    /**
     * 新增小程序用户
     *
     * @param tUserAccountInfo 小程序用户
     * @return 结果
     */
    @Override
    public int insertTUserAccountInfo(TUserAccountInfo tUserAccountInfo) {
        return tUserAccountInfoMapper.insertTUserAccountInfo(tUserAccountInfo);
    }

    /**
     * 修改小程序用户
     *
     * @param tUserAccountInfo 小程序用户
     * @return 结果
     */
    @Override
    public int updateTUserAccountInfo(TUserAccountInfo tUserAccountInfo) {
        return tUserAccountInfoMapper.updateTUserAccountInfo(tUserAccountInfo);
    }

    /**
     * 批量删除小程序用户
     *
     * @param ids 需要删除的小程序用户ID
     * @return 结果
     */
    @Override
    public int deleteTUserAccountInfoByIds(Long[] ids) {
        return tUserAccountInfoMapper.deleteTUserAccountInfoByIds(ids);
    }

    /**
     * 删除小程序用户信息
     *
     * @param id 小程序用户ID
     * @return 结果
     */
    @Override
    public int deleteTUserAccountInfoById(Long id) {
        return tUserAccountInfoMapper.deleteTUserAccountInfoById(id);
    }
}
