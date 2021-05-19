package com.espressif.iot.esptouch.protocol;

import com.espressif.iot.esptouch.security.ITouchEncryptor;
import com.espressif.iot.esptouch.task.IEsptouchGenerator;
import com.espressif.iot.esptouch.util.ByteUtil;

import java.net.InetAddress;

public class EsptouchGenerator implements IEsptouchGenerator {

    private final byte[][] mGcBytes2;
    private final byte[][] mDcBytes2;

    /**
     * Constructor of EsptouchGenerator, it will cost some time(maybe a bit
     * much)
     *
     * @param apSsid      the Ap's ssid
     * @param apBssid     the Ap's bssid
     * @param apPassword  the Ap's password
     * @param inetAddress the phone's or pad's local ip address allocated by Ap
     */
    public EsptouchGenerator(byte[] apSsid, byte[] apBssid, byte[] apPassword, InetAddress inetAddress,
                             ITouchEncryptor encryptor) {
        // generate guide code
        GuideCode gc = new GuideCode();
        char[] gcU81 = gc.getU8s();
        mGcBytes2 = new byte[gcU81.length][];

        for (int i = 0; i < mGcBytes2.length; i++) {
            mGcBytes2[i] = ByteUtil.genSpecBytes(gcU81[i]);
        }

        // generate data code
        DatumCode dc = new DatumCode(apSsid, apBssid, apPassword, inetAddress, encryptor);
        char[] dcU81 = dc.getU8s();
        mDcBytes2 = new byte[dcU81.length][];

        for (int i = 0; i < mDcBytes2.length; i++) {
            mDcBytes2[i] = ByteUtil.genSpecBytes(dcU81[i]);
        }
    }

    @Override
    public byte[][] getGCBytes2() {
        return mGcBytes2;
    }

    @Override
    public byte[][] getDCBytes2() {
        return mDcBytes2;
    }

}
