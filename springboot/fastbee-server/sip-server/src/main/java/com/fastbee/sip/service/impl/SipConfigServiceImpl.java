package com.fastbee.sip.service.impl;

import com.fastbee.common.constant.FastBeeConstant;
import com.fastbee.common.core.redis.RedisCache;
import com.fastbee.common.utils.DateUtils;
import com.fastbee.iot.domain.Device;
import com.fastbee.iot.mapper.DeviceMapper;
import com.fastbee.sip.conf.SysSipConfig;
import com.fastbee.sip.domain.SipConfig;
import com.fastbee.sip.mapper.SipConfigMapper;
import com.fastbee.sip.service.ISipConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * sip系统配置Service业务层处理
 *
 * @author zhuangpeng.li
 * @date 2022-11-30
 */
@Service
public class SipConfigServiceImpl implements ISipConfigService {
    @Autowired
    private SipConfigMapper sipConfigMapper;

    @Autowired
    private DeviceMapper deviceMapper;

    @Autowired
    private SysSipConfig sysSipConfig;

    @Autowired
    private RedisCache redisCache;

    @Override
    public void updateDefaultSipConfig(SipConfig sipConfig) {
        SysSipConfig defConfig = new SysSipConfig();
        defConfig.setEnabled(sipConfig.getEnabled()==1);
        defConfig.setIp(sipConfig.getIp());
        defConfig.setPort(sipConfig.getPort());
        defConfig.setDomain(sipConfig.getDomain());
        defConfig.setId(sipConfig.getServerSipid());
        defConfig.setPassword(sipConfig.getPassword());
        redisCache.setCacheObject(FastBeeConstant.REDIS.DEFAULT_SIP_CONFIG, defConfig);
    }

    @Override
    public SipConfig GetDefaultSipConfig() {
        Object temp = redisCache.getCacheObject(FastBeeConstant.REDIS.DEFAULT_SIP_CONFIG);
        SipConfig sipConfig = new SipConfig();
        if (temp == null) {
            sipConfig.setEnabled(sysSipConfig.isEnabled() ? 1 : 0);
            sipConfig.setIp(sysSipConfig.getIp());
            sipConfig.setPort(sysSipConfig.getPort());
            sipConfig.setDomain(sysSipConfig.getDomain());
            sipConfig.setServerSipid(sysSipConfig.getId());
            sipConfig.setPassword(sysSipConfig.getPassword());
            redisCache.setCacheObject(FastBeeConstant.REDIS.DEFAULT_SIP_CONFIG, temp);
        } else if (temp instanceof SipConfig){
            sipConfig = (SipConfig) temp;
            updateDefaultSipConfig((SipConfig) temp);
        } else if (temp instanceof SysSipConfig){
            SysSipConfig temp2 = (SysSipConfig) temp;
            sipConfig.setEnabled(temp2.isEnabled() ? 1 : 0);
            sipConfig.setIp(temp2.getIp());
            sipConfig.setPort(temp2.getPort());
            sipConfig.setDomain(temp2.getDomain());
            sipConfig.setServerSipid(temp2.getId());
            sipConfig.setPassword(temp2.getPassword());
        }
        return sipConfig;
    }

    /**
     * 查询产品下第一条sip系统配置
     *
     * @return sip系统配置
     */
    @Override
    public SipConfig selectSipConfigByProductId(Long productId) {
        return sipConfigMapper.selectSipConfigByProductId(productId);
    }


    @Override
    public SipConfig selectSipConfigBydeviceSipId(String deviceSipId) {
        Device device = deviceMapper.selectDeviceBySerialNumber(deviceSipId);
        if (device != null) {
            return sipConfigMapper.selectSipConfigByProductId(device.getProductId());
        } else {
            return this.GetDefaultSipConfig();
        }
    }

    /**
     * 新增sip系统配置
     *
     * @param sipConfig sip系统配置
     * @return 结果
     */
    @Override
    public int insertSipConfig(SipConfig sipConfig) {
        sipConfig.setCreateTime(DateUtils.getNowDate());
        if (sipConfig.getIsdefault() != null && sipConfig.getIsdefault() == 1) {
            sipConfigMapper.resetDefaultSipConfig();
            updateDefaultSipConfig(sipConfig);
        }
        return sipConfigMapper.insertSipConfig(sipConfig);
    }

    /**
     * 修改sip系统配置
     *
     * @param sipConfig sip系统配置
     * @return 结果
     */
    @Override
    public int updateSipConfig(SipConfig sipConfig) {
        sipConfig.setUpdateTime(DateUtils.getNowDate());
        if (sipConfig.getIsdefault() != null && sipConfig.getIsdefault() == 1) {
            sipConfigMapper.resetDefaultSipConfig();
            updateDefaultSipConfig(sipConfig);
        }
        return sipConfigMapper.updateSipConfig(sipConfig);
    }

    @Override
    public void syncSipConfig(SysSipConfig sipConfig) {
        List<SipConfig> list = sipConfigMapper.selectSipConfigList(new SipConfig());
        for (SipConfig config : list) {
            config.setIp(sipConfig.getIp());
            config.setPort(sipConfig.getPort());
            sipConfigMapper.updateSipConfig(config);
        }
        GetDefaultSipConfig();
    }

    /**
     * 批量删除sip系统配置
     *
     * @param ids 需要删除的sip系统配置主键
     * @return 结果
     */
    @Override
    public int deleteSipConfigByIds(Long[] ids) {
        return sipConfigMapper.deleteSipConfigByIds(ids);
    }

    @Override
    public int deleteSipConfigByProductIds(Long[] productIds) {
        return sipConfigMapper.deleteSipConfigByProductId(productIds);
    }
}
