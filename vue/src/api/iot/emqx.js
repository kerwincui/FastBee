import axios from 'axios'

const username = process.env.VUE_APP_EMQX_API_USER_NAME;
const password = process.env.VUE_APP_EMQX_API_PASSWORD;

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

//断开客户端连接
export function eliminateClient(clientId){
  var url = "/api/v4/clients/"+clientId;
  return axios({
    method: 'delete',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}

//查看客户端详情
export function getClientDetails(clientId){
  var url = "/api/v4/clients/"+clientId;
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}

//查看集群下指定客户端的订阅信息
export function getSubscriptionsByClientId(clientId){
  var url = "/api/v4/subscriptions/"+clientId;
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}

//取消该客户端订阅
export function unsubscribe(query){
  var url = "/api/v4/mqtt/unsubscribe";
  return axios({
    method: 'post',
    url: url,
    auth: {
      username: username,
      password: password
    },
    params: query
  })
}

//添加该客户端订阅
export function addSubscribe(query){
  var url = "/api/v4/mqtt/subscribe";
  return axios({
    method: 'post',
    url: url,
    auth: {
      username: username,
      password: password
    },
    params: query
  })
}

//获取所有规则引擎的动作
export function getRules(ruleid){
  let url = "";
  if(typeof(ruleid) == 'undefined' || ruleid == '' ||ruleid == null){
    url = "/api/v4/rules";
  }else{
    url = "/api/v4/rules/"+ruleid;
  }
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}


//删除规则
export function deleteRule(ruleid){
  var url = "/api/v4/rules/"+ruleid;
  return axios({
    method: 'delete',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}


//获取资源列表或详情
export function getResources(resourceid){
  let url = "";
  if(typeof(resourceid) == 'undefined' || resourceid == '' ||resourceid == null){
    url = "/api/v4/resources";
  }else{
    url = "/api/v4/resources/"+resourceid;
  }
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}
//获取资源状态
export function getResourcesStatus(resourceid){
  let url =  "/api/v4/resources/"+resourceid;
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}

//连接资源
export function getConnectResource(resourceid){
  let url =  "/api/v4/resources/"+resourceid;
  return axios({
    method: 'post',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}

//删除资源
export function deleteResource(resourceid){
  let url =  "/api/v4/resources/"+resourceid;
  return axios({
    method: 'delete',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}


//获取资源类型
export function getResourcesType(){
  let url =  "/api/v4/resource_types";
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}


//资源测试连接
export function getResourcesConnect(query){
  let url =  "/api/v4/resources?test=true";
  return axios({
    method: 'post',
    url: url,
    auth: {
      username: username,
      password: password
    },
    data: query
  })
}
//新增资源
export function saveResources(query){
  let url =  "/api/v4/resources";
  return axios({
    method: 'post',
    url: url,
    auth: {
      username: username,
      password: password
    },
    data: query
  })
}



//获取规则消息类型
export function getRulesEvent(){
  let url =  "/api/v4/rule_events";
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}

//获取响应动作类型
export function getActionsEvent(){
  let url =  "/api/v4/actions";
  return axios({
    method: 'get',
    url: url,
    auth: {
      username: username,
      password: password
    },
  })
}


//新增规则引擎
export function saveRule(query){
  let url =  "/api/v4/rules";
  return axios({
    method: 'post',
    url: url,
    auth: {
      username: username,
      password: password
    },
    data: query
  })
}
//测试规则引擎
export function testConnectRule(query){
  let url =  "/api/v4/rules?test=true";
  return axios({
    method: 'post',
    url: url,
    auth: {
      username: username,
      password: password
    },
    data: query
  })
}
