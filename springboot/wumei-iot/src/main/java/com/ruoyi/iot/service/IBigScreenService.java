package com.ruoyi.iot.service;


import com.ruoyi.iot.model.bigscreen.vo.BigScreenMapReqVo;
import com.ruoyi.iot.model.bigscreen.vo.BigScreenMapRespVo;

/**
 * @author sunalong
 */
public interface IBigScreenService {
    /***
     * 大屏
     * @param reqVo 请求
     * @return BigScreenRespVo
     */
    BigScreenMapRespVo map(BigScreenMapReqVo reqVo);
}
