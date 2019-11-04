#!/usr/bin/env bash

### 深入Elasticsearch集群
# 在elasticsearch.yml配置文件中添加如下属性: 请注意，如果不设置的话，node.master和node.data默认都为true。
## 1.主节点: 为设置节点不保存数据，而只做主节点
node.master: true
node.data: false
## 2.数据节点: 节点设置成只保存数据
node.master: false
node.data: true

## 3.脑裂
# 为了防止脑裂发生，Elasticsearch提供了discovery.zen.minimum_master_nodes属性。
# 该属性定义的是为了形成一个集群，有主节点资格并互相连接的节点的最小数目。
# 如果把discovery.zen.minimum_master_nodes属性设置为所有可用节点个数加1的 50%

## 4.设置集群名
# 如果我们不在elasticsearch.yml文件设置cluster.name属性，Elasticsearch将使用默认值: elasticsearch。
# 这不见得很好，因此建议你设置cluster.name属性为你想要的名字。如果 你想在一个网络中运行多个集群，也必须设置cluster.name属性，
# 否则，将导致不同集群的所有节点都连接在一起。

### 发现的类型
# 默认在没有安装额外插件的情况下，Elasticsearch允许使用zen发现，它提供了多播和单播发现。
# 在计算机网络术语中，多播(http://en.wikipedia.org/wiki/Multicast)是指在单个传输中将消息传递到一组计算机中。
# 单播(http://en.wikipedia.org/wiki/Unicast)指的是一次只通过网络传输单条消息到单个主机上。

## 1.配置多播
# 多播是zen发现的默认方法。除了常见的设置(很快就会讨论到)外，我们还可以控制以下四个属性：
# discovery.zen.ping.multicast.group:用于多播请求的群组地址，默认为224.2.2.4
# discovery.zen.ping.multicast.port:用于多播通信的端口号，默认为54328
# discovery.zen.ping.multicast.ttl:多播请求被认为有效的时间，默认为3秒
# discovery.zen.ping.multicast.address:Elasticsearch应该绑定的地址。默认为null，意味着Elasticsearch将尝试绑定到操作系统可见的所有网络接口。

# 要禁用多播，应在elasticsearch.yml 文件中添加discovery.zen.ping.multicast.enabled属性，并且把值设为false

## 2.配置单播
# 因为单播的工作方式，我们需要指定至少一个接收单播消息的主机。为此，在elasticsearch.yml 文件中添加discovery.zen.ping.unicast.hosts属性。
# 基本上，我们应该在discovery.zen. 7 ping.unicast.hosts属性中指定所有形成集群的主机。
# 指定所有主机不是必须的，只需要提供足够多的主机以保证最少有一个能工作。如果希望指定192.168.2.1、192.168.2.2和192.168.2.3 主机，
# 可以用下面的方法来设置上述属性:
discovery.zen.ping.unicast.hosts: 192.168.2.1:9300,192.168.2.2:9300,192.168.2.3:9300
# 你也可以定义一个Elasticsearch可以使用的端口范围，例如，从9300到9399端口，指定以下命令行:
discovery.zen.ping.unicast.hosts: 192.168.2.1:[9300-9399],192.168.2.2:[9300-9399], 192.168.2.3:[9300-9399]
# 请注意，主机之间用逗号隔开，并指定了预计用于单播消息的端口。使用单播时，总是设置discovery.zen.ping.multicast.enabled为false

## 3.节点的ping设置
# 除了刚刚讨论的设置，还可以控制或改变默认的ping设置。ping是一个节点间发送的信号，用来检测它们是否还在运行以及可以响应。
# 主节点会ping集群中的其他节点，其他节点也会ping主节点。可以设置下面的属性：
# discovery.zen.fd.ping_interval:该属性默认为1s(1秒钟)，指定了节点互相ping的时间间隔
# discovery.zen.fd.ping_timeout:该属性默认为30s(30秒钟)，指定了节点发送ping信息后等待响应的时间，超过此时间则认为对方节点无响应
# discovery.zen.fd.ping_retries:该属性默认为3，指定了重试次数，超过此次数 则认为对方节点已停止工作

