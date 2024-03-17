## 1.clone本项目
```
   git clone https://gitee.com/zhuangpengli/fastbee-docker.git
   cd fastbee-docker
   cp -rf ./data /var
```
## 2.编译java包
```
   git clone https://gitee.com/zhuangpengli/FastBee.git
   cd FastBee/springboot
   # 编译emqx版本 请修改fastbee-admin下面 application.yml
   # server:  
   #    broker:
   #        enabled: false
   #        openws: false
   # 编译netty mqtt版本 保持默认配置
   mvn clean package -Dmaven.test.skip=true
   cp ./fastbee-admin/target/fastbee-admin.jar /var/data/java/fastbee-admin.jar
```

## 3.打包前端目录
```
   git clone https://gitee.com/zhuangpengli/FastBee.git
   cd FastBee/vue
   npm install
   npm run build:prod
   cp -rf ./dist/* /var/data/nginx/vue
```

## 4.启动项目
```
   cd /var/data
   setenforce 0
   chmod 777 -R /var/data 
   # 使用emqx版本mqtt broker输入该命令：
   sudo cp -rf docker-compose-emqx.yml docker-compose.yml
   # 使用netty mqtt则使用默认脚本直接启动
   docker-compose up -d
```
