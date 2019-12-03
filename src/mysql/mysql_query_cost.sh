#!/bin/bash
#### 单表访问方法
CREATE TABLE single_table (
    id INT NOT NULL AUTO_INCREMENT,
    key1 VARCHAR(100),
    key2 INT,
    key3 VARCHAR(100),
    key_part1 VARCHAR(100),
    key_part2 VARCHAR(100),
    key_part3 VARCHAR(100),
    common_field VARCHAR(100),
    PRIMARY KEY (id),
    KEY idx_key1 (key1),
    UNIQUE KEY idx_key2 (key2),
    KEY idx_key3 (key3),
    KEY idx_key_part(key_part1, key_part2, key_part3)
) Engine=InnoDB CHARSET=utf8;
# 我们为这个single_table表建立了1个聚簇索引和4个二级索引，分别是：
#   为id列建立的聚簇索引。
#   为key1列建立的idx_key1二级索引。
#   为key2列建立的idx_key2二级索引，而且该索引是唯一二级索引。
#   为key3列建立的idx_key3二级索引。
#   为key_part1、key_part2、key_part3列建立的idx_key_part二级索引，这也是一个联合索引。

#### 访问方法（access method）的概念
# 1.使用全表扫描进行查询
# 2.使用索引进行查询：
#   针对主键或唯一二级索引的等值查询
#   针对普通二级索引的等值查询
#   针对索引列的范围查询
#   直接扫描整个索引

### const级别
# primary key  where匹配条件为常数
SELECT * FROM single_table WHERE id = 1438;
# 唯一索引  where匹配条件为常数，复合唯一索引所有列必须同时都是常数条件
SELECT * FROM single_table WHERE key2 = 3841;
# 对于唯一二级索引来说，查询该列为NULL值的情况比较特殊，比如这样：
SELECT * FROM single_table WHERE key2 IS NULL;
# 因为唯一二级索引列并不限制 NULL 值的数量，所以上述语句可能访问到多条记录，
# 也就是说 上边这个语句不可以使用const访问方法来执行

### ref级别
# 1. 对于普通的二级索引来说，通过索引列进行等值比较
SELECT * FROM single_table WHERE key1 = 'abc';
# 2. 二级索引列值为NULL的情况： 不论是普通的二级索引，还是唯一二级索引，它们的索引列对包含NULL值的数量并不限制，
#    所以我们采用key IS NULL这种形式的搜索条件最多只能使用ref的访问方法，而不是const的访问方法。
SELECT * FROM single_table WHERE key2 IS NULL;
# 3. 对于某个包含多个索引列的二级索引来说，只要是最左边的连续索引列是与常数的等值比较就可能采用ref的访问方法，例如：
SELECT * FROM single_table WHERE key_part1 = 'god like';
SELECT * FROM single_table WHERE key_part1 = 'god like' AND key_part2 = 'legendary';
SELECT * FROM single_table WHERE key_part1 = 'god like' AND key_part2 = 'legendary' AND key_part3 = 'penta kill';
# 但是如果最左边的连续索引列并不全部是等值比较的话，它的访问方法就不能称为ref了，比方说这样：
SELECT * FROM single_table WHERE key_part1 = 'god like' AND key_part2 > 'legendary';

### ref_or_null级别
# 有时候我们不仅想找出某个二级索引列的值等于某个常数的记录，还想把该列的值为NULL的记录也找出来，就像下边这个查询：
SELECT * FROM single_table WHERE key1 = 'abc' OR key1 IS NULL;
# 当使用二级索引而不是全表扫描的方式执行该查询时，这种类型的查询使用的访问方法就称为ref_or_null。

### range级别
# 如果采用二级索引 + 回表的方式来执行的话，那么此时的搜索条件就不只是要求索引列与常数的等值匹配了，而是索引列需要匹配某个或某些范围的值
SELECT * FROM single_table WHERE key2 IN (1438, 6328) OR (key2 >= 38 AND key2 <= 79);
# 此处所说的使用索引进行范围匹配中的 `索引` 可以是聚簇索引，也可以是二级索引。

### index级别
SELECT key_part1, key_part2, key_part3 FROM single_table WHERE key_part2 = 'abc';
# 由于key_part2并不是联合索引idx_key_part最左索引列，所以我们无法使用ref或者range访问方法来执行这个语句。
# 但是这个查询符合下边这两个条件：
#   1.它的查询列表只有3个列：key_part1, key_part2, key_part3，而索引idx_key_part又包含这三个列。
#   2.搜索条件中只有key_part2列。这个列也包含在索引idx_key_part中。
# 也就是说我们可以直接通过遍历idx_key_part索引的叶子节点的记录来比较key_part2 = 'abc'这个条件是否成立，把匹配成功的二级索引记录
# 的key_part1, key_part2, key_part3列的值直接加到结果集中就行了。由于二级索引记录比聚簇索记录小的多（聚簇索引记录要存储所有用户
# 定义的列以及所谓的隐藏列，而二级索引记录只需要存放索引列和主键），而且这个过程也不用进行回表操作，所以直接遍历二级索引比直接遍历
# 聚簇索引的成本要小很多，设计MySQL的大叔就把这种采用遍历二级索引记录的执行方式称之为：index。

### all级别
# 最直接的查询执行方式就是我们已经提了无数遍的全表扫描，对于InnoDB表来说也就是直接扫描聚簇索引，
# 设计MySQL的大叔把这种使用全表扫描执行查询的方式称之为：all。


####### 明确range访问方法使用的范围区间
# 其实对于B+树索引来说，只要索引列和常数使用=、<=>、IN、NOT IN、IS NULL、IS NOT NULL、>、<、>=、<=、BETWEEN、!=（不等于也可以
# 写成<>）或者LIKE操作符连接起来，就可以产生一个所谓的区间。
#  LIKE操作符比较特殊，只有在匹配完整字符串或者匹配字符串前缀时才可以利用索引，具体原因我们在前边的章节中唠叨过了，这里就不赘述了。
# IN操作符的效果和若干个等值匹配操作符`=`之间用`OR`连接起来是一样的，也就是说会产生多个单点区间，比如下边这两个语句的效果是一样的：
 SELECT * FROM single_table WHERE key2 IN (1438, 6328);
 SELECT * FROM single_table WHERE key2 = 1438 OR key2 = 6328;




