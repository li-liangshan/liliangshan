#!/usr/bin/env bash

##### 去重
# 1、sort -u  去除重复只保留一个
# 2、uniq 只去除连续的重复

for i in `cat user_stat.csv | awk -F, '{ print $1 }' | sort -u`
do
   echo "read stats: $i starting ok"
   cat user_stat.csv | grep "$i" |  awk -F, -v key=${i}  'BEGIN{ sum = 0 } { sum=sum+$2; } END{print key"="sum }'
   echo "read stats: $i finished ok"
done
