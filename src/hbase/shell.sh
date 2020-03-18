#!/usr/bin/env bash

#### hbase shell 使用

### 开启shell
$HBASE_HOME/bin/hbase shell

# 查看集群状态
status
status 'simple'
status 'summary'
status 'detailed'

# 查看版本verison
version
# 查看当前用户
whoame
# 查看表
list
# 表属性
describe 'test_table'

### 表
create 'test_table', 'column_family_001' # 创建表并增加一个列簇
# 增加列簇-- 生产环境最好先停用（disable）这个表
alter 'test_table', 'column_family_002'
alter 'test_table', 'column_family_003'

# 插入数据
put 'test_table', 'row_001', 'column_family_001:name', 'zhangsan'
put 'test_table', 'row_001', 'column_family_001:age', '23'
put 'test_table', 'row_001', 'column_family_001:address', 'anhui province'
put 'test_table', 'row_001', 'column_family_001:school', 'beijing university', 222222222222

# 查询表数据
scan 'test_table'                                                            # 只会显示最大时间戳的数据，其他数据存在并未丢失
scan 'test_table',{VERSION= >5}                                              # 只会显示多个版本数据
get 'test_table', 'row_001'                                                  # 获取整行数据
get 'test_table', 'row_001', 'column_family_001:name'                        # 获取单元格数据
get 'test_table', 'row_001', {COLUMN= >'column_family_001:name',VERSION= >5} # 获取单元格多个版本数据

# 删除数据
delete 'test_table', 'row_001', 'column_family_001:name'
delete 'test_table', 'row_001', 'column_family_001:name', 2222222222222 # 删除这个版本之前的所有数据

# 删除整行数据
deleteall 'test_table', 'row_001'

# 停用表
disable 'test_table'
scan 'test_table'
is_enabled 'test_table'

# 删除表
drop 'test_table'
exists 'test_table'
list

# 列出所有过滤器
show_filters

# 获取表并赋值到变量中
variable_001=get_table 'test_table'

