### 手把手教你MySQL查询优化分析
# MySQL是关系性数据库中的一种，查询功能强，数据一致性高，数据安全性高，支持二级索引。
# 但性能方面稍逊于非关系性数据库，特别是百万级别以上的数据，很容易出现查询慢的现象。
# 这时候需要分析查询慢的原因，一般情况下是程序员sql写的烂，或者是没有键索引，或者是索引失效等原因导致的。
# 这时候MySQL 提供的 EXPLAIN 命令就尤其重要, 它可以对 SELECT 语句进行分析, 并输出 SELECT 执行的详细信息,
# 以供开发人员针对性优化.而且就在查询语句前加上 Explain 就成:

EXPLAIN SELECT * FROM customer WHERE id < 100;

CREATE TABLE `customer` (
  `id`   BIGINT(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL DEFAULT '',
  `age`  INT(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4

INSERT INTO customer (name, age) VALUES ('a', 1);
INSERT INTO customer (name, age) VALUES ('b', 2);
INSERT INTO customer (name, age) VALUES ('c', 3);
INSERT INTO customer (name, age) VALUES ('d', 4);
INSERT INTO customer (name, age) VALUES ('e', 5);
INSERT INTO customer (name, age) VALUES ('f', 6);
INSERT INTO customer (name, age) VALUES ('g', 7);
INSERT INTO customer (name, age) VALUES ('h', 8);
INSERT INTO customer (name, age) VALUES ('i', 9);

CREATE TABLE `orders` (
  `id`           BIGINT(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id`      BIGINT(20) unsigned NOT NULL DEFAULT 0,  `product_name` VARCHAR(50) NOT NULL DEFAULT '',
  `productor`    VARCHAR(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_product_detail_index` (`user_id`, `product_name`, `productor`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4

INSERT INTO orders (user_id, product_name, productor) VALUES (1, 'p1', 'WHH');
INSERT INTO orders (user_id, product_name, productor) VALUES (1, 'p2', 'WL');
INSERT INTO orders (user_id, product_name, productor) VALUES (1, 'p1', 'DX');
INSERT INTO orders (user_id, product_name, productor) VALUES (2, 'p1', 'WHH');
INSERT INTO orders (user_id, product_name, productor) VALUES (2, 'p5', 'WL');
INSERT INTO orders (user_id, product_name, productor) VALUES (3, 'p3', 'MA');
INSERT INTO orders (user_id, product_name, productor) VALUES (4, 'p1', 'WHH');
INSERT INTO orders (user_id, product_name, productor) VALUES (6, 'p1', 'WHH');
INSERT INTO orders (user_id, product_name, productor) VALUES (9, 'p8', 'TE');


# explain
# mysql> explain select * from customer where id = 1\G
# *************************** 1. row ***************************
#            id: 1
#   select_type: SIMPLE
#         table: customer
#    partitions: NULL
#          type: const
# possible_keys: PRIMARY
#           key: PRIMARY
#       key_len: 8
#           ref: const
#          rows: 1
#      filtered: 100.00
#         Extra: NULL
# 1 row in set, 1 warning (0.00 sec)

### explain 查询结果各列的含义如下:
# id: SELECT 查询的标识符. 每个 SELECT 都会自动分配一个唯一的标识符.
# select_type: SELECT 查询的类型.
# table: 查询的是哪个表
# partitions: 匹配的分区
# type: join 类型
# possible_keys: 此次查询中可能选用的索引
# key: 此次查询中确切使用到的索引.
# ref: 哪个字段或常数与 key 一起被使用
# rows: 显示此查询一共扫描了多少行. 这个是一个估计值.
# filtered: 表示此查询条件所过滤的数据的百分比
# extra: 额外的信息

### 接下来我们来重点看一下比较重要的几个字段
## 1.select_type
# SIMPLE —— 简单的select 查询，查询中不包含子查询或者UNION
# PRIMARY —— 查询中若包含任何复杂的子查询，最外层查询则被标记为primary
# UNION —— 表示此查询是 UNION 的第二或随后的查询
# DEPENDENT UNION —— UNION 中的第二个或后面的查询语句, 取决于外面的查询
# UNION RESULT —— 从UNION表获取结果的select结果
# DERIVED —— 在from列表中包含的子查询被标记为derived（衍生）MySQL会递归执行这些子查询，把结果放在临时表里。
# SUBQUERY —— 在select或where 列表中包含了子查询
# DEPENDENT SUBQUERY —— 子查询中的第一个 SELECT, 取决于外面的查询. 即子查询依赖于外层查询的结果.
# 最常见的查询类别应该是 SIMPLE 了, 比如当我们的查询没有子查询, 也没有 UNION 查询时, 那么通常就是 SIMPLE 类型。
