# 更新homebrew 镜像源为清华大学镜像
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git

brew update

# 在mac终端下执行：brew update
# 结果报错：
# Error: Another active Homebrew update process is already in progress.
# Please wait for it to finish or terminate it to continue.
# 解决方法：rm -rf /usr/local/var/homebrew/locks

# brew.git 镜像
# 中科大镜像：https://mirrors.ustc.edu.cn/brew.git
# 阿里镜像:  https://mirrors.aliyun.com/homebrew/brew.git
# 清华镜像：https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
# GitHub镜像：https://github.com/Homebrew/brew.git

# homebrew-core.git 镜像
# 中科大镜像：https://mirrors.ustc.edu.cn/homebrew-core.git
# 阿里镜像:  https://mirrors.aliyun.com/homebrew/homebrew-core.git
# 清华镜像：https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
# GitHub镜像：https://github.com/Homebrew/homebrew-core

# homebrew-cask.git 镜像
# 中科大镜像
https://mirrors.ustc.edu.cn/homebrew-cask.git
# 阿里暂无该镜像
# github镜像
https://github.com/Homebrew/homebrew-cask.git

# 切换 Homebrew 镜像源为中科大镜像源
# 替换brew.git:
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

# 替换homebrew-core.git:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

# 替换homebrew-cask.git:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-cask"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git

# 应用生效
brew update
# 替换homebrew-bottles:
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc

# 查看镜像源信息
brew config
