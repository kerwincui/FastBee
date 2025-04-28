package com.fastbee.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.common.utils.StringUtils;
import com.fastbee.system.convert.SysClientConvert;
import com.fastbee.system.domain.SysClient;
import com.fastbee.system.domain.vo.SysClientVO;
import com.fastbee.system.mapper.SysClientMapper;
import com.fastbee.system.service.ISysClientService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 系统授权Service业务层处理
 *
 * @author zhuangpeng.li
 * @date 2024-07-26
 */
@Service
public class SysClientServiceImpl extends ServiceImpl<SysClientMapper,SysClient> implements ISysClientService
{
    @Resource
    private SysClientMapper sysClientMapper;

    /**
     * 查询系统授权
     *
     * @param id 系统授权主键
     * @return 系统授权
     */
    @Override
    public SysClient selectSysClientById(Long id)
    {
        return sysClientMapper.selectById(id);
    }

    /**
     * 查询系统授权列表
     *
     * @param sysClient 系统授权
     * @return 系统授权
     */
    @Override
    public List<SysClientVO> selectSysClientList(SysClient sysClient)
    {
        LambdaQueryWrapper<SysClient> lqw = buildQueryWrapper(sysClient);
        List<SysClient> sysClientList = baseMapper.selectList(lqw);
        return SysClientConvert.INSTANCE.convertSysClientVOList(sysClientList);
    }

    /**
     * 查询系统授权分页列表
     *
     * @param sysClient 系统授权
     * @return 系统授权
     */
    @Override
    public Page<SysClientVO> pageSysClientVO(SysClient sysClient) {
        LambdaQueryWrapper<SysClient> lqw = buildQueryWrapper(sysClient);
        Page<SysClient> sysClientPage = baseMapper.selectPage(new Page<>(sysClient.getPageNum(), sysClient.getPageSize()), lqw);
        return SysClientConvert.INSTANCE.convertSysClientVOPage(sysClientPage);
    }

    private LambdaQueryWrapper<SysClient> buildQueryWrapper(SysClient query) {
        Map<String, Object> params = query.getParams();
        LambdaQueryWrapper<SysClient> lqw = Wrappers.lambdaQuery();
        lqw.eq(query.getId() != null, SysClient::getId, query.getId());
        lqw.eq(StringUtils.isNotBlank(query.getClientKey()), SysClient::getClientKey, query.getClientKey());
        lqw.eq(StringUtils.isNotBlank(query.getClientSecret()), SysClient::getClientSecret, query.getClientSecret());
        lqw.eq(StringUtils.isNotBlank(query.getToken()), SysClient::getToken, query.getToken());
        lqw.eq(StringUtils.isNotBlank(query.getGrantType()), SysClient::getGrantType, query.getGrantType());
        lqw.eq(StringUtils.isNotBlank(query.getDeviceType()), SysClient::getDeviceType, query.getDeviceType());
        lqw.eq(query.getTimeout() != null, SysClient::getTimeout, query.getTimeout());
        lqw.eq(StringUtils.isNotBlank(query.getEnable()), SysClient::getEnable, query.getEnable());
        lqw.eq(StringUtils.isNotBlank(query.getDelFlag()), SysClient::getDelFlag, query.getDelFlag());
        lqw.eq(StringUtils.isNotBlank(query.getCreateBy()), SysClient::getCreateBy, query.getCreateBy());
        lqw.eq(query.getCreateTime() != null, SysClient::getCreateTime, query.getCreateTime());
        lqw.eq(StringUtils.isNotBlank(query.getUpdateBy()), SysClient::getUpdateBy, query.getUpdateBy());
        lqw.eq(query.getUpdateTime() != null, SysClient::getUpdateTime, query.getUpdateTime());
        lqw.eq(StringUtils.isNotBlank(query.getRemark()), SysClient::getRemark, query.getRemark());

        if (!Objects.isNull(params.get("beginTime")) &&
                !Objects.isNull(params.get("endTime"))) {
            lqw.between(SysClient::getCreateTime, params.get("beginTime"), params.get("endTime"));
        }
        return lqw;
    }

    /**
     * 新增系统授权
     *
     * @param sysClient 系统授权
     * @return 结果
     */
    @Override
    public int insertSysClient(SysClient sysClient)
    {
        sysClient.setCreateTime(DateUtils.getNowDate());
        return sysClientMapper.insert(sysClient);
    }

    /**
     * 修改系统授权
     *
     * @param sysClient 系统授权
     * @return 结果
     */
    @Override
    public int updateSysClient(SysClient sysClient)
    {
        sysClient.setUpdateTime(DateUtils.getNowDate());
        return sysClientMapper.updateById(sysClient);
    }

    /**
     * 批量删除系统授权
     *
     * @param ids 需要删除的系统授权主键
     * @return 结果
     */
    @Override
    public int deleteSysClientByIds(Long[] ids)
    {
        return sysClientMapper.deleteBatchIds(Arrays.asList(ids));
    }

    /**
     * 删除系统授权信息
     *
     * @param id 系统授权主键
     * @return 结果
     */
    @Override
    public int deleteSysClientById(Long id)
    {
        return sysClientMapper.deleteById(id);
    }
}
