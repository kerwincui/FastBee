package com.ruoyi.iot.domain;

/**
 * @author sunalong
 */
public class AreaCityGeo {
    private String id;

    private String pid;

    private String deep;

    private String name;

    private String extPath;

    private Object geo;

    private Object polygon;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getDeep() {
        return deep;
    }

    public void setDeep(String deep) {
        this.deep = deep;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getExtPath() {
        return extPath;
    }

    public void setExtPath(String extPath) {
        this.extPath = extPath;
    }

    public Object getGeo() {
        return geo;
    }

    public void setGeo(Object geo) {
        this.geo = geo;
    }

    public Object getPolygon() {
        return polygon;
    }

    public void setPolygon(Object polygon) {
        this.polygon = polygon;
    }
}