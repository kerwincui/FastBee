FROM openjdk:8u322-jre-slim-buster

ENV VERSION     1.1
ENV AUTHOR      kerwincui
ENV INFO           wumei smart open source living iot platform
ENV SERVERS     nginx:1.14.2, redis-server:5.0.14, emqx:4.0, openjdk:8u322-jre-slim-buster

# mysql环境变量
ENV DB_HOST             localhost
ENV DB_NAME           wumei
ENV DB_USER             root
ENV DB_PASSWORD   admin

RUN apt-get update && \
	# 安装网络工具和设置时区
	apt-get install wget -y --no-install-recommends && \
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	# 更换国内源
	wget http://qiniu.xiwen.online/Debian10.list && \
	mv Debian10.list /etc/apt/sources.list && \
	apt update && apt upgrade -y && \
                # 安装压缩工具
                apt install zip -y && \



# 复制emqx和Nginx的配置文件
COPY ./emqx4.0/emqx.conf /etc/emqx/emqx.conf 
COPY ./emqx4.0/emqx_auth_http.conf /etc/emqx/plugins/emqx_auth_http.conf
COPY ./emqx4.0/emqx_web_hook.conf /etc/emqx/plugins/emqx_web_hook.conf
COPY ./emqx4.0/loaded_plugins /var/lib/emqx/loaded_plugins
COPY ./nginx.conf /etc/nginx/nginx.conf
# 拷贝前后端压缩文件到容器，容器内解压后删除
# COPY ./wumei-smart.tar /var/
# RUN cd /var && tar -xvf wumei-smart.tar && rm wumei-smart.tar

# 解压前端和后端文件并放置到对应位置

# 启动脚本
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# 映射端口
EXPOSE 80 1883 8083

