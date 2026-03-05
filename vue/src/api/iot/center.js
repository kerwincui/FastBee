import request from '@/utils/request';

// 查询设备的历史数据
export function getDataCenterDeviceHistory(data) {
    return request({
        url: '/data/center/deviceHistory',
        method: 'post',
        data: data,
    });
}

// 统计设备物模型指令下发数量
export function getDataCenterCountThingsModelInvoke(query) {
    return request({
        url: '/data/center/countThingsModelInvoke',
        method: 'get',
        params: query,
    });
}