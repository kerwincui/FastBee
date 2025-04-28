package com.fastbee.system.convert;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fastbee.system.domain.SysClient;
import com.fastbee.system.domain.vo.SysClientVO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 系统授权Convert转换类
 *
 * @author zhuangpeng.li
 * @date 2024-12-12
 */
@Mapper
public interface SysClientConvert
{
    /** 代码生成区域 可直接覆盖**/
    SysClientConvert INSTANCE = Mappers.getMapper(SysClientConvert.class);

    /**
     * 实体类转换为VO类
     *
     * @param sysClient
     * @return 系统授权集合
     */
    SysClientVO convertSysClientVO(SysClient sysClient);

    /**
     * VO类转换为实体类集合
     *
     * @param sysClientVO
     * @return 系统授权集合
     */
    SysClient convertSysClient(SysClientVO sysClientVO);

    /**
     * 实体类转换为VO类集合
     *
     * @param sysClientList
     * @return 系统授权集合
     */
    List<SysClientVO> convertSysClientVOList(List<SysClient> sysClientList);

    /**
     * VO类转换为实体类
     *
     * @param sysClientVOList
     * @return 系统授权集合
     */
    List<SysClient> convertSysClientList(List<SysClientVO> sysClientVOList);

    /**
     * 实体类转换为VO类分页
     *
     * @param sysClientPage
     * @return 系统授权分页
     */
    Page<SysClientVO> convertSysClientVOPage(Page<SysClient> sysClientPage);

    /**
     * VO类转换为实体类
     *
     * @param sysClientVOPage
     * @return 系统授权分页
     */
    Page<SysClient> convertSysClientPage(Page<SysClientVO> sysClientVOPage);
    /** 代码生成区域 可直接覆盖END**/

    /** 自定义代码区域 **/


    /** 自定义代码区域 END**/
}
