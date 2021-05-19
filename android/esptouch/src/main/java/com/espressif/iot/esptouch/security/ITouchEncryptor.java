package com.espressif.iot.esptouch.security;

public interface ITouchEncryptor {
    byte[] encrypt(byte[] src);
}
