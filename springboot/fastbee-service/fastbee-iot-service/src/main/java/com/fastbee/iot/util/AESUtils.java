package com.fastbee.iot.util;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import java.security.MessageDigest;

/**
 *
 */
public class AESUtils {

    /**
     * 加密用的Key 可以用26个字母和数字组成 使用AES-128-CBC加密模式，key需要为16位。iv 偏移量，长度16
     */
    private static final String ivString = "wumei-smart-open";
    private static final String ENCRYPT_MODE = "CBC"; // ECB和CBC两种模式

    // 加密
    public static String encrypt(String plainText, String key) {
        // 判断Key是否正确
        if (key == null || key.length() != 16) {
            System.out.print("Key不能为空，长度不是16位");
            return null;
        }
        try {
            byte[] raw = key.getBytes("utf-8");
            SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
            Cipher cipher = Cipher.getInstance("AES/" + AESUtils.ENCRYPT_MODE + "/PKCS5Padding");
            if (AESUtils.ENCRYPT_MODE.equals("ECB")) {
                cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
            } else {
                IvParameterSpec iv = new IvParameterSpec(ivString.getBytes("utf-8"));//使用CBC模式，需要一个向量iv，可增加加密算法的强度
                cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
            }
            byte[] encrypted = cipher.doFinal(plainText.getBytes("utf-8"));
            String encryptedStr = new String(new BASE64Encoder().encode(encrypted));
            //此处使用BASE64做转码功能，同时能起到2次加密的作用。
            return encryptedStr;
        } catch (Exception ex) {
            System.out.println(ex.toString());
            return null;
        }
    }

    // 解密
    public static String decrypt(String cipherText, String key) {
        // 判断Key是否正确
        if (key == null || key.length() != 16) {
            System.out.print("Key不能为空，长度不是16位");
            return null;
        }
        // 根据html规范，后端接口，接收参数包含+号会被替换为空格。所以这里需要还原回来，不然会造成解密失败
        cipherText=cipherText.replace(' ','+');

        try {
            byte[] raw = key.getBytes("utf-8");
            SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
            Cipher cipher = Cipher.getInstance("AES/" + AESUtils.ENCRYPT_MODE + "/PKCS5Padding");
            if (AESUtils.ENCRYPT_MODE.equals("ECB")) {
                cipher.init(Cipher.DECRYPT_MODE, skeySpec);
            } else {
                //使用CBC模式，需要一个向量iv，可增加加密算法的强度
                IvParameterSpec iv = new IvParameterSpec(ivString.getBytes("utf-8"));
                cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
            }
            //先用base64解密
            byte[] encrypted = new BASE64Decoder().decodeBuffer(cipherText);
            try {
                byte[] original = cipher.doFinal(encrypted);
                String originalString = new String(original, "utf-8");
                return originalString;
            } catch (Exception e) {
                System.out.println(e.toString());
                return null;
            }
        } catch (Exception ex) {
            System.out.println(ex.toString());
            return null;
        }
    }

    /**
     * 进行MD5加密
     *
     * @param s 要进行MD5转换的字符串
     * @return 该字符串的MD5值的8-24位
     */
    public static String getMD5(String s) {
        char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

        try {
            byte[] btInput = s.getBytes();
            // 获得MD5摘要算法的 MessageDigest 对象
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            // 使用指定的字节更新摘要
            mdInst.update(btInput);
            // 获得密文
            byte[] md = mdInst.digest();
            // 把密文转换成十六进制的字符串形式
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str).substring(8, 24);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
