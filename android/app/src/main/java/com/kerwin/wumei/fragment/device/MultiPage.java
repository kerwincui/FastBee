package com.kerwin.wumei.fragment.device;/*


/**
 * @author xuexiang
 * @since 2018/12/26 下午11:49
 */
public enum MultiPage {

    全部(0),
    浇灌(1),
    一楼(2),
    二楼(3),
    三楼(4),
    走廊(5);

    private final int position;

    MultiPage(int pos) {
        position = pos;
    }

    public static MultiPage getPage(int position) {
        return MultiPage.values()[position];
    }

    public static int size() {
        return MultiPage.values().length;
    }

    public static String[] getPageNames() {
        MultiPage[] pages = MultiPage.values();
        String[] pageNames = new String[pages.length];
        for (int i = 0; i < pages.length; i++) {
            pageNames[i] = pages[i].name();
        }
        return pageNames;
    }

    public int getPosition() {
        return position;
    }

}
