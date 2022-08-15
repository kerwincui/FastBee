package com.ruoyi.iot.service.impl;


import com.ruoyi.iot.mapper.DeviceMapper;
import com.ruoyi.iot.model.bigscreen.dto.TotalDeviceArea;
import com.ruoyi.iot.model.bigscreen.vo.BigScreenMapReqVo;
import com.ruoyi.iot.model.bigscreen.vo.BigScreenMapRespVo;
import com.ruoyi.iot.service.IBigScreenService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author sunalong
 */
@Service
public class BigScreenServiceImpl implements IBigScreenService {
    private final DeviceMapper deviceMapper;

    public BigScreenServiceImpl(DeviceMapper deviceMapper) {
        this.deviceMapper = deviceMapper;
    }

    @Override
    public BigScreenMapRespVo map(BigScreenMapReqVo reqVo) {
        String province = reqVo.getProvince();

        List<TotalDeviceArea> list;
        if (StringUtils.isBlank(province)) {
            list = deviceMapper.groupDeviceProvince();
        }else {
            list = deviceMapper.groupDeviceCityByProvince(province);
        }
        BigScreenMapRespVo vo = new BigScreenMapRespVo();
        vo.setList(list);
        return vo;
    }
}
