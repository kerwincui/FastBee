package com.fastbee.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.system.convert.AppLanguageConvert;
import com.fastbee.system.domain.AppLanguage;
import com.fastbee.system.domain.vo.AppLanguageVO;
import com.fastbee.system.mapper.AppLanguageMapper;
import com.fastbee.system.service.IAppLanguageService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.Map;
import java.util.Objects;

/**
 * app语言Service业务层处理
 */
@Service
public class AppLanguageServiceImpl extends ServiceImpl<AppLanguageMapper,AppLanguage> implements IAppLanguageService
{
    @Resource
    private AppLanguageMapper appLanguageMapper;

    /**
     * 查询app语言
     *
     * @param id app语言主键
     * @return app语言
     */
    @Override
    public AppLanguage selectAppLanguageById(Long id)
    {
        return appLanguageMapper.selectById(id);
    }

    /**
     * 查询app语言分页列表
     *
     * @param appLanguage app语言
     * @return app语言
     */
    @Override
    public Page<AppLanguageVO> pageAppLanguageVO(AppLanguage appLanguage) {
        LambdaQueryWrapper<AppLanguage> lqw = buildQueryWrapper(appLanguage);
        Page<AppLanguage> appLanguagePage = baseMapper.selectPage(new Page<>(appLanguage.getPageNum(), appLanguage.getPageSize()), lqw);
        return AppLanguageConvert.INSTANCE.convertAppLanguageVOPage(appLanguagePage);
    }

    private LambdaQueryWrapper<AppLanguage> buildQueryWrapper(AppLanguage query) {
        Map<String, Object> params = query.getParams();
        LambdaQueryWrapper<AppLanguage> lqw = Wrappers.lambdaQuery();
        lqw.eq(StringUtils.isNotBlank(query.getLanguage()), AppLanguage::getLanguage, query.getLanguage());
        lqw.eq(StringUtils.isNotBlank(query.getCountry()), AppLanguage::getCountry, query.getCountry());
        lqw.eq(StringUtils.isNotBlank(query.getTimeZone()), AppLanguage::getTimeZone, query.getTimeZone());
        lqw.like(StringUtils.isNotBlank(query.getLangName()), AppLanguage::getLangName, query.getLangName());

        if (!Objects.isNull(params.get("beginTime")) &&
                !Objects.isNull(params.get("endTime"))) {
            lqw.between(AppLanguage::getCreateTime, params.get("beginTime"), params.get("endTime"));
        }
        return lqw;
    }


    /**
     * 新增app语言
     *
     * @param appLanguage app语言
     * @return 结果
     */
    @Override
    public int insertAppLanguage(AppLanguage appLanguage)
    {
        return appLanguageMapper.insert(appLanguage);
    }

    /**
     * 修改app语言
     *
     * @param appLanguage app语言
     * @return 结果
     */
    @Override
    public int updateAppLanguage(AppLanguage appLanguage)
    {
        return appLanguageMapper.updateById(appLanguage);
    }

    /**
     * 批量删除app语言
     *
     * @param ids 需要删除的app语言主键
     * @return 结果
     */
    @Override
    public int deleteAppLanguageByIds(Long[] ids)
    {
        return appLanguageMapper.deleteBatchIds(Arrays.asList(ids));
    }

}
