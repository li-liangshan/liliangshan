#!/usr/bin/env bash

template:
	COMMAND KEY_NAME

DEL KEY_NAME # DEL 命令用于删除已存在的键。不存在的 key 会被忽略 return 0 or 1

SET KEY_NAME VALUE # SET 如果 key 已经持有其他值， SET 就覆写旧值，无视类型。 return OK

DUMP KEY_NAME # DUMP 命令用于序列化给定 key ，并返回被序列化的值。 如果 key 不存在，那么返回 nil 。 否则，返回序列化之后的值。

EXISTS KEY_NAME # EXISTS 命令用于检查给定 key 是否存在。若 key 存在返回 1 ，否则返回 0 。

EXPIRE KEY_NAME TIME_IN_SECONDS # Expire 命令用于设置 key 的过期时间，key 过期后将不再可用。单位以秒计。 return 0 or 1

EXPIREAT KEY_NAME TIME_IN_UNIX_TIMESTAMP # EXPIREAT 命令用于以 UNIX 时间戳(unix timestamp)格式设置 key 的过期时间。key 过期后将不再可用。return 0 or 1

PEXPIRE key milliseconds # PEXPIRE 命令和 EXPIRE 命令的作用类似，但是它以毫秒为单位设置 key 的生存时间，而不像 EXPIRE 命令那样，以秒为单位

PEXPIREAT KEY_NAME TIME_IN_MILLISECONDS_IN_UNIX_TIMESTAMP # PEXPIREAT 命令用于设置 key 的过期时间，以毫秒计。key 过期后将不再可用。

KEYS PATTERN # 命令用于查找所有符合给定模式 pattern 的key。

MOVE KEY_NAME DESTINATION_DATABASE # MOVE 命令用于将当前数据库的 key 移动到给定的数据库 db 当中。

PERSIST KEY_NAME # PERSIST 命令用于移除给定 key 的过期时间，使得 key 永不过期。

PTTL KEY_NAME # PTTL 命令以毫秒为单位返回 key 的剩余过期时间。

TTL KEY_NAME # TTL 命令以秒为单位返回 key 的剩余过期时间。

RANDOMKEY # 命令从当前数据库中随机返回一个 key 。

RENAME OLD_KEY_NAME NEW_KEY_NAME # 命令用于修改 key 的名称

RENAMENX OLD_KEY_NAME NEW_KEY_NAME # 命令用于在新的 key 不存在时修改 key 的名称 。

TYPE KEY_NAME  # 命令用于返回 key 所储存的值的类型。

MIGRATE host port key destination-db timeout [COPY] [REPLACE]
## 将 key 原子性地从当前实例传送到目标实例的指定数据库上，一旦传送成功， key 保证会出现在目标实例上，而当前实例上的 key 会被删除。
## COPY ：不移除源实例上的 key 。

SORT key [BY pattern] [LIMIT offset count] [GET pattern [GET pattern ...]] [ASC | DESC] [ALPHA] [STORE destination]






