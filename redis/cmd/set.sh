#!/usr/bin/env bash

# Redis 的 Set 是 String 类型的无序集合。集合成员是唯一的，这就意味着集合中不能出现重复的数据。
# Redis 中集合是通过哈希表实现的，所以添加，删除，查找的复杂度都是 O(1)。
# 集合中最大的成员数为 2^32 - 1 (4294967295, 每个集合可存储40多亿个成员)。

SADD key member1 [member2] ...  # 向集合添加一个或多个成员

SCARD key   # 获取集合的成员数

SDIFF key1 [key2]...  # 返回给定所有集合的差集

SDIFFSTORE destination key1 [key2]...  # 返回给定所有集合的差集并存储在 destination 中

SINTER key1 [key2]...  # 返回给定所有集合的交集

SINTERSTORE destination key1 [key2]... # 返回给定所有集合的交集并存储在 destination 中

SISMEMBER key member  # 判断 member 元素是否是集合 key 的成员

SMEMBERS key   # 返回集合中的所有成员

SMOVE source destination member  # 将 member 元素从 source 集合移动到 destination 集合

SPOP key  # 移除并返回集合中的一个随机元素

SRANDMEMBER key [count]  # 返回集合中一个或多个随机数

SREM key member1 [member2]... # 移除集合中一个或多个成员

SUNION key1 [key2]...  # 返回所有给定集合的并集

SUNIONSTORE destination key1 [key2]...  # 所有给定集合的并集存储在 destination 集合中

SSCAN key cursor [MATCH pattern] [COUNT count]  # 迭代集合中的元素

# exp:
# SADD set_key key1 key2 key3 key4
# SSCAN set_key 0 MATCH key* COUNT 2
# 可以看到sscan的返回结果，有两部分，第一部分是一个数字，基本是0，有时候是正数。第二部分是结果。
# 其实第一部分代表一个游标。scan就是以游标为基础，每次使用scan(包括sscan)，以游标0开始，然后命令会返回一个新的游标；如果新的游标不是0，表示遍历还没有结束，要使用新的游标作为参数，继续输入获得后面的结果。
# 比如下面这个 count 1的时候，遍历没有结束，就会返回非0的游标。后续要使用新的游标来运行命令。

# > smembers myset
# 1) "one"
# 2) "two"
# > sscan myset 0 match * count 1
# 1) "2"
# 2) 1) "one"
# > sscan myset 2 match * count 1
# 1) "3"
# 2) 1) "two"
# > sscan myset 3 match * count 1
# 1) "0"
# 2) (empty list or set)
