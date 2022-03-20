FROM openjdk:8u322-jre-buster

ENV VERSION   1.1
ENV AUTHOR    kerwincui
ENV INFO         wumei smart open source living iot platform

# 安装工具和设置时区 apt install curl -y --no-install-recommends && \ apt-get install vim -y --no-install-recommends && \
RUN apt-get update && \	
	apt-get install wget -y --no-install-recommends && \	
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#更换国内源
RUN wget http://qiniu.xiwen.online/Debian10.list && \
	mv Debian10.list /etc/apt/sources.list && \
	apt update && apt upgrade -y

# 安装nginx和redis
RUN apt-get install nginx -y --no-install-recommends && \
	apt-get install redis-server -y --no-install-recommends

# 安装 emqx
RUN apt update && apt install -y \
    		apt-transport-https \
    		ca-certificates \
    		curl \
    		gnupg-agent \
    		software-properties-common && \
	curl -fsSL https://repos.emqx.io/gpg.pub | apt-key add - && \
	add-apt-repository \
    		"deb [arch=amd64] https://repos.emqx.io/emqx-ce/deb/ubuntu/ \
    		./bionic \
    		stable" && \
	apt update && \
	apt install emqx=4.0.0 -y --no-install-recommends

# 修改redis配置
RUN sed -i "s/# requirepass foobared/requirepass wumei/g" /etc/redis/redis.conf

# 复制emqx和Nginx的配置文件
COPY ./emqx4.0/emqx.conf /etc/emqx/emqx.conf 
COPY ./emqx4.0/emqx_auth_http.conf /etc/emqx/plugins/emqx_auth_http.conf
COPY ./emqx4.0/emqx_web_hook.conf /etc/emqx/plugins/emqx_web_hook.conf
COPY ./nginx.conf /etc/nginx/nginx.conf

# 挂载卷
VOLUME /var/wumei-smart

# 启动脚本
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# 拷贝前后端压缩文件到容器，容器内解压后删除
COPY ./wumei-smart.tar /var/
RUN cd /var && tar -xvf wumei-smart.tar && rm wumei-smart.tar

# 映射端口，可选：8081、8883、18083、8083
EXPOSE 80 1883 8083