#!/usr/bin/env bash

### es 查询：基本查询和复合查询
## 1.基本查询，如词条查询用于查询实际数据
## 2.复合查询，如布尔查询，可以合并多个查询
# 然而，这不是全部。除了这两种类型的查询，你还可以用过滤查询，根据一定的条件缩小查 询结果。不像其他查询，筛选查询不会影响得分，而且通常非常高效。
curl -XPOST 'localhost:9200/library'
curl -XPUT 'localhost:9200/library/book/_mapping' -d @mapping.json
curl -s -XPOST 'localhost:9200/_bulk' --data-binary @query_documents.json

## 1.简单查询
# 查询Elasticsearch最简单的办法是使用URI请求查询，1.5节已经讨论过。例如，为了搜索title 字段中的crime一词，使用下面的命令:
curl -XGET 'localhost:9200/library/book/_search?q=title:crime&pretty=true'

# 这种查询方式很简单，但比较局限。如果从Elasticsearch的查询DSL的视点来看，上面的查询 是一种query_string查询，
# 它查询title字段中含有crime一词的文档，可以这样写:
curl -XGET 'localhost:9200/library/book/_search?pretty=true' -d '{
 "query":{
    "query_string" : { "query" : "title:crime" }
  }
}'
# 可以看到，我们使用请求体(-d参数)把整个JSON格式的查询发到Elasticsearch。 pretty=true参数让Elasticsearch以更容易阅读的方式返回响应。
# 上述命令的响应如下所示:
# {
#  "took" : 1,
#  "timed_out" : false,
#  "_shards" : { "total" : 5,"successful" : 5, "failed" : 0 },
#  "hits" : {
#  "total" : 1,
#  "max_score" : 0.15342641,
#  "hits" : [
#    {
#      "_index" : "library",
#      "_type" : "book",
#      "_id" : "4",
#      "_score" : 0.15342641, "_source" :
#        {
#          "title": "Crime andPunishment",
#          "otitle":"Преступлéние и наказáние",
#          "author": "Fyodor Dostoevsky",
#          "year": 1886,
#          "characters": ["Raskolnikov", "Sofia Semyonovna Marmeladova"],
#          "tags": [],
#          "copies": 0,
#          "available" : true
#        }
#    }
#  ]
#  }
# }

# 使用过滤器

curl -XGET localhost:9200/library/book/_search?pretty -d @query.json
# 这表明两种形式是等效的。其实不对，因为它们应用过滤和搜索的顺序是不同的。在第一种 情况下，过滤器应用到查询所发现的所有文档上。
# 第二种情况下，过滤发生在在运行查询之前， 性能更好。如前所述，过滤器很快，所以filtered查询效率更高。

# 1. 范围过滤器:gt:大于,lt:小于,gte:大于或等于,lte:小于或等于
#{
#      "post_filter" : {
#        "range" : {
#          "year" : {
#            "gte": 1930,
#            "lte": 1990
#          }
#        }
#      }
#}

# 2. exists过滤器
# 3. missing过滤器
# 4. 脚本过滤器 {"post_filter" : {"script" : {"script" : "now - doc['year'].value > 100", "params" : {"now" : 2012} }} }}
# 5. 类型过滤器:类型过滤器专门用来限制文档的类型
# 6. 限定过滤器:限定过滤器限定单个分片返回的文档数目。不要把它跟size参数混在一起。
# 7. 标识符过滤器:需要过滤成若干具体的文档时，可以使用标识符过滤器。
# 8. 如果还不够: Elasticsearch支持下列专用过滤器:
#    bool过滤器;
#    geo_shape过滤器;
#    has_child过滤器;
#    has_parent过滤器;
#    ids过滤器;
#    indices过滤器;
#    match_all过滤器;
#    nested过滤器;
#    prefix过滤器;
#    range过滤器;
#    regexp过滤器;
#    term过滤器;
#    terms过滤器。
# 9. 组合过滤器: 第一个选择是使用bool过滤器，第二种选择是使用and、or和not过滤器。
# 10. 命名过滤器: 设置过滤器可能很复杂，所以有时候，如果知道哪些过滤器用来决定查询应该返回哪些文档，无疑是很有帮助的。
# 幸好，可以给每个过滤器命名，名字将随着匹配文档返回。来看看它是如何工作的。

