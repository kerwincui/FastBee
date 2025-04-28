package com.fastbee.system.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.fastbee.system.domain.SysClient;
import com.fastbee.system.domain.vo.SysClientVO;

import java.util.List;

/**
 * 系统授权Service接口
 *
 * @author zhuangpeng.li
 * @date 2024-07-26
 */
public interface ISysClientService extends IService<SysClient>
{
    /**
     * 查询系统授权
     *
     * @param id 系统授权主键
     * @return 系统授权
     */
    public SysClient selectSysClientById(Long id);

    /**
     * 查询系统授权列表
     *
     * @param sysClient 系统授权
     * @return 系统授权集合
     */
    public List<SysClientVO> selectSysClientList(SysClient sysClient);

    /**
     * 查询系统授权列表
     *
     * @param sysClient 系统授权
     * @return 系统授权分页集合
     */
    Page<SysClientVO> pageSysClientVO(SysClient sysClient);

    /**
     * 新增系统授权
     *
     * @param sysClient 系统授权
     * @return 结果
     */
    public int insertSysClient(SysClient sysClient);

    /**
     * 修改系统授权
     *
     * @param sysClient 系统授权
     * @return 结果
     */
    public int updateSysClient(SysClient sysClient);

    /**
     * 批量删除系统授权
     *
     * @param ids 需要删除的系统授权主键集合
     * @return 结果
     */
    public int deleteSysClientByIds(Long[] ids);

    /**
     * 删除系统授权信息
     *
     * @param id 系统授权主键
     * @return 结果
     */
    public int deleteSysClientById(Long id);
}
