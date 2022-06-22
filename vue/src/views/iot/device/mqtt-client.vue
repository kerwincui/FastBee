<template>
<span></span>
</template>

<script>
import mqtt from 'mqtt'
import {
    getToken
} from "@/utils/auth";

export default {
    name: "mqttClient",
    props: {
        publish: {
            type: Object,
            default: null
        },
        subscribes: {
            type: Array,
            default: null
        }
    },
    watch: {
        // 获取到父组件传递的值
        publish: function (val, oldVal) {
            this.mqttPublish(val.topic, val.message, val.name);
        },
        subscribes: function (val, oldVal) {
            this.connectMqtt(val);
        }
    },
    data() {
        return {};
    },
    created() {

    },
    methods: {
        /** 连接Mqtt */
        connectMqtt(subscribeTopics) {
            let randomClientId = 'web-' + Math.random().toString(16).substr(2);
            let options = {
                username: "wumei-smart",
                password: getToken(),
                cleanSession: false,
                keepAlive: 30,
                clientId: randomClientId,
                connectTimeout: 10000
            }
            // 配置Mqtt地址
            // let url = "ws://" + window.location.hostname + ":8083/mqtt";
            console.log("mqtt地址：", process.env.VUE_APP_EMQX_SERVER_URL);
            this.client = mqtt.connect(process.env.VUE_APP_EMQX_SERVER_URL, options);
            this.client.on("connect", (e) => {
                console.log("客户端：" + randomClientId + "，成功连接服务器:", e);
                // 订阅主题
                if (subscribeTopics != '' && subscribeTopics.length > 0) {
                    this.client.subscribe(subscribeTopics, {
                        qos: 1
                    }, (err) => {
                        if (!err) {
                            console.log("订阅成功");
                            console.log(subscribeTopics.join(", "));
                        } else {
                            console.log('消息订阅失败！')
                        }
                    });
                }
            });
            // 重新连接
            this.reconnectMqtt()
            // 是否已经断开连接
            this.mqttError()
            // 监听获取信息
            this.mqttSubscribe()
        },

        /** 发布消息 */
        mqttPublish(topic, message, name) {
            if (!this.client.connected) {
                console.log('客户端未连接')
                this.$modal.notifyError("Mqtt客户端未连接");
                return
            }
            this.client.publish(topic, message, {
                qos: 1
            }, (err) => {
                if (!err) {
                    console.log('成功发布主题：' + topic)
                    console.log('主题内容：' + message);
                    if (topic.indexOf('offline') > 0) {
                        this.$modal.notify("[ " + name + " ] 影子指令发送成功");
                    } else {
                        this.$modal.notifySuccess("[ " + name + " ] 指令发送成功");
                    }
                }
            })
        },

        /** 监听Mqtt消息 */
        mqttSubscribe() {
            this.client.on("message", (topic, message) => {
                console.log('收到来自', topic, '的信息', message.toString())
                // 传递信息到父组件
                let data = {};
                data.topic = topic;
                data.message = JSON.parse(message.toString());
                this.$emit('callbackEvent', data);
            });
        },
        /** 监听服务器是否连接失败 */
        mqttError() {
            this.client.on('error', (error) => {
                console.log('连接失败：', error)
                this.$modal.notifyError("Mqtt客户端连接失败");
                this.client.end();
            })
        },
        /** 取消订阅 */
        unsubscribeMqtt() {
            this.client.unsubscribe(this.mtopic, (error) => {
                console.log('主题为' + this.mtopic + '取消订阅成功', error)
            })
        },
        /** 断开连接 */
        unconnectMqtt() {
            this.client.end()
            this.client = null
            console.log('服务器已断开连接！');
            this.$modal.notifyError("Mqtt服务器已断开连接！");
        },
        /** 监听服务器重新连接 */
        reconnectMqtt() {
            this.client.on('reconnect', (error) => {
                console.log('正在重连:', error)
            });
        },

    }
};
</script>