### 时光之门与恢复模块
# 除了我们的索引和索引里面的数据，Elasticsearch还需要保存类型映射和索引级别的设置等 元数据。
# 此信息需要被持久化到别的地方，这样就可以在群集恢复时读取。这就是为什么 Elasticsearch引入了时光之门模块。
# 你可以把它当做一个集群数据和元数据的安全的避风港。你每次启动群集，所有所需数据都从时光之门读取，当你更改你的集群，它使用时光之门模块保存。

## 1.时光之门
# 为了设置我们希望使用的时光之门类型，需要在elasticsearch.yml配置文件中添加gateway.type属性，并设置为local。
# 目前，Elasticsearch推荐使用本地时光之门类型(gateway.type 设为local)，这也是默认值。过去有其他时光之门类型(比如fs、hdfs和s3)，
# 但已被弃用，将在未来的版本中删除。

## 2.恢复控制
# 除了选择时光之门类型以外，Elasticsearch允许配置何时启动最初的恢复过程。恢复是初始 化所有分片和副本的过程，从事务日志中读取所有数据，
# 并应用到分片上。基本上，这是启动 Elasticsearch所需的一个过程。
# 假设有一个由10个Elasticsearch节点组成的集群。应该通知Elasticsearch我们的节点数目，设置gateway.expected_nodes属性为10。
# 我们告知Elasticsearch有资格来保存数据且可以被选为 主节点的期望节点数目。集群中节点的数目等于gateway.expected_nodes属性值时，
# Elasticsearch将立即开始恢复过程。也可以在8个节点之后开始恢复，设置gateway.recover_after_nodes属性为8。
# 可以将它设置为任何我们想要的值，但应该把它设置为一个值以确保集群状态快照的最新版本可用，一 般在大多数节点可用时开始恢复。

# 然而，还有一件事:我们希望gateway在集群形成后的10分钟以后开始恢复，因此设置gateway.recover_after_time 属性为10m 。
# 这个属性告诉gateway模块 ，在gateway.recover_after_nodes属性指定数目的节点形成集群之后，需要等待多长时间再开始恢复。
# 如果我们知道网络很慢，想让节点之间的通信变得稳定时，可能需要这样做。

# 上述属性值都应该设置在elasticsearch.yml配置文件中，如果想设置上面的值，则最终在文件 中得到下面的片段:
gateway.recover_after_nodes: 8
gateway.recover_after_time: 10m
gateway.expected_nodes: 10

# 额外的gateway恢复选项:
# 1. gateway.recover_after_master_nodes:这个属性跟gateway_recover_after_nodes属性类似。
#    它指定了多少个有资格成为主节点的节点在集群中出现时才开始启动恢复，而不是指定所有节点。
# 2. gateway.recover_after_data_nodes:这个属性也跟gateway_recover_after_nodes属性类似。它指定了多少个数据节点在集群中出现时才开始启动恢复。
# 3. gateway.expected_master_nodes:这个属性跟gateway.expected_nodes属性类似，它指定了希望多少个有资格成为主节点的节点出现，而不是所有的节点。
# 4. gateway.expected_data_nodes:这个属性也跟gateway.expected_nodes属性类 似，它指定了你期望出现在集群中的数据节点的个数。

### 为高查询和高索引吞吐量准备Elasticsearch集群
## 1.过滤器缓存
# 过滤器缓存负责缓存查询中使用到的过滤器。你可以从缓存中飞快地获取信息。如果设置得当，它将有效地提高查询速度，尤其是那些包含已经执行过的过滤器的查询。
# --> Elasticsearch包含两种类型的过滤器缓存:节点过滤器缓存(默认)和索引过滤器缓存。

# 节点过滤器缓存: 点过滤器缓存被分配在节点上的所有索引共享，可以配置成使用特定大小的内存，或分配给 Elasticsearch总内存的百分比。
# 为了设置这个值，应该包含indices.cache.filter.size这个 节点属性值，并设置成需要的大小或百分比。

## 2.字段数据缓存和断路器

