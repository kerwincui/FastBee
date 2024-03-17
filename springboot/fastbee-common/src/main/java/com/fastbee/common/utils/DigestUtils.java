package com.fastbee.common.utils;

import com.fastbee.common.utils.uuid.IdUtils;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.Validate;

import java.io.IOException;
import java.io.InputStream;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.SecureRandom;

@NoArgsConstructor
public class DigestUtils {
    private static SecureRandom random = new SecureRandom();
    private static IdUtils idUtils = new IdUtils(0,0);

    public static String getId(){
        return String.valueOf(Math.abs(random.nextLong()));
    }

    public static String nextId(){
        return String.valueOf(idUtils.nextId());
    }


    public static byte[] genSalt(int numBytes) {
        Validate.isTrue(numBytes > 0, "numBytes argument must be a positive integer (1 or larger)", (long)numBytes);
        byte[] bytes = new byte[numBytes];
        random.nextBytes(bytes);
        return bytes;
    }

    public static byte[] digest(byte[] input, String algorithm, byte[] salt, int iterations) {
        try {
            MessageDigest digest = MessageDigest.getInstance(algorithm);
            if(salt != null) {
                digest.update(salt);
            }

            byte[] result = digest.digest(input);

            for(int i = 1; i < iterations; ++i) {
                digest.reset();
                result = digest.digest(result);
            }

            return result;
        } catch (GeneralSecurityException var7) {
            throw ExceptionUtils.unchecked(var7);
        }
    }

    public static byte[] digest(InputStream input, String algorithm) throws IOException {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance(algorithm);
            int bufferLength = 8192;
            byte[] buffer = new byte[bufferLength];

            for(int read = input.read(buffer, 0, bufferLength); read > -1; read = input.read(buffer, 0, bufferLength)) {
                messageDigest.update(buffer, 0, read);
            }

            return messageDigest.digest();
        } catch (GeneralSecurityException var6) {
            throw ExceptionUtils.unchecked(var6);
        }
    }

    public static void main(String[] args) {
        for (int i = 0; i < 10; i++) {
            System.out.println(nextId());
        }
    }
}
