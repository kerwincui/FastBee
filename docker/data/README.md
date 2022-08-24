<br />

- java目录 --------------- 放置后端打包好的server.jar文件，安装时文件上传到服务器或本地的 /var/data/java 目录中
- nginx目录 -------------- 放置前端打包好的文件，html文件夹上传到服务器或本地的 /var/data/nginx 目录中
- emqx目录 -------------- 放置emqx配置文件
- mysql目录 ------------- 放置mysql配置文件和初始化的数据脚本
- redis目录 -------------- 放置redis的持久化数据，运行时自动生成
- docker-compose.yml -- docker-compose的配置文件，里面定义了版本、服务和网络

<br />

##### docker-compose服务里面包含Redis、Mysql、Emqx、JRE、Nginx，可根据情况进行增减
##### [docker和docker-compose安装系统教程 >> ](https://wumei.live/doc/pages/docker)