# 字段数据缓存
# 字段数据缓存是Elasticsearch缓存的一部分，主要用于当查询对字段执行排序或切面时。Elasticsearch把用于该字段的数据加载到内存，
# 以便基于每个文档快速访问这些值。构建这些字 段数据缓存是昂贵的，所以最好有足够的内存，以便缓存中的数据一旦加载就留在缓存中。
# 允许用于字段数据缓存的内存大小可以用indices.fielddata.cache.size属性来控制。 可以把它设置为绝对值(例如2 GB)
# 或者分配给Elasticsearch实例的内存百分比(例如40%)。请 注意，这些值是节点级别，而不是索引级别的。为其他条目丢弃部分缓存会导致查询性能变差，
# 所以建议要有足够的物理内存。此外请记住，默认情况下，字段数据缓存的大小是无限的，所以 如果我们不小心，会导致集群的内存爆炸。

# 我们还可以控制字段数据缓存的过期时间，同样，默认情况下字段数据缓存永远不过期。可以使用indices.fielddata.cache.expire属性来控制，
# 将其设置为最大的不活动时间。例如，将它设置为10m将导致缓存不活动10分钟后过期。记住重建字段数据缓存是非常昂贵的，一般情况下，你不应该设置过期时间。

# 断路器
# 字段数据断路器(field data circuit breaker)允许估计一个字段加载到缓存所需的内存。利用它，可以通过抛出异常来防止一些字段加载到内存中。
# Elasticsearch有两个属性来控制断路器的 行为。第一个是indices.fielddata.breaker.limit属性，默认值为80%，可以使用集群的
# 更新设置API来动态地修改它。这意味着，当查询导致加载字段的值所需的内存超过了Elasticsearch进程中可用堆内存的80%时，将引发一个异常。
# 第二个属性是indices.fielddata.breaker.overhead，默认为1.03，它定义了用来与原始估计相乘的一个常量。

## 3.存储模块
# Elasticsearch中的存储模块负责控制如何写入索引数据。我们的索引可以完全存储在内存或者一个持久化磁盘中。
# 纯内存的索引极快但不稳定，而基于磁盘的索引慢一些，但可容忍故障。
# 利用index.store.type属性，可以指定使用哪种存储类型，可用的选项包括下面这些:
# 1.simplefs:这是基于磁盘的存储，使用随机文件来访问索引文件。它对并发访问的性能 不够好，因此不建议在生产环境使用。
# 2.niofs:这是第二个基于磁盘的索引存储，使用Java NIO类来访问索引文件。它在高并发环境提供了非常好的性能，
#   但不建议在Windows平台使用，因为Java在这个平台的实现有bug。
# 3.mmapfs:这是另一个基于磁盘的存储，它在内存中映射索引文件(对于mmap，请参阅 http://en.wikipedia.org/wiki/Mmap)。
#   这是64位系统下的默认存储，因为为索引文件提供了 操作系统级别的缓存，因此它的读操作更快。你需要确保有足够数量的虚拟地址空间，
#   但在64位系统下，这不是问题.
# 4.memory:这将把索引存在内存中。请记住你需要足够的物理内存来存储所有的文档，否则Elasticsearch将失败.

## 4.索引缓冲和刷新率
# 当说到索引时，Elasticsearch允许你为索引设置最大的内存数。indices.memory. index_buffer_size属性可以控制在一个节点上，
# 所有索引的分片共拥有的最大内存大小(或 者最大堆内存的百分比)。例如，把该属性设置为20%，将告诉Elasticsearch提供最大堆大小20% 的内存给索引缓冲。
# 此外，还有个indices.memory.min_shard_index_buffer_size属性，默认为4mb，允 许为每个分片设置最小索引缓冲。

# 索引刷新率
# index.refresh_interval属性，它指定在索引上，默认为1s(1秒钟)，指定了索引搜索器对象刷新的频率，基本上意味着数据视图刷新的频率。
# 刷新率越低， 文档对搜索操作可视的时间越短，也意味着Elasticsearch将需要利用更多资源来刷新索引视图， 因此索引和搜索操作将会变慢。
index.refresh_interval: 1

## 线程池
threadpool.index.type: fixed
threadpool.index.size: 100
threadpool.index.queue_size: 500
# 记住，线程池的配置可以使用集群的更新API来更新，如下所示：
curl -XPUT 'localhost:9200/_cluster/settings' -d '{
  "transient" : {
    "threadpool.index.type" : "fixed",
    "threadpool.index.size" : 100,
    "threadpool.index.queue_size" : 500
  }
}'

