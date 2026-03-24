package com.fastbee.system.convert;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fastbee.system.domain.AppPreferences;
import com.fastbee.system.domain.vo.AppPreferencesVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * APP用户偏好设置Convert转换类
 *
 * @author fastbee
 * @date 2024-12-03
 */
@Mapper
public interface AppPreferencesConvert
{

    AppPreferencesConvert INSTANCE = Mappers.getMapper(AppPreferencesConvert.class);

    /**
     * 实体类转换为VO类
     *
     * @param appPreferences
     * @return APP用户偏好设置集合
     */
    AppPreferencesVO convertAppPreferencesVO(AppPreferences appPreferences);

    /**
     * VO类转换为实体类集合
     *
     * @param appPreferencesVO
     * @return APP用户偏好设置集合
     */
    AppPreferences convertAppPreferences(AppPreferencesVO appPreferencesVO);

    /**
     * 实体类转换为VO类集合
     *
     * @param appPreferencesList
     * @return APP用户偏好设置集合
     */
    List<AppPreferencesVO> convertAppPreferencesVOList(List<AppPreferences> appPreferencesList);

    /**
     * VO类转换为实体类
     *
     * @param appPreferencesVOList
     * @return APP用户偏好设置集合
     */
    List<AppPreferences> convertAppPreferencesList(List<AppPreferencesVO> appPreferencesVOList);

    /**
     * 实体类转换为VO类分页
     *
     * @param appPreferencesPage
     * @return APP用户偏好设置分页
     */
    Page<AppPreferencesVO> convertAppPreferencesVOPage(Page<AppPreferences> appPreferencesPage);

    /**
     * VO类转换为实体类
     *
     * @param appPreferencesVOPage
     * @return APP用户偏好设置分页
     */
    Page<AppPreferences> convertAppPreferencesPage(Page<AppPreferencesVO> appPreferencesVOPage);
}
