FROM ubuntu:20.04   as   build


RUN export DEBIAN_FRONTEND=noninteractive &&\
        apt-get update && \
        apt-get install -y --no-install-recommends openjdk-8-jre-headless openjdk-8-jdk-headless git maven nodejs npm openssl && \
        mkdir -p  /opt/fastbee/java  /opt/fastbee/vue


RUN cd /home && \
        git clone "https://gitee.com/zhuangpengli/FastBee" && \
        cp /home/FastBee/docker/settings.xml /usr/share/maven/conf/

RUN cd /home/FastBee/vue && \
        npm install --registry=https://registry.npmmirror.com && \
        npm run build:prod && \
        cp -rf /home/FastBee/vue/dist/* /opt/fastbee/vue/

RUN cd /home/FastBee/springboot && \
        mvn clean package -Dmaven.test.skip=true && \
        cp -rf /home/FastBee/springboot/fastbee-admin/target/fastbee-admin.jar /opt/fastbee/java


FROM openjdk:8-jre

EXPOSE 8080/tcp
EXPOSE 1883/tcp
EXPOSE 8083/tcp
EXPOSE 8888/tcp
EXPOSE 8889/tcp
EXPOSE 5061/udp

ENV LC_ALL zh_CN.UTF-8

COPY --from=build /opt/fastbee/java /opt

WORKDIR /opt

CMD ["java", "-jar", "/server.jar"]

FROM nginx:stable

EXPOSE 80/tcp
EXPOSE 443/tcp

ENV LC_ALL zh_CN.UTF-8

COPY --from=build /opt/fastbee/vue/* /usr/share/nginx/html
COPY ./data/nginx/ssl/* /usr/share/nginx/ssl
COPY ./data/nginx/nginx.conf /etc/nginx/nginx.conf