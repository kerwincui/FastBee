package com.fastbee.http.utils;

public class Constants {
    //登录方式：ie/cs/wx/android/iphone/ipad/interface
    public static final String loginWay = "interface";
    //登录语言：默认简体中文
    public static final String loginLang = "zh_CN";
    //车辆ID：演示06
    public static final String carId="105237";

    private static final String HTTP="http://";
    private static final String SEMICOLON=":";
    private static final String CLASH="/";
    private Constants() {
        throw new IllegalStateException("can not init from this way");
    }
}