### 模板和动态模板
# Elasticsearch实现了一个叫索引模板(index templates)的功能。每个模板 定义了一个模式，用来比较新创建索引的名称。当两者匹配，
# 在模板中定义的值复制到索引的结构定义中。当多个模板匹配新创建索引的名称时，所有模板都会被应用，后应用的模板中的值将 覆盖先应用的模板中定义的值。
# 这非常方便，因为可以在通用模板中定义一些常用设置，然后在 专有模板中修改它们。此外，还有个order参数，可以强制所需模板的顺序。你可以把模板想象
# 成一个动态映射，但它不是应用到文档中的类型，而是应用到索引。

# 1. 模板的一个例子
# 来看一个真实的模板例子。假设要创建许多索引，并且不希望在索引中存储源文档，以便让索引更小，而且也不需要任何副本。可以创建一个模板来满足这个需求，
# 通过使用Elasticsearch 的REST API，发送如下命令:
curl -XPUT http://localhost:9200/_template/main_template?pretty -d '{
 "template" : "*",
  "order" : 1,
  "settings" : {
        "index.number_of_replicas" : 0
  },
  "mappings" : {
    "_default_" : {
        "_source" : {
          "enabled" : false
        }
    }
  }
}'

# 第二个有趣的事情是order参数。使用如下命令定义第二个模板:
curl -XPUT http://localhost:9200/_template/ha_template?pretty -d '{ "template" : "ha_*",
"order" : 10,
"settings" : {
        "index.number_of_replicas" : 5
      }
}'
# 执行上述命令后，除了名字以ha_开头，所有其他新索引将有相同的行为。两个模板都被应 用在这些索引中。首先应用order值更小的模板，
# 然后下一个模板覆盖副本的设置。所以，名字 以ha_开头的索引将有5个副本，并禁用源文档的存储。

# 2. 在文件中存储模板
# 模板也可以存储在文件中。默认情况下，文件应该放在config/templates目录中。例如，ha_template模板应该放在config/templates/ha_template.json文件中，
# 内容如下所示:
{
  "ha_template" : {
    "template" : "ha_*",
    "order" : 10,
    "settings" : { "index.number_of_replicas" : 5 }
    }
}
# 注意这个JSON的结构有点不同，它使用模板名字作为主对象的键。另外很重要的是，模板必须放在Elasticsearch的每个实例中。
# 此外，文件中定义的模板不可用在REST API调用中。

# 3.动态模板
# 有时，我们想依赖一个字段名称和类型来定义一个类型。这是动态模板发挥作用的地方。动 态模板跟通常的映射相似，但每个模板都定义了它的模式，
# 并将其应用于文档的字段名称。如果 一个字段名称与模式匹配，则使用该模板。看看下面的示例:
{
  "mappings" : {
    "article" : {
  "dynamic_templates" : [
  {
    "template_test": {
      "match" : "*",
      "mapping" : {
        "index" : "analyzed",
        "fields" : {
        "str": {"type": "{dynamic_type}", "index": "not_analyzed" } } } } }] }
  }
}
# 在前面的例子中，我们为article类型定义了一个映射。在这个映射中，我们只有一个动态 模板，名为template_test。由于match属性设置成了星号，
# 这个模板将应用到输入文档的每 个字段上。每个字段都将被视为多字段，由原始字段名字(比如，title)和第二个以str作为 后缀的字段(比如，title.str)。
# 第一个字段的类型由Elasticsearch决定({dynamic_type}类 型)，第二个字段将是一个字符串(因为string类型)。

# 3.1. 匹配模式
# 我们有以下两种方式定义匹配模式：
# 1.match:如果字段名与模式相匹配的话，则使用该模板(这是我们例子中使用的类型);
# 2.unmatch:如果字段名与模式不匹配，则使用该模板。
# 默认情况下，该模式非常简单，并且使用glob模式，可以使用match_pattern=regexp来修改。
# 添加此属性后，可以使用正则表达式提供的所有魔法来匹配或不匹配模式。
# 有些变种，比如path_match和path_unmatch，可以用来匹配嵌套文档的名字。

# 3.2. 字段定义
# 当写入一个目标字段定义时，可以使用下面的变量。
# {name}:输入文档中找到的原始字段的名字。 {dynamic_type}:原始文档确定的类型。


