#!/usr/bin/env bash

CONFIG GET *  # 获取全部配置

CONFIG GET key #获取键为key的配置

# CONFIG GET 接受单个参数 parameter 作为搜索关键字，查找所有匹配的配置参数，其中参数和值以“键-值对”(key-value pairs)的方式排列。
# 比如执行 CONFIG GET s* 命令，服务器就会返回所有以 s 开头的配置参数及参数的值

CONFIG RESETSTAT

# 重置 INFO 命令中的某些统计数据，包括：
#
#		  Keyspace hits (键空间命中次数)
#		  Keyspace misses (键空间不命中次数)
#		  Number of commands processed (执行命令的次数)
#		  Number of connections received (连接服务器的次数)
#		  Number of expired keys (过期key的数量)
#		  Number of rejected connections (被拒绝的连接数量)
#		  Latest fork(2) time(最后执行 fork(2) 的时间)
#		  The aof_delayed_fsync counter(aof_delayed_fsync 计数器的值)


CONFIG REWRITE
CONFIG SET parameter value

#		CONFIG REWRITE 命令对启动 Redis 服务器时所指定的 redis.conf 文件进行改写： 因为 CONFIG SET 命令可以对服务器的当前配置进行修改， 而修改后的配置可能和 redis.conf 文件中所描述的配置不一样， CONFIG REWRITE 的作用就是通过尽可能少的修改， 将服务器当前所使用的配置记录到 redis.conf 文件中。
#
#		重写会以非常保守的方式进行：
#
#				原有 redis.conf 文件的整体结构和注释会被尽可能地保留。
#				如果一个选项已经存在于原有 redis.conf 文件中 ， 那么对该选项的重写会在选项原本所在的位置（行号）上进行。
#				如果一个选项不存在于原有 redis.conf 文件中， 并且该选项被设置为默认值， 那么重写程序不会将这个选项添加到重写后的 redis.conf 文件中。
#				如果一个选项不存在于原有 redis.conf 文件中， 并且该选项被设置为非默认值， 那么这个选项将被添加到重写后的 redis.conf 文件的末尾。
#				未使用的行会被留白。 比如说， 如果你在原有 redis.conf 文件上设置了数个关于 save 选项的参数， 但现在你将这些 save 参数的一个或全部都关闭了， 那么这些不再使用的参数原本所在的行就会变成空白的。
#				即使启动服务器时所指定的 redis.conf 文件已经不再存在， CONFIG REWRITE 命令也可以重新构建并生成出一个新的 redis.conf 文件。
#
#				另一方面， 如果启动服务器时没有载入 redis.conf 文件， 那么执行 CONFIG REWRITE 命令将引发一个错误。

exp:
before:
	# ... 其他选项
	appendonly no
	# ... 其他选项
after:
	CONFIG GET appendonly # no
	CONFIG SET appendonly yes
	CONFIG GET appendonly # yes
	CONFIG REWRITE
	# ... 其他选项
	appendonly yes
	# ... 其他选项


