package com.espressif.iot.esptouch;

import java.net.InetAddress;
import java.util.concurrent.atomic.AtomicBoolean;

public class EsptouchResult implements IEsptouchResult {

    private final boolean mIsSuc;
    private final String mBssid;
    private final InetAddress mInetAddress;
    private AtomicBoolean mIsCancelled;

    /**
     * Constructor of EsptouchResult
     *
     * @param isSuc       whether the esptouch task is executed suc
     * @param bssid       the device's bssid
     * @param inetAddress the device's ip address
     */
    public EsptouchResult(boolean isSuc, String bssid, InetAddress inetAddress) {
        this.mIsSuc = isSuc;
        this.mBssid = bssid;
        this.mInetAddress = inetAddress;
        this.mIsCancelled = new AtomicBoolean(false);
    }

    @Override
    public boolean isSuc() {
        return this.mIsSuc;
    }

    @Override
    public String getBssid() {
        return this.mBssid;
    }

    @Override
    public boolean isCancelled() {
        return mIsCancelled.get();
    }

    public void setIsCancelled(boolean isCancelled) {
        this.mIsCancelled.set(isCancelled);
    }

    @Override
    public InetAddress getInetAddress() {
        return this.mInetAddress;
    }

    @Override
    public String toString() {
        return String.format("bssid=%s, address=%s, suc=%b, cancel=%b", mBssid,
                mInetAddress == null ? null : mInetAddress.getHostAddress(), mIsSuc, mIsCancelled.get());
    }
}
