package com.fastbee.common.utils;

import com.fastbee.common.core.domain.model.LoginUser;

/** Server-owned password-change state, also applied to pre-upgrade sessions. */
public final class PasswordPolicy {
    private PasswordPolicy() {}
    public static boolean isDefault(String raw) { return "admin123".equals(raw) || "123456".equals(raw); }
    /** The explicitly designated demo account only; never exempt the built-in administrator. */
    public static boolean isDemoAccount(LoginUser login) {
        return login != null && login.getUser() != null && !login.getUser().isAdmin()
                && "fastbee".equals(login.getUser().getUserName());
    }
    public static boolean requiresChange(LoginUser login) {
        if (login == null || login.getUser() == null) return true;
        if (isDemoAccount(login)) {
            // Also migrate a demo session cached before this exception was introduced.
            login.setNeedChangePwd(false);
            return false;
        }
        if (login.getNeedChangePwd() == null) {
            String hash = login.getUser().getPassword();
            login.setNeedChangePwd(hash == null || SecurityUtils.matchesPassword("admin123", hash)
                    || SecurityUtils.matchesPassword("123456", hash));
        }
        return Boolean.TRUE.equals(login.getNeedChangePwd());
    }
    public static boolean allowedWhileChanging(String method, String path) {
        return "GET".equals(method) && ("/getInfo".equals(path) || "/getRouters".equals(path) || "/system/user/profile".equals(path))
                || "PUT".equals(method) && "/system/user/profile/updatePwd".equals(path)
                || "POST".equals(method) && "/logout".equals(path);
    }
}
