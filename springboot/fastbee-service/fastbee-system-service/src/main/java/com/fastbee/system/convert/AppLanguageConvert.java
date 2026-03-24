package com.fastbee.system.convert;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fastbee.system.domain.AppLanguage;
import com.fastbee.system.domain.vo.AppLanguageVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * app语言Convert转换类
 *
 * @author zhuangpeng.li
 * @date 2024-11-25
 */
@Mapper
public interface AppLanguageConvert
{

    AppLanguageConvert INSTANCE = Mappers.getMapper(AppLanguageConvert.class);

    /**
     * 实体类转换为VO类
     *
     * @param appLanguage
     * @return app语言集合
     */
    AppLanguageVO convertAppLanguageVO(AppLanguage appLanguage);

    /**
     * VO类转换为实体类集合
     *
     * @param appLanguageVO
     * @return app语言集合
     */
    AppLanguage convertAppLanguage(AppLanguageVO appLanguageVO);

    /**
     * 实体类转换为VO类集合
     *
     * @param appLanguageList
     * @return app语言集合
     */
    List<AppLanguageVO> convertAppLanguageVOList(List<AppLanguage> appLanguageList);

    /**
     * VO类转换为实体类
     *
     * @param appLanguageVOList
     * @return app语言集合
     */
    List<AppLanguage> convertAppLanguageList(List<AppLanguageVO> appLanguageVOList);

    /**
     * 实体类转换为VO类分页
     *
     * @param appLanguagePage
     * @return app语言分页
     */
    Page<AppLanguageVO> convertAppLanguageVOPage(Page<AppLanguage> appLanguagePage);

    /**
     * VO类转换为实体类
     *
     * @param appLanguageVOPage
     * @return app语言分页
     */
    Page<AppLanguage> convertAppLanguagePage(Page<AppLanguageVO> appLanguageVOPage);
}
