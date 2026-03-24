package com.fastbee.system.service;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.fastbee.system.domain.AppPreferences;
import com.fastbee.system.domain.vo.AppPreferencesVO;

import java.util.List;

/**
 * APP用户偏好设置Service接口
 */
public interface IAppPreferencesService extends IService<AppPreferences>
{

    /**
     * 查询APP用户偏好设置列表
     *
     * @param appPreferences APP用户偏好设置
     * @return APP用户偏好设置分页集合
     */
    Page<AppPreferencesVO> pageAppPreferencesVO(AppPreferences appPreferences);

    /**
     * 查询APP用户偏好设置
     *
     * @param userId APP用户偏好设置主键
     * @return APP用户偏好设置
     */
    public AppPreferences selectAppPreferencesByUserId(Long userId);

    /**
     * 查询APP用户偏好设置列表
     *
     * @param appPreferences APP用户偏好设置
     * @return APP用户偏好设置集合
     */
    List<AppPreferencesVO> listAppPreferencesVO(AppPreferences appPreferences);

    /**
     * 新增APP用户偏好设置
     *
     * @param appPreferences APP用户偏好设置
     * @return 结果
     */
    public int insertAppPreferences(AppPreferences appPreferences);

    /**
     * 修改APP用户偏好设置
     *
     * @param appPreferences APP用户偏好设置
     * @return 结果
     */
    public int updateAppPreferences(AppPreferences appPreferences);

    /**
     * 批量删除APP用户偏好设置
     *
     * @param userIds 需要删除的APP用户偏好设置主键集合
     * @return 结果
     */
    public int deleteAppPreferencesByUserIds(Long[] userIds);

    /**
     * 删除APP用户偏好设置信息
     *
     * @param userId APP用户偏好设置主键
     * @return 结果
     */
    public int deleteAppPreferencesByUserId(Long userId);

    /**
     * 新增或者更新用户偏好设置
     * @param appPreferences
     * @return
     */
    public int addOrUpdate(AppPreferences appPreferences);

    /**
     * 获取用户偏好语言
     * @param userId
     * @return
     */
    public String getLanguage(Long userId);
}
