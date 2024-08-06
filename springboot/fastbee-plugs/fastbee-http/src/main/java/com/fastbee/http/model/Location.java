package com.fastbee.http.model;

import java.util.List;

/**
 * Created by Administrator on 2016/6/20.
 */
public class Location {

    private String timestamp;

    private Boolean result;

    private String message;

    private String version;

    private String desc;

    private String pos;

    private String districtadcode;

    private String district;

    private String adcode;

    private String areacode;

    private String city;

    private String cityadcode;

    private String tel;

    private Integer code;

    private String province;

    private String provinceadcode;

    private String country;

    private List cross_list;

    private List road_list;

    private List poi_list;

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public Boolean getResult() {
        return result;
    }

    public void setResult(Boolean result) {
        this.result = result;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getPos() {
        return pos;
    }

    public void setPos(String pos) {
        this.pos = pos;
    }

    public String getDistrictadcode() {
        return districtadcode;
    }

    public void setDistrictadcode(String districtadcode) {
        this.districtadcode = districtadcode;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getTel() {
        return tel;
    }

    public String getAdcode() {
        return adcode;
    }

    public void setAdcode(String adcode) {
        this.adcode = adcode;
    }

    public String getAreacode() {
        return areacode;
    }

    public void setAreacode(String areacode) {
        this.areacode = areacode;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getCityadcode() {
        return cityadcode;
    }

    public void setCityadcode(String cityadcode) {
        this.cityadcode = cityadcode;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getProvinceadcode() {
        return provinceadcode;
    }

    public void setProvinceadcode(String provinceadcode) {
        this.provinceadcode = provinceadcode;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public List getCross_list() {
        return cross_list;
    }

    public void setCross_list(List cross_list) {
        this.cross_list = cross_list;
    }

    public List getRoad_list() {
        return road_list;
    }

    public void setRoad_list(List road_list) {
        this.road_list = road_list;
    }

    public List getPoi_list() {
        return poi_list;
    }

    public void setPoi_list(List poi_list) {
        this.poi_list = poi_list;
    }
}
