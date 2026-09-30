// UX coordination only. The backend remains authoritative for access control.
export const PASSWORD_CHANGE_ROUTE = '/change-password';

export function isPasswordChangeResponse(data, status) {
    return !!data && data.needChangePwd === true && (status === 403 || data.code === 403);
}

export function allowedWhileChangingPassword(config) {
    const method = (config.method || 'get').toUpperCase();
    const path = (config.url || '').split(/[?#]/)[0];
    return (method === 'GET' && ['/getInfo', '/getRouters', '/system/user/profile'].includes(path))
        || (method === 'PUT' && path === '/system/user/profile/updatePwd')
        || (method === 'POST' && path === '/logout');
}
