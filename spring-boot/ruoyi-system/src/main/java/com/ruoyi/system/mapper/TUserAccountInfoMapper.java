package com.ruoyi.system.mapper;

import java.util.List;

import com.ruoyi.system.domain.TUserAccountInfo;
import org.springframework.stereotype.Repository;

/**
 * 小程序用户Mapper接口
 *
 * @author wxy
 * @date 2021-08-26
 */
@Repository
public interface TUserAccountInfoMapper {
    /**
     * 查询小程序用户
     *
     * @param id 小程序用户ID
     * @return 小程序用户
     */
    public TUserAccountInfo selectTUserAccountInfoById(Long id);

    /**
     * 查询小程序用户列表
     *
     * @param tUserAccountInfo 小程序用户
     * @return 小程序用户集合
     */
    public List<TUserAccountInfo> selectTUserAccountInfoList(TUserAccountInfo tUserAccountInfo);

    /**
     * 新增小程序用户
     *
     * @param tUserAccountInfo 小程序用户
     * @return 结果
     */
    public int insertTUserAccountInfo(TUserAccountInfo tUserAccountInfo);

    /**
     * 修改小程序用户
     *
     * @param tUserAccountInfo 小程序用户
     * @return 结果
     */
    public int updateTUserAccountInfo(TUserAccountInfo tUserAccountInfo);

    /**
     * 删除小程序用户
     *
     * @param id 小程序用户ID
     * @return 结果
     */
    public int deleteTUserAccountInfoById(Long id);

    /**
     * 批量删除小程序用户
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteTUserAccountInfoByIds(Long[] ids);
}
