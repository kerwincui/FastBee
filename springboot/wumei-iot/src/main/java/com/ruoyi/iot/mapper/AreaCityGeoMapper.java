package com.ruoyi.iot.mapper;

import com.ruoyi.iot.domain.AreaCityGeo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author sunalong
 */
@Repository
public interface AreaCityGeoMapper {
    /***
     * 根据坐标查询
     * @param point 坐标
     * @return 省市县
     */
    List<AreaCityGeo> selectAreaCityGeoByPoint(@Param("point")String point);
}