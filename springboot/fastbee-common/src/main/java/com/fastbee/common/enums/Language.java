package com.fastbee.common.enums;

public enum Language {
    ZH_CN("zh-CN"),
    EN("en-US"),
    DEFAULT("default");

    private String value;

    Language(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static String matches(String language) {
        if(language.equals("zh")){
            return Language.ZH_CN.value;
        }else {
            return Language.EN.value;
        }
    }
}
