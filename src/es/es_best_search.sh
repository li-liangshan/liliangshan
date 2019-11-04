#!/usr/bin/env bash

## 5 更好的搜索
#  Apache Lucene评分;
#  使用Elasticsearch的脚本功能;
#  对不同语言的数据索引和搜索;
#  使用不同查询来影响返回文档的得分;  使用索引时加权;
#  具有相同意思的词;
#  检查为什么特定文档被返回;
#  检查得分计算细节。

# 为使用这个映射文件创建一个叫docs的简单索引，执行如下命令:
curl -XPUT 'localhost:9200/docs' -d @search_mappings.json

# 用识别语言查询
# 第一种情况是确定了查询语言。假设识别的语言是英语，我们知道英语与english分析器匹配。在这种情况下，查询如下所示:
curl -XGET 'localhost:9200/docs/_search?pretty=true ' -d '{
      "query" : {
        "match" : {
          "content" : {
            "query" : "documents",
            "analyzer" : "english"
          }
} }
}'

# 用未知语言查询
# 假设不知道用户查询使用的语言。此时，不能使用由lang字段指定的分析器，因为我们不想用一个特定于语言的分析器来分析查询。
# 在这种情况下，用标准的简单分析器，发送查询到contents.default字段，而不是content字段。查询如下所示:
curl -XGET 'localhost:9200/docs/_search?pretty=true ' -d '{
  "query" : {
    "match" : {
      "content.default" : {
        "query" : "documents",
        "analyzer" : "simple"
      }
    }
  }
}'

# 组合查询
# 为了对完美匹配默认分析器的文档额外加权，可以把上述两个查询用bool查询组合起来:
# 返回的文档至少必须匹配一个定义的查询。如果两者都匹配，文档将具有更高的分数值，并 在结果中放置得更高。
curl -XGET 'localhost:9200/docs/_search?pretty=true ' -d '
{
  "query": {
    "bool": {
      "minimum_should_match": 1,
      "should": [
        {
          "match": {
            "content": {
              "query": "documents",
              "analyzer": "english"
            }
          }
        },
        {
          "match": {
            "content.default": {
              "query": "documents",
              "analyzer": "simple"
            }
          }
        }
      ]
    }
  }
}'
