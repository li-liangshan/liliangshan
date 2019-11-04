#!/usr/bin/env bash

# create 索引不存在时会自动创建
curl -XPUT http://localhost:9200/blog/article/1 -d '{
  "title": "New version of Elasticsearch released!",
  "content": "...",
  "tags": ["announce", "elasticsearch", "release"]
}'

# create
curl -XPOST http://localhost:9200/blog/article/1 -d '{
  "title": "New version of Elasticsearch released!",
  "content": "Version 1.0 released today!",
  "tags": ["announce", "elasticsearch", "release"]
}'

# query
curl -XGET http://localhost:9200/blog/article/1?pretty

# 更新索引中的文档是一项更复杂的任务。在内部，Elasticsearch必须首先获取文档，从 _source属性获得数据，删除旧的文件，
# 更改_source属性，然后把它作为新的文档来索引。它 如此复杂，因为信息一旦在Lucene的倒排索引中存储，就不能再被更改。
# Elasticsearch通过一个 带_update参数的脚本来实现它。这样就可以做比简单修改字段更加复杂的文档转换。下面用简 单的例子看看的工作原理。

# update
curl -XPOST http://localhost:9200/blog/article/1/_update -d '{
  "script": "ctx._source.content = \" new content \""
}'

# 新增字段
curl -XPOST http://localhost:9200/blog/article/1/_update -d '{
  "script": "ctx._source.counter = 1",
  "upsert": {
    "counter": 0
  }
}'

#curl -XDELETE http://localhost:9200/blog/article/1

# 版本控制，乐观锁
#curl -XDELETE http://localhost:9200/blog/article/1?version=1

# 使用URI请求查询来搜索
curl -XPOST http://localhost:9200/books/es/1 -d '{"title":"Elasticsearch Server", "published": 2013}'
curl -XPOST http://localhost:9200/books/es/2 -d '{"title":"Mastering Elasticsearch", "published": 2013}'
curl -XPOST http://localhost:9200/books/solr/1 -d '{"title":"Apache Solr 4 Cookbook", "published": 2012}'

# 可以通过运行以下命令映射API
curl -XGET http://localhost:9200/books/_mapping?pretty

# URI请求
curl -XGET http://localhost:9200/books/_search?pretty
curl -XGET http://localhost:9200/books,clients/_search?pretty # 如果还有另一个索引叫clients，也可对这两个索引执行一个查询

# 还可以省略索引和类型来搜索所有索引。例如，以下命令将搜索集群中的所有数据
curl -XGET http://localhost:9200/_search?pretty

# 假设想找到books索引中title字段包含elasticsearch一词的所有文档
curl -XGET http://localhost:9200/books/_search?pretty&q=title:elasticsearch

