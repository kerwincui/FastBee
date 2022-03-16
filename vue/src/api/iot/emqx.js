import axios from 'axios'

const username = 'admin';
const password = 'public';

// 集群下所有客户端列表
export function listMqttClient(query) {  
  var url = "/api/v4/clients";
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
    params: query
  })
}

// 集群下所有订阅信息
export function listMqttSubscribe(query) {  
  var url = "/api/v4/subscriptions";
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
    params: query
  })
}

// 集群下所有主题/路由信息
export function listMqttTopic(query) {  
  var url = "/api/v4/routes";
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
    params: query
  })
}

// 集群下所有插件信息
export function listMqttPlugin() {  
  var url = "/api/v4/plugins";
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}

// 加载指定节点的指定插件
export function loadMqttPlugin(node,plugin) {  
  var url = "/api/v4/nodes/"+node+"/plugins/"+plugin+"/load";
  return axios({
    method: 'put',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}

// 卸载指定节点的指定插件
export function unloadMqttPlugin(node,plugin) {  
  var url = "/api/v4/nodes/"+node+"/plugins/"+plugin+"/unload";
  return axios({
    method: 'put',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}

// 集群下所有监听器信息
export function listMqttListener() {  
  var url = "/api/v4/listeners";
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}

// 集群下所有统计指标数据
export function statisticMqtt() {  
  var url = "/api/v4/metrics";
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}

// 集群下所有状态数据
export function getMqttStats() {  
  var url = "/api/v4/stats";
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}
