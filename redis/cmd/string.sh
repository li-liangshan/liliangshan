#!/usr/bin/env bash

SET key value

GET key

GETRANGE KEY_NAME start end

GETSET key value # 命令用于设置指定 key 的值，并返回 key 的旧值。

GETBIT key offset # 命令用于对 key 所储存的字符串值，获取指定偏移量上的位(bit)。

MGET key1, key2, key3 ... # 获取所有(一个或多个)给定 key 的值。

SETBIT key offset value # 对 key 所储存的字符串值，设置或清除指定偏移量上的位(bit)。

SETEX key seconds value # 将值 value 关联到 key ，并将 key 的过期时间设为 seconds (以秒为单位)。

SETNX key value # 只有在 key 不存在时设置 key 的值。

SETRANGE key offset value # 用 value 参数覆写给定 key 所储存的字符串值，从偏移量 offset 开始。

STRLEN key  # 返回 key 所储存的字符串值的长度。

MSET key value [key value ...] # 同时设置一个或多个 key-value 对。

MSETNX key value [key value ...] # 同时设置一个或多个 key-value 对，当且仅当所有给定 key 都不存在。

PSETEX key milliseconds value # 这个命令和 SETEX 命令相似，但它以毫秒为单位设置 key 的生存时间，而不是像 SETEX 命令那样，以秒为单位。

INCR key # 将 key 中储存的数字值增一。

INCRBY key increment # 将 key 所储存的值加上给定的增量值（increment）。

INCRBYFLOAT key increment # 将 key 所储存的值加上给定的浮点增量值（increment） 。

DECR key  # 将 key 中储存的数字值减一。

DECRBY key decrement # key 所储存的值减去给定的减量值（decrement） 。

APPEND key value # 如果 key 已经存在并且是一个字符串， APPEND 命令将指定的 value 追加到该 key 原来值（value）的末尾。

BITCOUNT key [start] [end]
# 一般情况下，给定的整个字符串都会被进行计数，通过指定额外的 start 或 end 参数，可以让计数只在特定的位上进行。
# start 和 end 参数的设置和 GETRANGE 命令类似，都可以使用负数值：比如 -1 表示最后一个位，而 -2 表示倒数第二个位，以此类推。
# 不存在的 key 被当成是空字符串来处理，因此对一个不存在的 key 进行 BITCOUNT 操作，结果为 0 。



