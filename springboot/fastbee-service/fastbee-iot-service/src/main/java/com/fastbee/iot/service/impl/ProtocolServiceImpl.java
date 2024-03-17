package com.fastbee.iot.service.impl;

import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.Protocol;
import com.fastbee.iot.mapper.ProtocolMapper;
import com.fastbee.iot.service.IProtocolService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 协议管理
 * @author gsb
 * @date 2022/10/19 17:02
 */
@Service
public class ProtocolServiceImpl implements IProtocolService {

    @Autowired
    private ProtocolMapper protocolMapper;

    /**
     * 查询协议
     *
     * @param id 协议主键
     * @return 协议
     */
    @Override
    public Protocol selectProtocolById(Long id)
    {
        return protocolMapper.selectProtocolById(id);
    }

    /**
     * 查询协议列表
     *
     * @param protocol 协议
     * @return 协议
     */
    @Override
    public List<Protocol> selectProtocolList(Protocol protocol)
    {
        return protocolMapper.selectProtocolList(protocol);
    }

    /**
     * 新增协议
     *
     * @param protocol 协议
     * @return 结果
     */
    @Override
    public int insertProtocol(Protocol protocol)
    {
        protocol.setCreateTime(DateUtils.getNowDate());
        if (protocol.getProtocolStatus() == null){
            protocol.setProtocolStatus(1);
        }
        return protocolMapper.insertProtocol(protocol);
    }

    /**
     * 修改协议
     *
     * @param protocol 协议
     * @return 结果
     */
    @Override
    public int updateProtocol(Protocol protocol)
    {
        protocol.setUpdateTime(DateUtils.getNowDate());
        return protocolMapper.updateProtocol(protocol);
    }

    /**
     * 批量删除协议
     *
     * @param ids 需要删除的协议主键
     * @return 结果
     */
    @Override
    public int deleteProtocolByIds(Long[] ids)
    {
        return protocolMapper.deleteProtocolByIds(ids);
    }

    /**
     * 删除协议信息
     *
     * @param id 协议主键
     * @return 结果
     */
    @Override
    public int deleteProtocolById(Long id)
    {
        return protocolMapper.deleteProtocolById(id);
    }

    /**
     * 获取所有协议
     * @return
     */
    @Override
    public List<Protocol> selectAll(){
        return protocolMapper.selectAll(1,0);
    }

    /**
     *获取所有可用协议
     * @param protocol
     * @return
     */
    @Override
    public List<Protocol> selectByCondition(Protocol protocol){
        return protocolMapper.selectByUnion(protocol);
    }
}
