package com.fastbee.common.utils;

import lombok.NoArgsConstructor;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

@NoArgsConstructor
public class Md5Utils {
    private static final String MD5 = "MD5";
    private static final String DEFAULT_ENCODING = "UTF-8";



    public static String md5(String input) {
        return md5((String) input, 1);
    }

    public static String md5(String input, int iterations) {
        try {
            return EncodeUtils.encodeHex(DigestUtils.digest(input.getBytes("UTF-8"), "MD5", (byte[]) null, iterations));
        } catch (UnsupportedEncodingException var3) {
            return "";
        }
    }

    public static byte[] md5(byte[] input) {
        return md5((byte[]) input, 1);
    }

    public static byte[] md5(byte[] input, int iterations) {
        return DigestUtils.digest(input, "MD5", (byte[]) null, iterations);
    }

    public static byte[] md5(InputStream input) throws IOException {
        return DigestUtils.digest(input, "MD5");
    }

    public static boolean isMd5(String str) {
        int cnt = 0;
        for (int i = 0; i < str.length(); ++i) {
            switch (str.charAt(i)) {
                case '0':
                case '1':
                case '2':
                case '3':
                case '4':
                case '5':
                case '6':
                case '7':
                case '8':
                case '9':
                case 'a':
                case 'b':
                case 'c':
                case 'd':
                case 'e':
                case 'f':
                case 'A':
                case 'B':
                case 'C':
                case 'D':
                case 'E':
                case 'F':
                    ++cnt;
                    if (32 <= cnt) return true;
                    break;
                case '/':
                    if ((i + 10) < str.length()) {// "/storage/"
                        char ch1 = str.charAt(i + 1);
                        char ch2 = str.charAt(i + 8);
                        if ('/' == ch2 && ('s' == ch1 || 'S' == ch1)) return true;
                    }
                default:
                    cnt = 0;
                    break;
            }
        }
        return false;
    }
}
