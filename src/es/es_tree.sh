#!/usr/bin/env bash

## 扩展索引结构
# 1 数据结构
curl -XPUT 'localhost:9200/path' -d '{
      "settings" : {
        "index" : {
          "analysis" : {
            "analyzer" : {
              "path_analyzer" : { "tokenizer" : "path_hierarchy" }
              }
            }
          }
      },
    "mappings" : {
        "category" : {
        "properties" : {
          "category" : {
          "type" : "string",
          "fields" : {
             "name" : { "type" : "string", "index" : "not_analyzed" },
          }
        }
      } }
  }
}'

# 2.索引非扁平结构
# 数据是structured_data.json 和 mapping 是 structured_mapping.json
# 创建索引
curl -XPUT 'localhost:9200/library'
# 接着，使用以下命令行，将映射发送至book类型:
curl -XPUT 'localhost:9200/library/book/_mapping' -d @structured_mapping.json
# 现在，可使用以下命令行索引我们的示例数据:
curl -XPOST 'localhost:9200/library/book/1' -d @structured_data.json

# 动态还是非动态
# Elasticsearch是无模式的，这意味着不必创建前面的映射就可索引数据。Elasticsearch的动态行为默认是打开的，但可能想在索引的某些部分把它关掉。
# 为此，可为指定字段增加属性dynamic，将值设置为false，该属性应该设置在与非动态对象的type属性相同的级别上。
# 如果我们希望对象author和name为非动态，应该将映射文件的相关部分修 改成类似下面这样:
#"author" : {
#  "type" : "object",
#  "dynamic" : false,
#  "properties" : {
#    "name" : {
#      "type" : "object",
#      "dynamic" : false,
#      "properties" : {
#        "firstName" : {"type" : "string", "index" : "analyzed"},
#        "lastName" : {"type" : "string", "index" : "analyzed"} }
#    }
#  }
#}
# 你也可以在elasticsearch.yml 配置文件中添加index.mapper.dynamic属性，将值设置为false，关掉动态映射功能。

## 使用嵌套对象
# 使用父子关系
# 索引结构和数据索引
# 1. 父文档映射：在父文档中，name是我们需要的唯一字段。因此，在shop索引中创建cloth类型，执行如下命令
curl -XPOST 'localhost:9200/shop'
curl -XPUT 'localhost:9200/shop/cloth/_mapping' -d '{
      "cloth" : {
        "properties" : {
          "name" : {"type" : "string"}
        }
      }
}'
# 2. 子文档映射：为创建子文档映射，要在_parent属性中添加父类型的名称，在我们的示例中为cloth。因此，创建类型variation的命令行将如下所示：
curl -XPUT 'localhost:9200/shop/variation/_mapping' -d '{
      "variation" : {
        "_parent" : { "type" : "cloth" },
        "properties" : {
          "size" : {"type" : "string", "index" : "not_analyzed"},
          "color" : {"type" : "string", "index" : "not_analyzed"}
        }
      }
}'
# 3. 父文档 ：我们指定的文档标识符为1
curl -XPOST 'localhost:9200/shop/cloth/1' -d '{
      "name" : "Test shirt"
}'
# 4. 子文档
# 为索引子文档，需要使用parent参数提供父文档的相关信息，将该参数设置为父文档的标识符。所以，为索引父文档中的两个子文档，执行下面的命令:
curl -XPOST 'localhost:9200/shop/variation/1000?parent=1' -d '{
  "color" : "red",
  "size" : "XXL"
}'

# 查询子文档中的数据：查询很简单。类型has_child告知Elasticsearch我们想在子文档中搜索。
curl -XGET 'localhost:9200/shop/_search?pretty' -d '{
      "query" : {
        "has_child" : {
          "type" : "variation",
          "query" : {
            "bool" : {
              "must" : [
                { "term" : { "size" : "XXL" } },
                { "term" : { "color" : "red" } }
              ]
} }
} }
}'
#  查询父文档中的数据 ： 如果想要返回与父文档中指定数据匹配的子文档，可使用类似于has_child的查询:has_parent。
curl -XGET 'localhost:9200/shop/_search?pretty' -d '{
      "query" : {
        "has_parent" : {
          "parent_type" : "cloth",
          "query" : {
            "term" : { "name" : "test" }
          }
} }
}'
## 父子关系和过滤
# 如果想要将父子查询作为过滤器使用，可以用过滤器has_child和has_parent，它们具备了与has_child和has_parent查询相同的功能。
# 实际上，Elasticsearch将那些过滤器封装为常数得分查询，使其可作为查询使用。

