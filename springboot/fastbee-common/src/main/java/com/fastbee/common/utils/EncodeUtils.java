package com.fastbee.common.utils;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.codec.Hex;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.regex.Pattern;

public class EncodeUtils {

    private static final Logger logger               = LoggerFactory.getLogger(EncodeUtils.class);
    private static final String DEFAULT_URL_ENCODING = "UTF-8";
    private static final char[] BASE62 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".toCharArray();
    private static Pattern p1 = Pattern.compile("<\\s*(script|link|style|iframe)([\\s\\S]+?)<\\/\\s*\\1\\s*>", 2);
    private static Pattern p2 = Pattern.compile("\\s*on[a-z]+\\s*=\\s*(\"[^\"]+\"|'[^']+'|[^\\s]+)\\s*(?=>)", 2);
    private static Pattern p3 = Pattern.compile("\\s*(href|src)\\s*=\\s*(\"\\s*(javascript|vbscript):[^\"]+\"|'\\s*(javascript|vbscript):[^']+'|(javascript|vbscript):[^\\s]+)\\s*(?=>)", 2);
    private static Pattern p4 = Pattern.compile("epression\\((.|\\n)*\\);?", 2);
    private static Pattern p5 = Pattern.compile("(?:')|(?:--)|(/\\*(?:.|[\\n\\r])*?\\*/)|(\\b(select|update|and|or|delete|insert|trancate|char|into|substr|ascii|declare|exec|count|master|into|drop|execute)\\b)", 2);

    public EncodeUtils() {
    }

    public static String encodeHex(byte[] input) {
        return new String(Hex.encode(input));
    }

    public static byte[] decodeHex(String input) {
        try {
            return Hex.decode(input);
        } catch (Exception var2) {
            throw ExceptionUtils.unchecked(var2);
        }
    }

    public static String encodeBase64(byte[] input) {
        return new String(Base64.encodeBase64(input));
    }

    public static String encodeBase64(String input) {
        try {
            return new String(Base64.encodeBase64(input.getBytes("UTF-8")));
        } catch (UnsupportedEncodingException var2) {
            return "";
        }
    }

    public static byte[] decodeBase64(String input) {
        return Base64.decodeBase64(input.getBytes());
    }

    public static String decodeBase64String(String input) {
        try {
            return new String(Base64.decodeBase64(input.getBytes()), "UTF-8");
        } catch (UnsupportedEncodingException var2) {
            return "";
        }
    }

    public static String encodeBase62(byte[] input) {
        char[] chars = new char[input.length];

        for(int i = 0; i < input.length; ++i) {
            chars[i] = BASE62[(input[i] & 255) % BASE62.length];
        }

        return new String(chars);
    }

    public static String encodeHtml(String html) {
        return StringEscapeUtils.escapeHtml4(html);
    }

    public static String decodeHtml(String htmlEscaped) {
        return StringEscapeUtils.unescapeHtml4(htmlEscaped);
    }

    public static String encodeXml(String xml) {
        return StringEscapeUtils.escapeXml(xml);
    }

    public static String decodeXml(String xmlEscaped) {
        return StringEscapeUtils.unescapeXml(xmlEscaped);
    }

    public static String encodeUrl(String part) {
        return encodeUrl(part, "UTF-8");
    }

    public static String encodeUrl(String part, String encoding) {
        if(part == null) {
            return null;
        } else {
            try {
                return URLEncoder.encode(part, encoding);
            } catch (UnsupportedEncodingException var3) {
                throw ExceptionUtils.unchecked(var3);
            }
        }
    }

    public static String decodeUrl(String part) {
        return decodeUrl(part, "UTF-8");
    }

    public static String decodeUrl(String part, String encoding) {
        try {
            return URLDecoder.decode(part, encoding);
        } catch (UnsupportedEncodingException var3) {
            throw ExceptionUtils.unchecked(var3);
        }
    }

    public static String decodeUrl2(String part) {
        return decodeUrl(decodeUrl(part));
    }

    public static String xssFilter(String text) {
        if(text == null) {
            return null;
        } else {
            String oriValue = StringUtils.trim(text);
            String value = p1.matcher(oriValue).replaceAll("");
            value = p2.matcher(value).replaceAll("");
            value = p3.matcher(value).replaceAll("");
            value = p4.matcher(value).replaceAll("");
            if(!StringUtils.startsWithIgnoreCase(value, "<!--HTML-->") && !StringUtils.startsWithIgnoreCase(value, "<?xml ") && !StringUtils.contains(value, "id=\"FormHtml\"") && (!StringUtils.startsWith(value, "{") || !StringUtils.endsWith(value, "}")) && (!StringUtils.startsWith(value, "[") || !StringUtils.endsWith(value, "]"))) {
                value = value.replaceAll("\"", "&quot;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
            }

            if(logger.isInfoEnabled() && !value.equals(oriValue)) {
                logger.info("xssFilter: {} to {}", text, value);
            }

            return value;
        }
    }

    public static String sqlFilter(String text) {
        if(text != null) {
            String value = p5.matcher(text).replaceAll("");
            if(logger.isWarnEnabled() && !value.equals(text)) {
                logger.warn("sqlFilter: {} to {}", text, value);
                return "";
            } else {
                return value;
            }
        } else {
            return null;
        }
    }
}

