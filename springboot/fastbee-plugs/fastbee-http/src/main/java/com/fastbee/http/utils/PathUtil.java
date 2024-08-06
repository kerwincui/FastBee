package com.fastbee.http.utils;

import java.io.File;

public class PathUtil {

    public static String appendPathSep(String src, String separator, String... addPaths){
        StringBuilder result = new StringBuilder(src);
        for (int i = 0; i < addPaths.length; i++) {
            String temp = addPaths[i].startsWith(separator)? addPaths[i] : separator + addPaths[i];
            if (result.toString().endsWith(separator)) {
                //含头不含尾
                result.delete(result.length() - separator.length(), result.length());
            }
            result.append(temp);
        }
        return result.toString();
    }

    public static String appendWebPath(String src, String... addPaths) {
        return  appendPathSep(src, "/", addPaths);
    }

    public static String appendPath(String src, String... addPaths) {
        return  appendPathSep(src, File.separator, addPaths);
    }

    public static boolean startWith(String src, String[] sep) {
        for (String s : sep) {
            if(src.startsWith(s)){
                return true;
            }
        }
        return false;
    }

}
