#!/usr/bin/env bash
########################################################################################################################
### 索引
# 创建文档 并自动创建索引
curl -XPUT http://localhost:9200/blog/article/1 -d '{
  "title": "New version of Elasticsearch released!",
  "content": "...",
  "tags": ["announce", "elasticsearch", "release"]
}'

# 创建索引
curl -XPUT http://localhost:9200/blog/

# 修改索引的自动创建 -- 通过在elasticsearch.yml配置文件中添加以下指令来关闭自动创建索引
action.auto_create_index: false

# 需要注意的是，action.auto_create_index比看起来要复杂。我们不但可以把它的值设置成false或ture，
# 也可以使用索引的名字模式来指定是否在具有给定名字的索引不存在时自动创建。例如在下面的例子中，允许自动创建以a开头的索引，
# 但以an开头的索引则不允许。其他索引也必须手动创建(因为指令中的-*)
action.auto_create_index: -an*,+a*,-*
# 注意，模式定义的顺序很重要。Elasticsearch检查这些模式直到第一种匹配的模式，所以，如果你将-an*移动到最后，它将不会被使用，
# 因为指令中含有 +a*，所以优先使用+a*。

# 新创建索引的设定 -- 想设置一些配置选项时，也需要手动创建索引，例如设置分片和副本的数量。
curl -XPUT http://localhost:9200/blog/ -d '{
        "settings" : {
            "number_of_shards" : 1,
            "number_of_replicas" : 2
        }
}'

# 删除索引
curl -XDELETE http://localhost:9200/posts

########################################################################################################################
### 映射配置
curl -XPUT http://localhost:9200/blog/?pretty -d '{
  "mappings" : {
    "article": {
      "numeric_detection" : true
    }
  }
}'

curl -XPUT 'http://localhost:9200/blog/' -d '{
    "mappings" : {
      "article" : {
        "dynamic_date_formats" : ["yyyy-MM-dd hh:mm"]
      }
    }
}'

curl -XPUT 'http://localhost:9200/blog/' -d '{
      "mappings" : {
        "article" : {
          "dynamic" : "false",
          "properties" : {
            "id" : { "type" : "string" },
            "content" : { "type" : "string" },
            "author" : { "type" : "string" }
          }
        }
      }
}'

### 索引结构映射
# 在Elasticsearch中，映射在文件中以JSON对象传送。所以，创建一个映射文件来匹配上述需 求，称之为posts.json。其内容如下:
# {
#  "mappings": {
#    "post": {
#      "properties": {
#        "id": {"type":"long", "store":"yes", "precision_step":"0" },
#        "name": {"type":"string", "store":"yes", "index":"analyzed" },
#        "published": {"type":"date", "store":"yes", "precision_step":"0" },
#        "contents": {"type":"string", "store":"no", "index":"analyzed" }
#      }
#    }
#  }
# }
curl -XPOST 'http://localhost:9200/posts' -d @posts.json # 同样，顺利的话，可以看到如下响应{"acknowledged":true}

# 字段 ： "contents": { "type":"string", "store":"yes", "index":"analyzed" }

# 核心类型 string:字符串; number:数字; date:日期; boolean:布尔型; binary:二进制。

# 多字段  "name": { "type": "string", "fields": { "facet": { "type" : "string", "index": "not_analyzed" } } }
# 我们将第一个字段称为name，第二个称为name.facet。当然，你不必在索引的过程中指定两个独立字段，指定一个name字段就足够了。
# Elasticsearch会处理余 下的工作，将该字段的数值复制到多字段定义的所有字段。

# IP地址类型
# Elasticsearch添加了IP字段类型，以数字形式简化IPv4地址的使用。此字段类型可以帮搜索作为IP地址索引的数据、对这些数据排序，并使用IP值做范围查询
# "address" : { "type" : "ip", "store" : "yes" }
{
  "name" : "Tom PC",
  "address" : "192.168.2.123"
}

# token_count类型 token_count字段类型允许存储有关索引的字数信息，而不是存储及检索该字段的文本。它接受与number类型相同的配置选项，
# 此外，还可以通过analyzer属性来指定分析器。
"address_count" : { "type" : "token_count", "store" : "yes" }

# 索引数据
# 为了执行批量请求，Elasticsearch提供了_bulk端点，形式可以是/_bulk，也可以是/index_ name/_bulk，甚至是/index_name/type_name/_bulk。
# 第二种和第三种形式定义了索引名称 和类型名称的默认值。可以在请求的信息行中省略这些属性，Elasticsearch将使用默认值。

curl -XPOST 'localhost:9200/_bulk?pretty' --data-binary @documents.json
# 没必要设置?pretty参数。之前使用这个参数仅仅是为了方便分析命令的响应。在这个例子中，我们在curl中使用--data-binary参数，而不是使用-d，
# 这很重要。这是因为标准的-d参数忽略换行符，正如前面所说的那样，换行符在解析Elasticsearch的批量请求内容时很重要。

# 路由介绍
# 要记住，使用路由时，你仍然应该为与路由值相同的值添加一个过滤器。这是因为，路由值 的数量或许会比索引分片的数量多。
# 因此，一些不同的属性值可以指向相同的分片，如果你忽略 过滤，得到的数据并非是路由的单个值，而是特定分片中驻留的所有路由值。

# 路由参数
# 最简单的方法(但并不总是最方便的一个)是使用路由参数来提供路由值。索引或查询时， 你可以添加路由参数到HTTP，或使用你所选择的客户端库来设置。
curl -XPUT 'http://localhost:9200/posts/post/1?routing=12' -d '{
  "id": "1",
  "name": "Test document",
  "contents": "Test document",
      "userId": "12"
}'

curl -XGET 'http://localhost:9200/posts/_search?routing=12&q=userId:12'
# 可以看到，索引和查询时我们使用相同的路由值。这么做是因为我们知道在索引时设置的属 性值为12，我们想要查询指向同一分片，因此需要使用完全相同的值。

# 路由字段
# 为每个发送到Elasticsearch的请求指定路由值并不方便。事实上，在索引过程中，Elasticsearch 允许指定一个字段，用该字段的值作为路由值。
# 这样只需要在查询时提供路由参数。为此，在类型定义中需要添加以下代码:
"_routing" : { "required" : true, "path" : "userId" }

# 添加路由部分后，整个更新的映射文件将如下所示:
{
  "mappings" : {
  "post" : {
      "_routing" : {
        "required" : true,
        "path" : "userId"
  },
  "properties" : {
        "id" : { "type" : "long", "store" : "yes",
        "precision_step" : "0" },
        "name" : { "type" : "string", "store" : "yes",
        "index" : "analyzed" },
        "contents" : { "type" : "string", "store" : "no",
        "index" : "analyzed" },
        "userId" : { "type" : "long", "store" : "yes",
        "precision_step" : "0" }
  }
}
}
}

# 如果想使用上述映射来创建posts索引，可使用下面的命令来为单个测试文档建立索引:
curl -XPOST 'localhost:9200/posts/post/1' -d '{
      "id":1,
      "name":"New post",
      "contents": "New test post",
      "userId":1234567
}' # Elasticsearch将使用1234567作为索引时的路由值。


