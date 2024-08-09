
## GB28181 Roadmap
- 设备基础信息上报
- 物模型适配（属性，功能）
- 设备直播
- 设备录像拉取 
- PTZ云台控制
- 设备自动拉流 云端录像
- tcp传输信令
- 添加事件处理机制
- srs m7s流媒体服务器支持
- 百度evs，七牛云qvs等云平台api对接

## webhook
- on_http_access
- on_play
- on_publish
- on_stream_none_reader //StopPlay
- on_stream_not_found
- on_stream_changed

## zlm api
- url + "/index/api/getRtpInfo?secret=" + secret + "&stream_id=" + ssrc 获取流在zlm上的信息
- url + "/index/api/openRtpServer?secret=" + secret + "&port=0&enable_tcp=1&stream_id=" + streamId + "&ssrc=" + ssrc 创建GB28181 RTP接收端口
- url + "/index/api/closeRtpServer?secret=" + secret + "&stream_id=" + streamId 关闭GB28181 RTP接收端口
- url + "/index/api/listRtpServer?secret=" + secret 获取RTP服务器
- url + "/index/api/close_streams?secret=" + secret + "&stream=" + ssrc 关闭流
- url + "/index/api/getMediaList?secret=" + secret + "&stream=" + ssrc 获取流信息

