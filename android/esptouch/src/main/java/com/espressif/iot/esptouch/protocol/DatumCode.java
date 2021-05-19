package com.espressif.iot.esptouch.protocol;

import com.espressif.iot.esptouch.security.ITouchEncryptor;
import com.espressif.iot.esptouch.task.ICodeData;
import com.espressif.iot.esptouch.util.ByteUtil;
import com.espressif.iot.esptouch.util.CRC8;

import java.net.InetAddress;
import java.util.LinkedList;

public class DatumCode implements ICodeData {

    // define by the Esptouch protocol, all of the datum code should add 1 at last to prevent 0
    private static final int EXTRA_LEN = 40;
    private static final int EXTRA_HEAD_LEN = 5;

    private final LinkedList<DataCode> mDataCodes;

    /**
     * Constructor of DatumCode
     *
     * @param apSsid      the Ap's ssid
     * @param apBssid     the Ap's bssid
     * @param apPassword  the Ap's password
     * @param ipAddress   the ip address of the phone or pad
     * @param encryptor null use origin data, not null use encrypted data
     */
    public DatumCode(byte[] apSsid, byte[] apBssid, byte[] apPassword,
                     InetAddress ipAddress, ITouchEncryptor encryptor) {
        // Data = total len(1 byte) + apPwd len(1 byte) + SSID CRC(1 byte) +
        // BSSID CRC(1 byte) + TOTAL XOR(1 byte)+ ipAddress(4 byte) + apPwd + apSsid apPwdLen <=
        // 105 at the moment

        // total xor
        char totalXor = 0;

        char apPwdLen = (char) apPassword.length;
        CRC8 crc = new CRC8();
        crc.update(apSsid);
        char apSsidCrc = (char) crc.getValue();

        crc.reset();
        crc.update(apBssid);
        char apBssidCrc = (char) crc.getValue();

        char apSsidLen = (char) apSsid.length;

        byte[] ipBytes = ipAddress.getAddress();
        int ipLen = ipBytes.length;

        char totalLen = (char) (EXTRA_HEAD_LEN + ipLen + apPwdLen + apSsidLen);

        // build data codes
        mDataCodes = new LinkedList<>();
        mDataCodes.add(new DataCode(totalLen, 0));
        totalXor ^= totalLen;
        mDataCodes.add(new DataCode(apPwdLen, 1));
        totalXor ^= apPwdLen;
        mDataCodes.add(new DataCode(apSsidCrc, 2));
        totalXor ^= apSsidCrc;
        mDataCodes.add(new DataCode(apBssidCrc, 3));
        totalXor ^= apBssidCrc;
        // ESPDataCode 4 is null
        for (int i = 0; i < ipLen; ++i) {
            char c = ByteUtil.convertByte2Uint8(ipBytes[i]);
            totalXor ^= c;
            mDataCodes.add(new DataCode(c, i + EXTRA_HEAD_LEN));
        }

        for (int i = 0; i < apPassword.length; i++) {
            char c = ByteUtil.convertByte2Uint8(apPassword[i]);
            totalXor ^= c;
            mDataCodes.add(new DataCode(c, i + EXTRA_HEAD_LEN + ipLen));
        }

        // totalXor will xor apSsidChars no matter whether the ssid is hidden
        for (int i = 0; i < apSsid.length; i++) {
            char c = ByteUtil.convertByte2Uint8(apSsid[i]);
            totalXor ^= c;
            mDataCodes.add(new DataCode(c, i + EXTRA_HEAD_LEN + ipLen + apPwdLen));
        }

        // add total xor last
        mDataCodes.add(4, new DataCode(totalXor, 4));

        // add bssid
        int bssidInsertIndex = EXTRA_HEAD_LEN;
        for (int i = 0; i < apBssid.length; i++) {
            int index = totalLen + i;
            char c = ByteUtil.convertByte2Uint8(apBssid[i]);
            DataCode dc = new DataCode(c, index);
            if (bssidInsertIndex >= mDataCodes.size()) {
                mDataCodes.add(dc);
            } else {
                mDataCodes.add(bssidInsertIndex, dc);
            }
            bssidInsertIndex += 4;
        }
    }

    @Override
    public byte[] getBytes() {
        byte[] datumCode = new byte[mDataCodes.size() * DataCode.DATA_CODE_LEN];
        int index = 0;
        for (DataCode dc : mDataCodes) {
            for (byte b : dc.getBytes()) {
                datumCode[index++] = b;
            }
        }
        return datumCode;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        byte[] dataBytes = getBytes();
        for (byte dataByte : dataBytes) {
            String hexString = ByteUtil.convertByte2HexString(dataByte);
            sb.append("0x");
            if (hexString.length() == 1) {
                sb.append("0");
            }
            sb.append(hexString).append(" ");
        }
        return sb.toString();
    }

    @Override
    public char[] getU8s() {
        byte[] dataBytes = getBytes();
        int len = dataBytes.length / 2;
        char[] dataU8s = new char[len];
        byte high, low;
        for (int i = 0; i < len; i++) {
            high = dataBytes[i * 2];
            low = dataBytes[i * 2 + 1];
            dataU8s[i] = (char) (ByteUtil.combine2bytesToU16(high, low) + EXTRA_LEN);
        }
        return dataU8s;
    }
}
