/*
 * Copyright (C) 2021 xuexiangjys(xuexiangjys@163.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package com.kerwin.wumei.utils;

/**
 * SharedPreferences管理工具基类
 *
 * @author xuexiang
 * @since 2018/11/27 下午5:16
 */
public final class SettingUtils {

    private SettingUtils() {
        throw new UnsupportedOperationException("u can't instantiate me...");
    }

    private static final String IS_FIRST_OPEN_KEY = "is_first_open_key";
    private static final String IS_AGREE_PRIVACY_KEY = "is_agree_privacy_key";
    private static final String USER_NAME = "user_name";
    private static final String PASSWORD = "password";
    private static final String SERVERADDRESS = "serve_address";
    private static final String SERVERPATH = "serve_path";
    private static final String APIP = "ap_ip";
    private static final String WIFIPASSWORD = "wifi_password";

    /**
     * 是否是第一次启动
     */
    public static boolean isFirstOpen() {
        return MMKVUtils.getBoolean(IS_FIRST_OPEN_KEY, true);
    }

    /**
     * 设置是否是第一次启动
     */
    public static void setIsFirstOpen(boolean isFirstOpen) {
        MMKVUtils.put(IS_FIRST_OPEN_KEY, isFirstOpen);
    }

    /**
     * 设置用户名和密码
     */
    public static void setAccount(String userName, String password) {
        MMKVUtils.put(USER_NAME, userName);
        MMKVUtils.put(PASSWORD, password);
    }

    /**
     * 设置服务端地址
     */
    public static void setServeAddress(String serveAddress) {
        MMKVUtils.put(SERVERADDRESS, serveAddress);
    }

    /**
     * 获取服务端地址
     *
     * @return
     */
    public static String getServerAddress() {
        return MMKVUtils.getString(SERVERADDRESS, "http://wumei.live:88/");
    }

    /**
     * 设置服务端路径
     */
    public static void setServePath(String servePath) {
        MMKVUtils.put(SERVERPATH, servePath);
    }

    /**
     * 获取服务路径
     *
     * @return
     */
    public static String getServerPath() {
        return MMKVUtils.getString(SERVERPATH, "prod-api");
    }



    /**
     * 设置设备AP地址
     *
     * @return
     */
    public static void setApIp(String apIp) {
        MMKVUtils.put(APIP, apIp);
    }

    /**
     * 获取设备AP地址
     *
     * @return
     */
    public static String getApIp() {
        return MMKVUtils.getString(APIP, "192.168.4.1");
    }

    /**
     * 设置wifi密码
     *
     * @return
     */
    public static void setWifiPassword(String wifiPassword) {
        MMKVUtils.put(WIFIPASSWORD, wifiPassword);
    }

    /**
     * 获取wifi密码
     *
     * @return
     */
    public static String getWifiPassword() {
        return MMKVUtils.getString(WIFIPASSWORD, "");
    }


    /**
     * 获取登录用户名
     *
     * @return
     */
    public static String getUserName() {
        return MMKVUtils.getString(USER_NAME, "");
    }

    /**
     * 获取登录密码
     *
     * @return
     */
    public static String getPassword() {
        return MMKVUtils.getString(PASSWORD, "");
    }

    /**
     * 清空登录密码
     */
    public static void clearPassword() {
        MMKVUtils.put(PASSWORD, "");
    }

    /**
     * @return 是否同意隐私政策
     */
    public static boolean isAgreePrivacy() {
        return MMKVUtils.getBoolean(IS_AGREE_PRIVACY_KEY, false);
    }

    public static void setIsAgreePrivacy(boolean isAgreePrivacy) {
        MMKVUtils.put(IS_AGREE_PRIVACY_KEY, isAgreePrivacy);
    }

}
