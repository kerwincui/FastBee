package com.fastbee.http.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

/**
 * Created by pc on 2017/9/26.
 */

public class MD5Utils {
    private static final char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
            'A', 'B', 'C', 'D', 'E', 'F'};


    /**
     * 字符串 MD5 加密
     *
     * @param text ：文本内容
     * @return　加密后的内容
     */
    public static String encrypt(String text) {
        String result = null;
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("MD5");
            result = byte2hex(md.digest(text.getBytes()));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 加密辅助
     *
     * @param b : 内容二进制数组
     * @return 加密大写十六进制
     */
    private static String byte2hex(byte[] b) {
        String hs = "", stmp = "";
        for (int n = 0; n < b.length; n++) {
            stmp = (Integer.toHexString(b[n] & 0XFF));
            if (stmp.length() == 1) hs = hs + "0" + stmp;
            else hs = hs + stmp;
        }
        return hs.toUpperCase();
    }


    /**
     * 生成全以大写字母
     *
     * @param inStr
     * @return 32byte MD5 Value
     */
    public static String getMD5(String inStr) {
        byte[] inStrBytes = inStr.getBytes();
        try {
            MessageDigest MD = MessageDigest.getInstance("MD5");
            MD.update(inStrBytes);
            byte[] mdByte = MD.digest();
            char[] str = new char[mdByte.length * 2];
            int k = 0;
            for (int i = 0; i < mdByte.length; i++) {
                byte temp = mdByte[i];
                str[k++] = hexDigits[temp >>> 4 & 0xf];
                str[k++] = hexDigits[temp & 0xf];
            }
            return new String(str);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }


    //生成全以小写字母
    public static String getmd5(String str) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(str.getBytes());
            byte[] b = md.digest();
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < b.length; i++) {
                int v = (int) b[i];
                v = v < 0 ? 0x100 + v : v;
                String cc = Integer.toHexString(v);
                if (cc.length() == 1)
                    sb.append('0');
                sb.append(cc);
            }
            return sb.toString();
        } catch (Exception e) {
        }
        return "";
    }

    ////生成随机数字和字母, length为位数
    public String getRandomMD5(int length) {
        String val = "";
        Random random = new Random();
        // 参数length，表示生成几位随机数
        for (int i = 0; i < length; i++) {
            String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";
            // 输出字母还是数字
            if ("char".equalsIgnoreCase(charOrNum)) {
                // 输出是大写字母还是小写字母
                int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;
                val += (char) (random.nextInt(26) + temp);
            } else if ("num".equalsIgnoreCase(charOrNum)) {
                val += String.valueOf(random.nextInt(10));
            }
        }
        return val;
    }
}
