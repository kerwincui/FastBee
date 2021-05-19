package com.espressif.iot.esptouch.security;

import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class TouchAES implements ITouchEncryptor {
    private static final String TRANSFORMATION_DEFAULT = "AES/ECB/PKCS5Padding";

    private final byte[] mKey;
    private final byte[] mIV;
    private final String mTransformation;
    private Cipher mEncryptCipher;
    private Cipher mDecryptCipher;

    public TouchAES(byte[] key) {
        this(key, null, TRANSFORMATION_DEFAULT);
    }

    public TouchAES(byte[] key, String transformation) {
        this(key, null, transformation);
    }

    public TouchAES(byte[] key, byte[] iv) {
        this(key, iv, TRANSFORMATION_DEFAULT);
    }

    public TouchAES(byte[] key, byte[] iv, String transformation) {
        mKey = key;
        mIV = iv;
        mTransformation = transformation;

        mEncryptCipher = createEncryptCipher();
        mDecryptCipher = createDecryptCipher();
    }

    private Cipher createEncryptCipher() {
        try {
            Cipher cipher = Cipher.getInstance(mTransformation);

            SecretKeySpec secretKeySpec = new SecretKeySpec(mKey, "AES");
            if (mIV == null) {
                cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);
            } else {
                IvParameterSpec parameterSpec = new IvParameterSpec(mIV);
                cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, parameterSpec);
            }

            return cipher;
        } catch (NoSuchAlgorithmException | NoSuchPaddingException | InvalidKeyException | InvalidAlgorithmParameterException
                e) {
            e.printStackTrace();
        }

        return null;
    }

    private Cipher createDecryptCipher() {
        try {
            Cipher cipher = Cipher.getInstance(mTransformation);

            SecretKeySpec secretKeySpec = new SecretKeySpec(mKey, "AES");
            if (mIV == null) {
                cipher.init(Cipher.DECRYPT_MODE, secretKeySpec);
            } else {
                IvParameterSpec parameterSpec = new IvParameterSpec(mIV);
                cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, parameterSpec);
            }

            return cipher;
        } catch (NoSuchAlgorithmException | NoSuchPaddingException | InvalidKeyException | InvalidAlgorithmParameterException
                e) {
            e.printStackTrace();
        }

        return null;
    }

    public byte[] encrypt(byte[] content) {
        try {
            return mEncryptCipher.doFinal(content);
        } catch (BadPaddingException | IllegalBlockSizeException e) {
            e.printStackTrace();
        }
        return null;
    }

    public byte[] decrypt(byte[] content) {
        try {
            return mDecryptCipher.doFinal(content);
        } catch (BadPaddingException | IllegalBlockSizeException e) {
            e.printStackTrace();
        }

        return null;
    }
}
