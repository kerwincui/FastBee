import mqtt from 'mqtt'
import { getToken } from "@/utils/auth";

let mqttTool = {
  client: null,
}

/** 连接Mqtt */
mqttTool.connect = function () {
  let options = {
    username: "wumei-smart",
    password: getToken(),
    cleanSession: true,
    keepAlive: 30,
    clientId: 'web-' + Math.random().toString(16).substr(2),
    connectTimeout: 10000
  }
  // 配置Mqtt地址
  let url = process.env.VUE_APP_EMQX_SERVER_URL;
  if (url == '') {
    url = "ws://" + window.location.hostname + ":8083/mqtt";
    console.log('自动获取地址');
  }
  console.log("mqtt地址：", url);
  mqttTool.client = mqtt.connect(url, options);
  mqttTool.client.on("connect", (e) => {
    console.log('mqtt连接成功');
  });
  // 重新连接
  mqttTool.client.on('reconnect', (error) => {
    console.log('正在重连:', error)
  });
  // 发生错误
  mqttTool.client.on('error', (error) => {
    console.log('Mqtt客户端连接失败：', error)
    mqttTool.client.end();
  })
  // 断开连接
  mqttTool.client.on('close', function (res) {
    console.log('已断开Mqtt连接');
  });
}
/** 断开连接 */
mqttTool.end = function () {
  return new Promise((resolve, reject) => {
    if (mqttTool.client == null) {
      resolve('未连接')
      console.log("未连接")
      return;
    }
    mqttTool.client.end()
    mqttTool.client = null
    console.log('Mqtt服务器已断开连接！');
    resolve('连接终止')
  })
}
/** 重新连接 */
mqttTool.reconnect = function () {
  return new Promise((resolve, reject) => {
    if (mqttTool.client == null) {
      // 调用resolve方法，Promise变为操作成功状态（fulfilled）
      resolve('未连接')
      console.log("未连接")
      return;
    }
    console.log('正在重连...', res);
    mqttTool.client.reconnect()
  })
}
/** 消息订阅 */
mqttTool.subscribe = function (topics) {
  return new Promise((resolve, reject) => {
    if (mqttTool.client == null) {
      resolve('未连接')
      console.log("未连接")
      uni.showToast({
        icon: 'none',
        title: 'mqtt未连接',
      });
      return;
    }
    mqttTool.client.subscribe(topics, {
      qos: 1
    }, function (err, res) {
      console.log("订阅主题：", topics);
      if (!err) {
        console.log("订阅成功")
        resolve('订阅成功')
      } else {
        console.log("订阅失败，主题可能已经订阅")
        resolve('订阅失败')
        return;
      }
    })
  })
}
/** 取消订阅 */
mqttTool.unsubscribe = function (topics) {
  return new Promise((resolve, reject) => {
    if (mqttTool.client == null) {
      resolve('未连接')
      console.log("未连接")
      return;
    }
    mqttTool.client.unsubscribe(topics, function (err) {
      if (!err) {
        resolve('取消订阅成功')
        console.log("取消订阅成功")
      } else {
        resolve('取消订阅失败')
        console.log("取消订阅失败")
        return;
      }
    })
  })
}
mqttTool.publish = function (topic, message, name) {
  return new Promise((resolve, reject) => {
    if (mqttTool.client == null) {
      resolve('Mqtt客户端未连接')
      console.log("Mqtt客户端未连接")
      return;
    }
    mqttTool.client.publish(topic, message, { qos: 1 }, function (err) {
      console.log('发送主题：', topic);
      console.log('发送内容：', message);
      if (!err) {
        if (topic.indexOf('offline') > 0) {
          console.log("[ " + name + " ] 影子指令发送成功");
          resolve("[ " + name + " ] 影子指令发送成功");
        } else {
          console.log("[ " + name + " ] 指令发送成功");
          resolve("[ " + name + " ] 指令发送成功");
        }
      } else {
        console.log("[ " + name + " ] 指令发送失败");
        reject("[ " + name + " ] 指令发送失败");
        return;
      }
    })
  })
}

export default mqttTool