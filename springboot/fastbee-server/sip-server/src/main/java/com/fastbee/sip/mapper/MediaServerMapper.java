package com.fastbee.sip.mapper;

import com.fastbee.sip.domain.MediaServer;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 流媒体服务器配置Mapper接口
 *
 * @author zhuangpeng.li
 * @date 2022-11-30
 */
@Repository
public interface MediaServerMapper
{
    public MediaServer selectMediaServerById(Long id);
    /**
     * 查询流媒体服务器配置
     *
     * @return 流媒体服务器配置
     */
    public List<MediaServer> selectMediaServer(MediaServer mediaServer);
    public List<MediaServer> selectMediaServerBytenantId(Long tenantId);
    /**
     * 查询流媒体服务器配置列表
     *
     * @param mediaServer 流媒体服务器配置
     * @return 流媒体服务器配置集合
     */
    public List<MediaServer> selectMediaServerList(MediaServer mediaServer);

    /**
     * 新增流媒体服务器配置
     *
     * @param mediaServer 流媒体服务器配置
     * @return 结果
     */
    public int insertMediaServer(MediaServer mediaServer);

    /**
     * 修改流媒体服务器配置
     *
     * @param mediaServer 流媒体服务器配置
     * @return 结果
     */
    public int updateMediaServer(MediaServer mediaServer);

    /**
     * 删除流媒体服务器配置
     *
     * @param id 流媒体服务器配置主键
     * @return 结果
     */
    public int deleteMediaServerById(Long id);

    /**
     * 批量删除流媒体服务器配置
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteMediaServerByIds(Long[] ids);
}