## 性能考虑
# 1.使用Elasticsearch父子的功能时，必须注意它的性能影响。需要记住的第一件事是父子文档 需要存储在相同的分片中，查询才能够工作。
# 如果单一父文档有大量的子文档，可能导致分片上的文档数量不平均。因此，其中的一个节点的性能会降低，造成整个查询速度变慢。
# 另外，请记住，比起查询无任何关联的文档，父子查询的速度较慢。
# 2.第二个非常重要的事情是，执行has_child等查询时，Elasticsearch需要预加载并缓存文档 标识符。
# 这些标识符将存储在内存中，必须确保Elasticsearch有足够的内存。否则，你将得到 OutOfMemory异常，节点或整个集群将无法运作。

## 使用更新API修改索引结构
# 1.映射
# 假设我们的users索引有以下映射，存储于user.json文件中
# 现在，让我们创建一个名为users的索引，并使用上面的映射创建自己的类型。为此，运行以下命令:
curl -XPOST 'localhost:9200/users'
curl -XPUT 'localhost:9200/users/user/_mapping' -d @user.json

# 2.添加一个新字段
# 为了说明如何为映射添加新字段，我们假设要为每个存储的用户添加一个电话号码。
# 为此，需要将HTTPPUT命令发送到带有合适主体的/index_name/type_name/_mappingREST端点，该主体中包含我们的新字段。
# 例如，为添加phone字段，执行以下命令:
curl -XPUT 'http://localhost:9200/users/user/_mapping' -d '{
      "user" : {
        "properties" : {
          "phone" : {"type" : "string", "store" : "yes", "index" : "not_analyzed"}
        }
      }
}'
# 同样，如果一切正常，新字段便添加到我们的索引结构中去了。为了确保一切正常，可以运 行HTTP GET请求到_mapping端点;
# Elasticsearch将返回适当的映射。在索引users中获得user 类型映射的示例命令如下所示:
curl -XGET 'localhost:9200/users/user/_mapping?pretty'
# 在现有类型中添加新字段后，需要再次对所有文档进行索引，因为Elasticsearch不会自动更新。
# 这很关键，可以使用初始数据源或从_source字段中获得初始数据并再次索引。

# 3.修改字段
# 现在，我们的索引结构包含两个字段:name和phone。我们索引了一些数据，但之后又决定搜索phone字段，并希望更改index属性，
# 从not_analyzed改为analyzed，为此，执行以下命令:
curl -XPUT 'http://localhost:9200/users/user/_mapping' -d '{
      "user" : {
        "properties" : {
          "phone" : {"type" : "string",
      } }
}'
# 返回error
# 这是因为无法将not_analyzed字段更改为analyzed。不仅如此，在大部分情况下字段映 射是无法更新的。这是好事，因为如果我们可以更改这样的设置，
# 会让Elasticsearch和Lucene混 乱。假设已经有很多文档带有设置为not_analyzed的phone字段，将这些设置更改为 analyzed，
# Elasticsearch将无法更改已索引的文档，但已经分析的查询将以不同的逻辑处理，那 么我们就无法正确查找数据。

## 我们在此将提及一些操作，举例说明哪些是禁止的，哪些是允许的。如下修改是安全的:
# 增加新的类型定义;
# 增加新的字段;
# 增加新的分析器。
## 而以下修改是不允许或是无法实现的:
# 更改字段类型(如将文本改为数字);
# 更改“存储到”字段为不存储，反之亦然;
# 更改索引属性的值;
# 更改已索引文档的分析器。

# 如果你想忽略冲突并设置新映射，可设置ignore_conflicts的参数值为 true，Elasticsearch将会重写映射。带有额外参数的命令行如下:
curl -XPUT 'http://localhost:9200/users/user/_mapping?ignore_conflicts=true' -d '...'
