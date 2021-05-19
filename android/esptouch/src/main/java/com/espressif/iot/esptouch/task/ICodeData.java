package com.espressif.iot.esptouch.task;

/**
 * the class used to represent some code to be transformed by UDP socket should implement the interface
 *
 * @author afunx
 */
public interface ICodeData {
    /**
     * Get the byte[] to be transformed.
     *
     * @return the byte[] to be transfromed
     */
    byte[] getBytes();

    /**
     * Get the char[](u8[]) to be transfromed.
     *
     * @return the char[](u8) to be transformed
     */
    char[] getU8s();
}
