import request from '@/utils/request';

// 查询规则引擎脚本列表
export function listScript(query) {
    return request({
        url: '/iot/script/list',
        method: 'get',
        params: query,
    });
}

// 查询规则引擎脚本详细
export function getScript(scriptId) {
    return request({
        url: '/iot/script/' + scriptId,
        method: 'get',
    });
}

// 查询规则引擎脚本日志
export function getScriptLog(scriptId) {
    return request({
        url: '/iot/script/log/' + scriptId,
        method: 'get',
    });
}


// 新增规则引擎脚本
export function addScript(data) {
    return request({
        url: '/iot/script',
        method: 'post',
        data: data,
    });
}

// 修改规则引擎脚本
export function updateScript(data) {
    return request({
        url: '/iot/script',
        method: 'put',
        data: data,
    });
}

// 删除规则引擎脚本
export function delScript(scriptId) {
    return request({
        url: '/iot/script/' + scriptId,
        method: 'delete',
    });
}

// 验证规则脚本
export function validateScript(scriptData) {
    return request({
        url: '/iot/script/validate',
        method: 'post',
        data: scriptData,
    });
}
