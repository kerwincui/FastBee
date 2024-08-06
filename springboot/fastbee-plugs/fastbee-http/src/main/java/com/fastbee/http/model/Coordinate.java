package com.fastbee.http.model;

/**
 * @author gongjun
 * @since  2016-06-01
 */
public class Coordinate {

    private String longitude;

    private String latitude;

    public Coordinate(String longitude, String latitude) {
        this.longitude = longitude;
        this.latitude = latitude;
    }


    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }
}
