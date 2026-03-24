package com.fastbee.system.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fastbee.common.enums.Language;
import com.fastbee.common.utils.SecurityUtils;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.system.convert.AppPreferencesConvert;
import com.fastbee.system.domain.AppPreferences;
import com.fastbee.system.domain.vo.AppPreferencesVO;
import com.fastbee.system.mapper.AppPreferencesMapper;
import com.fastbee.system.service.IAppPreferencesService;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;


/**
 * APP用户偏好设置Service业务层处理
 */
@Service
public class AppPreferencesServiceImpl extends ServiceImpl<AppPreferencesMapper,AppPreferences> implements IAppPreferencesService
{

    /**
     * 查询APP用户偏好设置分页列表
     *
     * @param appPreferences APP用户偏好设置
     * @return APP用户偏好设置
     */
    @Override
    public Page<AppPreferencesVO> pageAppPreferencesVO(AppPreferences appPreferences) {
        LambdaQueryWrapper<AppPreferences> lqw = buildQueryWrapper(appPreferences);
        Page<AppPreferences> appPreferencesPage = baseMapper.selectPage(new Page<>(appPreferences.getPageNum(), appPreferences.getPageSize()), lqw);
        return AppPreferencesConvert.INSTANCE.convertAppPreferencesVOPage(appPreferencesPage);
    }

    /**
     * 查询APP用户偏好设置
     *
     * @param userId APP用户偏好设置主键
     * @return APP用户偏好设置
     */
    @Override
    public AppPreferences selectAppPreferencesByUserId(Long userId)
    {
        LambdaQueryWrapper<AppPreferences> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AppPreferences::getUserId, userId);
        AppPreferences appPreferences = baseMapper.selectOne(queryWrapper);
        if (appPreferences == null){
            appPreferences = new AppPreferences();
        }
        // 设置默认语言
        if (StringUtils.isEmpty(appPreferences.getLanguage())) {
            appPreferences.setLanguage(Language.DEFAULT.getValue());
        }
        return appPreferences;
    }

    /**
     * 查询APP用户偏好设置列表
     *
     * @param appPreferences APP用户偏好设置
     * @return APP用户偏好设置
     */
    @Override
    public List<AppPreferencesVO> listAppPreferencesVO(AppPreferences appPreferences) {
        LambdaQueryWrapper<AppPreferences> lqw = buildQueryWrapper(appPreferences);
        List<AppPreferences> appPreferencesList = baseMapper.selectList(lqw);
        return AppPreferencesConvert.INSTANCE.convertAppPreferencesVOList(appPreferencesList);
    }


    /**
     * 新增APP用户偏好设置
     *
     * @param appPreferences APP用户偏好设置
     * @return 结果
     */
    @Override
    public int insertAppPreferences(AppPreferences appPreferences)
    {
        appPreferences.setCreateTime(DateUtils.getNowDate());
        return baseMapper.insert(appPreferences);
    }

    /**
     * 修改APP用户偏好设置
     *
     * @param appPreferences APP用户偏好设置
     * @return 结果
     */
    @Override
    public int updateAppPreferences(AppPreferences appPreferences)
    {
        appPreferences.setUpdateTime(DateUtils.getNowDate());
        return baseMapper.updateById(appPreferences);
    }

    /**
     * 批量删除APP用户偏好设置
     *
     * @param userIds 需要删除的APP用户偏好设置主键
     * @return 结果
     */
    @Override
    public int deleteAppPreferencesByUserIds(Long[] userIds)
    {
        LambdaUpdateWrapper<AppPreferences> query = new LambdaUpdateWrapper<>();
        query.in(AppPreferences::getUserId, Arrays.asList(userIds));
        return baseMapper.delete(query);
    }

    /**
     * 删除APP用户偏好设置信息
     *
     * @param userId APP用户偏好设置主键
     * @return 结果
     */
    @Override
    public int deleteAppPreferencesByUserId(Long userId)
    {
        LambdaUpdateWrapper<AppPreferences> query = new LambdaUpdateWrapper<>();
        query.eq(AppPreferences::getUserId, userId);
        return baseMapper.delete(query);
    }

    /**
     * 新增或者更新用户偏好设置
     * @param appPreferences
     * @return
     */
    @Override
    public int addOrUpdate(AppPreferences appPreferences)
    {
        if (Objects.isNull(appPreferences.getId())){
            appPreferences.setUserId(SecurityUtils.getUserId());
        }
        AppPreferences preferences = this.selectAppPreferencesByUserId(SecurityUtils.getUserId());
        if (!Objects.isNull(preferences)){
            return baseMapper.updateById(appPreferences);
        } else {
            return baseMapper.insert(appPreferences);
        }
    }

    /**
     * 获取用户偏好语言
     * @param userId
     * @return
     */
    @Override
    public String getLanguage(Long userId) {
        AppPreferences appPreferences = selectAppPreferencesByUserId(userId);
        return appPreferences.getLanguage();
    }

    private LambdaQueryWrapper<AppPreferences> buildQueryWrapper(AppPreferences query) {
        Map<String, Object> params = query.getParams();
        LambdaQueryWrapper<AppPreferences> lqw = Wrappers.lambdaQuery();
        lqw.eq(query.getUserId() != null, AppPreferences::getUserId, query.getUserId());
        lqw.eq(StringUtils.isNotBlank(query.getLanguage()), AppPreferences::getLanguage, query.getLanguage());
        lqw.eq(StringUtils.isNotBlank(query.getTimeZone()), AppPreferences::getTimeZone, query.getTimeZone());

        if (!Objects.isNull(params.get("beginTime")) &&
                !Objects.isNull(params.get("endTime"))) {
            lqw.between(AppPreferences::getCreateTime, params.get("beginTime"), params.get("endTime"));
        }
        return lqw;
    }

}
