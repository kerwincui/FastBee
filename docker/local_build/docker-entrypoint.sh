#!/bin/bash

# start service
startTime=$(date "+%Y-%m-%d %H:%M:%S")
echo $startTime : wumei-smart is starting, please waiting ...

# 提取jar包配置文件
cd /var/wumei-smart/java
unzip app.jar BOOT-INF/classes/application-druid.yml
# 修改mysql配置
sed -i "s/{DB_HOST}/$DB_HOST/g" BOOT-INF/classes/application-druid.yml
sed -i "s/{DB_NAME}/$DB_NAME/g" BOOT-INF/classes/application-druid.yml
sed -i "s/{DB_USER}/$DB_USER/g" BOOT-INF/classes/application-druid.yml
sed -i "s/{DB_PASSWORD}/$DB_PASSWORD/g" BOOT-INF/classes/application-druid.yml
# 配置文件写入jar包，并删除提取的配置
zip app.jar BOOT-INF/classes/application-druid.yml
rm -rf BOOT-INF

service nginx start
service redis-server start
emqx start
java -jar /var/wumei-smart/java/app.jar


while true
do
	time=$(date "+%Y-%m-%d %H:%M:%S")
	echo $time : wumei-smart is running...
	sleep 3600
done


