package com.espressif.iot.esptouch.util;

import android.content.Context;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.InetAddress;
import java.net.UnknownHostException;

public class TouchNetUtil {

    /**
     * get the local ip address by Android System
     *
     * @param context the context
     * @return the local ip addr allocated by Ap
     */
    public static InetAddress getLocalInetAddress(Context context) {
        WifiManager wm = (WifiManager) context.getApplicationContext()
                .getSystemService(Context.WIFI_SERVICE);
        assert wm != null;
        WifiInfo wifiInfo = wm.getConnectionInfo();
        int localAddrInt = wifiInfo.getIpAddress();
        String localAddrStr = __formatString(localAddrInt);
        InetAddress localInetAddr = null;
        try {
            localInetAddr = InetAddress.getByName(localAddrStr);
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        return localInetAddr;
    }

    private static String __formatString(int value) {
        StringBuilder strValue = new StringBuilder();
        byte[] ary = __intToByteArray(value);
        for (int i = ary.length - 1; i >= 0; i--) {
            strValue.append(ary[i] & 0xFF);
            if (i > 0) {
                strValue.append(".");
            }
        }
        return strValue.toString();
    }

    private static byte[] __intToByteArray(int value) {
        byte[] b = new byte[4];
        for (int i = 0; i < 4; i++) {
            int offset = (b.length - 1 - i) * 8;
            b[i] = (byte) ((value >>> offset) & 0xFF);
        }
        return b;
    }

    /**
     * parse InetAddress
     *
     * @param inetAddrBytes
     * @return
     */
    public static InetAddress parseInetAddr(byte[] inetAddrBytes, int offset,
                                            int count) {
        InetAddress inetAddress = null;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < count; i++) {
            sb.append((inetAddrBytes[offset + i] & 0xff));
            if (i != count - 1) {
                sb.append('.');
            }
        }
        try {
            inetAddress = InetAddress.getByName(sb.toString());
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        return inetAddress;
    }

    /**
     * parse bssid
     *
     * @param bssid the bssid like aa:bb:cc:dd:ee:ff
     * @return byte converted from bssid
     */
    public static byte[] parseBssid2bytes(String bssid) {
        String[] bssidSplits = bssid.split(":");
        byte[] result = new byte[bssidSplits.length];
        for (int i = 0; i < bssidSplits.length; i++) {
            result[i] = (byte) Integer.parseInt(bssidSplits[i], 16);
        }
        return result;
    }

    public static byte[] getOriginalSsidBytes(WifiInfo info) {
        try {
            Method method = info.getClass().getMethod("getWifiSsid");
            method.setAccessible(true);
            Object wifiSsid = method.invoke(info);
            if (wifiSsid == null) {
                return null;
            }
            method = wifiSsid.getClass().getMethod("getOctets");
            method.setAccessible(true);
            return (byte[]) method.invoke(wifiSsid);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (NullPointerException e) {
            e.printStackTrace();
        }
        return null;
    }
}
