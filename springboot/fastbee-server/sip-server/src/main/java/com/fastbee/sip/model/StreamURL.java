package com.fastbee.sip.model;

import lombok.Data;

@Data
public class StreamURL {
    private String protocol;
    private String host;
    private int port = -1;
    private String file;
    private String url;

    public StreamURL() {
    }

    public StreamURL(String protocol, String host, int port, String file) {
        this.protocol = protocol;
        this.host = host;
        this.port = port;
        this.file = file;
    }

    @Override
    public String toString() {
        if (protocol != null && host != null && port != -1 ) {
            return String.format("%s://%s:%s/%s", protocol, host, port, file);
        }else {
            return null;
        }
    }
}
