#!/usr/bin/env bash
# Redis Server命令用于管理Redis服务器。
# 有不同的服务器命令可用于获取服务器信息，统计信息和其他特征。

## Redis 连接命令：
# AUTH password 	使用给定密码对服务器进行身份验证。
AUTH password
#	ECHO message 	打印给定的字符串。
ECHO message
#	PING	检查服务器是否正在运行。
PING
#	QUIT	关闭当前连接。
QUIT
#	SELECT index	更改当前连接的选定数据库

## Redis服务器命令:
# 1	  BGREWRITEAOF	                                       异步重写仅附加文件。
# 2	  BGSAVE	                                             将数据集异步保存到磁盘。
# 3	  CLIENT KILL [ip:port] [ID client-id]	               终止客户端的连接。
# 4	  CLIENT LIST	                                         获取服务器的客户端连接列表。
# 5	  CLIENT GETNAME	                                     获取当前连接的名称。
# 6	  CLIENT PAUSE timeout	                               在指定时间内停止处理来自客户端的命令。
# 7	  CLIENT SETNAME connection-name	                     设置当前连接名称。
# 8	  CLUSTER SLOTS	                                       获取集群节点的映射数组
# 9	  COMMAND	                                             获取Redis命令详细信息的数组。
# 10	COMMAND COUNT	                                       获取Redis命令的总数。
# 11	COMMAND GETKEYS	                                     给定完整的Redis命令，此命令用于提取key。
# 12	BGSAVE	                                             数据集异步保存到磁盘。
# 13	COMMAND INFO command-name [command-name …]	         获取特定Redis命令详细信息的数组。
# 14	CONFIG GET参数	                                       此命令用于获取配置参数的值。
# 15	CONFIG REWRITE	                                     此命令用于使用内存配置重写配置文件。
# 16	CONFIG SET参数值	                                     此命令用于获取给定值的配置参数。
# 17	CONFIG RESETSTAT	                                   此命令用于重置INFO返回的统计信息。
# 18	DBSIZE	                                             此命令用于返回所选数据库中的键数。
# 19	DEBUG OBJECT键	                                     此命令用于获取有关密钥的调试信息。
# 20	DEBUG SEGFAULT	                                     此命令用于使服务器崩溃。
# 21	FLUSHALL	                                           此命令用于从所有数据库中删除所有密钥。
# 22	FLUSHDB	                                             此命令用于从当前数据库中删除所有键。
# 23	信息[部分]	                                           此命令用于获取有关服务器的信息和统计信息。
# 24	LASTSAVE	                                           此命令用于检索上次成功保存到磁盘的UNIX时间戳。
# 25	监控	                                                 此命令用于实时侦听服务器收到的所有请求。
# 26	角色	                                                 此命令用于在复制上下文中返回实例的角色。
# 27	保存	                                                 此命令用于将数据集同步保存到磁盘。
# 28	关闭[NOSAVE] [保存]	                                 此命令用于将数据集同步保存到磁盘，然后关闭服务器。
# 29	SLAVEOF主机端口	                                     此命令用于使服务器成为另一个实例的从属服务器，或将其作为主服务器提升。
# 30	SLOWLOG子命令[参数]	                                 此命令用于管理Redis慢查询日志。
# 31	同步	                                                 此命令用于复制。
# 32	时间	                                                 此命令用于返回当前服务器时间。
