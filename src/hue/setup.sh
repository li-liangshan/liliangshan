#!/usr/bin/env bash

docker pull gethue/hue:latest

docker run -tid --name hue8888 --hostname cnode1.domain.org \
 -p 8888:8888 -v $HADOOP_HOME/etc/hadoop:/etc/hadoop \
 -v $HIVE_HOME/etc/hive:/etc/hive -v /etc/hbase:/etc/hbase \
 -v /docker-config/pseudo-distributed.ini /hue/desktop/conf/pseudo-distributed.ini \
  gethue/hue:latest \
   ./build/env/bin/hue runserver_plus 0.0.0.0:8888
