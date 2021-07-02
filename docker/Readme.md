# 服务启动
service nginx start
service redis-server start
service mysql start
emqx start
java -jar /var/wumei-smart/app.jar

# 镜像构建
docker build -t wumei-smart:1.0 .
# 复制文件到容器
docker cp wumei-smart/* container:/var/wumei-smart/
# 镜像导出导入
docker export container| docker import - kerwincui/wumei-smart:1.0
# 镜像推送
阿里云镜像：registry.cn-chengdu.aliyuncs.com/kerwincui/wumei-smart:1.0
docker tag wumei-smart kerwincui/wumei-smart:1.0
docker push kerwinci/wumei-smart:1.0

# 容器运行
docker run \
--name wumei-smart \
--publish 80:80 \
--publish 18083:18083 \
--publish 1883:1883 \
--publish 3306:3306 \
--publish 6379:6379 \
--restart always \
--detach \
kerwincui/wumei-smart:1.0

docker run ^
--name wumei-smart ^
--publish 80:80 ^
--publish 18083:18083 ^
--publish 1883:1883 ^
--publish 3306:3306 ^
--publish 6379:6379 ^
--restart always ^
--detach ^
kerwincui/wumei-smart:1.0



########################容器内处理##########################
# 安装mysql
### wget http://repo.mysql.com/mysql-apt-config_0.8.13-1_all.deb && \
	apt install ./mysql-apt-config_0.8.13-1_all.deb && \
	apt update && \
	apt install mysql-server -y
### service mysql start
### mysql_secure_installation
# 配置远程访问 
### vim /etc/mysql/mysql.conf.d/mysqld.cnf ，注释bind-address
### 本地登录mysql并更新用户host，并刷新
### update mysql.user set host='%' where user='root'; flush privileges;
# 查看mysql字符集编码
### show variables like 'character%';
# 修改编码
### vim /etc/mysql/mysql.conf.d/mysqld.cnf  ，增加character-set-server=utf8
### vim /etc/mysql/conf.d/mysql.cnf ，增加default-character-set=utf8
# 导入sql文件

# 配置redis
# vim /etc/redis/redis.conf ，取消注释requirepass admin123，注释 bind:127.0.0.1

# 配置docker-entrypoint.sh
# vim /docker-entrypoint.sh 启动mysql和java app

# 配置nginx
# vim /etc/nginx/nginx.conf，nginx服务配置

http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;

    server {
        listen       80;
        server_name  localhost;

         location / {
            root   /var/wumei-smart/vue;
            try_files $uri $uri/ /index.html;
            index  index.html index.htm;
        }
		
         location /prod-api/{
             proxy_set_header Host $http_host;
             proxy_set_header X-Real-IP $remote_addr;
             proxy_set_header REMOTE-HOST $remote_addr;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
             proxy_pass http://localhost:8080/;
          }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
}
