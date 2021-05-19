package com.espressif.iot.esptouch;

import java.net.InetAddress;

public interface IEsptouchResult {

    /**
     * check whether the esptouch task is executed suc
     *
     * @return whether the esptouch task is executed suc
     */
    boolean isSuc();

    /**
     * get the device's bssid
     *
     * @return the device's bssid
     */
    String getBssid();

    /**
     * check whether the esptouch task is cancelled by user
     *
     * @return whether the esptouch task is cancelled by user
     */
    boolean isCancelled();

    /**
     * get the ip address of the device
     *
     * @return the ip device of the device
     */
    InetAddress getInetAddress();
}
