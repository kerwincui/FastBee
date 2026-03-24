package com.fastbee.system.service;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.fastbee.system.domain.AppLanguage;
import com.fastbee.system.domain.vo.AppLanguageVO;

/**
 * app语言Service接口
 */
public interface IAppLanguageService extends IService<AppLanguage>
{
    /**
     * 查询app语言
     *
     * @param id app语言主键
     * @return app语言
     */
    public AppLanguage selectAppLanguageById(Long id);

    /**
     * 查询app语言列表
     *
     * @param appLanguage app语言
     * @return app语言分页集合
     */
    Page<AppLanguageVO> pageAppLanguageVO(AppLanguage appLanguage);

    /**
     * 新增app语言
     *
     * @param appLanguage app语言
     * @return 结果
     */
    public int insertAppLanguage(AppLanguage appLanguage);

    /**
     * 修改app语言
     *
     * @param appLanguage app语言
     * @return 结果
     */
    public int updateAppLanguage(AppLanguage appLanguage);

    /**
     * 批量删除app语言
     *
     * @param ids 需要删除的app语言主键集合
     * @return 结果
     */
    public int deleteAppLanguageByIds(Long[] ids);

}
