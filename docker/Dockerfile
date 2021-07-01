FROM debian:buster-slim

ENV VERSION   1.0
ENV AUTHOR    kerwincui
ENV INFO         wumei-smart

# 安装工具和设置时区
RUN apt-get update && \
	apt-get install vim -y --no-install-recommends && \
	apt-get install wget -y --no-install-recommends && \
	apt install curl -y --no-install-recommends && \
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 安装nginx和redis，需要容器内配置nginx和redis
RUN apt-get install nginx -y --no-install-recommends && \
	apt-get install redis-server -y --no-install-recommends

#安装jdk8
RUN mkdir /usr/share/man/man1 && \
	apt-get update && \
	apt install apt-transport-https ca-certificates wget dirmngr gnupg software-properties-common -y && \
	wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
	add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
	apt update && \
	apt install adoptopenjdk-8-hotspot -y --no-install-recommends

# 安装 emqx，需要修改密码
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
	apt install emqx -y --no-install-recommends

# 安装mysql，需要容器内安装

# 挂载卷
VOLUME /var/wumei-smart

# 启动脚本
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# 拷贝前后端压缩文件到容器，容器内解压后删除
COPY ./wumei-smart.tar /var/
RUN cd /var && tar -xvf wumei-smart.tar && rm wumei-smart.tar


# 映射端口
EXPOSE 80 3306 1883 18083