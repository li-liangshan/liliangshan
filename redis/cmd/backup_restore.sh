#!/usr/bin/env bash
# SAVE命令用于创建当前Redis数据库的备份。此命令将通过执行同步SAVE在Redis目录中创建dump.rdb文件
SAVE
# BGSAVE是创建Redis备份的备用命令，此命令将启动备份过程并在后台运行。
BGSAVE

## 数据持久化 RDB VS AOF

# 1.RDB全量持久化
# 父进程执行fork操作创建子进程，fork操作过程中父进程会阻塞，阻塞的时间跟所用内存大小成正比，要求redis实例最大不要超过10G。由子进程去创建最新的RDB文件。
# 什么时候会发生持久化操作呢？1、人工执行bgsave命令；2、达到配置文件中指定的约束条件
# rdb文件放置在哪里？ dbfilename 配置项指定
# RDB的优点：redis重启恢复数据的时候速度很快
# RDB的缺点: 无法实时持久化，fork会阻塞父进程
# 关闭RDB配置 ：save “”

# 2.AOF增量持久化
# 默认是关闭的，配置 appendonly yes 开启。appendfilename 指定文件名，保存的路径与RDB一样，通过dir指定
# 所有的操作命令会追加到aof_buf缓冲区，根据策略appendsync everysec 每秒同步到磁盘上的AOF文件。
# aof文件重写压缩过程中也会执行fork操作。
# redis重启时可以加载aof文件进行数据恢复。
# RDB与AOF各有优劣，根据实际业务场景选择合适的方案，甚至不用。

# 3.Redis启动过程的数据恢复
#
#                                   redis启动
#                                       |
#                                    开启AOF?
#                                    /       \
#                                  no         yes
#                                  /            \
#                                 /              \
#                            存在RDB? <-- no -- 存在AOF?
#                              /   \              |
#                            no     yes          yes
#                            /        \           |
#                           /        加载RDB    加载AOF
#                          /             \        /
#                         /               \      /
#                     启动成功 <---- yes --- 成功? ---- no ---> 启动失败
#

## 针对开发人员
# 1 熟悉redis架构原理
# 别拿他当黑盒用，了解哪些操作会导致redis阻塞。否则就是给自己挖坑

# 2 使用redisson 而不是jedis
# 很傻瓜化的一个java客户端，磨刀不误砍柴工，多查看官网api文档，如果你用的很辛苦，那可能是你的姿势不对

# 3 redis使用规范
# 在实际生产环境中，不可能给每个应用都建一套redis集群，一般是按业务领域分。
# 为了防止key冲突，各个应用直接约定key值加上约定的前缀来区分。

# 4 防爬虫的一些策略
# 请求透过缓存层，直接命中DB，并发量大，造成DB层宕机
# 造成缓存穿透的基本原因有两个。第一，自身业务代码或者数据出现问 题，第二，一些恶意攻击、爬虫等造成大量空命中。
# 解决方案：在redis中保存失效期较短的空缓存。

# 5 批量设置
# 在cluster模式下，对mset  mget命令限制很多，要求批量设置的key都在同一台redis实例上，否则报异常。
# 有什么替代方案呢？用hashmap
# Map<String, String> hashmap = new HashMap<String, String>();
# hashmap.put("test1", "value111");
# hashmap.put("test2", "value222");
# hashmap.put("test3", "value333");
# RMap<String, String> map = client.getMap("pnr_test");
# map.expire(20, TimeUnit.SECONDS);
# map.putAll(hashmap);

