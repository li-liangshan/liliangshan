#!/usr/bin/env bash

# 集群验证
curl -XGET http://127.0.0.1:9200

# 集群健康状态
curl -XGET http://127.0.0.1:9200/_cluster/health?pretty

# 查看集群node
curl -XGET http://localhost:9200/_cluster/state/nodes/

# 关闭集群
# 1.如果节点是连接到控制台，按下Ctrl+C。
# 2.第二种选择是通过发送TERM信号杀掉服务器进程(参考Linux上的kill命令和Windows上的任务管理器)。
# 3.第三种方法是使用REST API。

# 关了整个集群
curl -XPOST http://localhost:9200/_cluster/nodes/_shutdown

# 为关闭单一节点，假如节点标识符是BlrmMvBdSKiCeYGsiHijdg，可以执行下面的命令:
curl -XPOST http://localhost:9200/_cluster/nodes/BlrmMvBdSKiCeYGsiHijdg/_shutdown
