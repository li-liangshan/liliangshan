#!/usr/bin/env bash

### 安装virtualenv
sudo pip install virtualenv

# 创建隔离环境
virtual env_name

# 激活隔离环境
source env_name/bin/activate

# 退出隔离环境
deactivate

# 删除环境
rm -r env_name

### VirtualEnvWrapper管理虚拟环境
# 安装VirtualEnvWrapper
pip install virtualenvwrapper

# 配置环境
echo "export WORKON_HOME=~/Env" >>~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >>~/.bashrc

# 激活
# shellcheck disable=SC1090
source ~/.bashrc

# 常用操作
mkvirtualenv env_name
mkvirtualenv --system-site-packages env_name # 依赖系统第三方软件包
workon                                       # 列出已有环境
workon env_name                              # 切换环境
deactivate                                   # 退出隔离环境
rmvirtualenv env_name                        # 删除环境
