#!/bin/bash

# start service
startTime=$(date "+%Y-%m-%d %H:%M:%S")
echo $startTime : wumei-smart is starting...

service nginx start
service redis-server start
emqx start
#service mysql start
#java -jar /var/wumei-smart/java/app.jar


while true
do
	time=$(date "+%Y-%m-%d %H:%M:%S")
	echo $time : wumei-smart is running...
	sleep 3600
done


