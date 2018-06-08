# 参与贡献

区块链技术自身仍在快速发展中，生态环境也在蓬勃成长。

本书源码开源托管在 Github 上，欢迎参与维护.

首先，在 GitHub 上 fork 到自己的仓库，然后 clone 到本地，并设置用户信息。

> $ git clone https://github.com/xianfeng92/Love-Ethereum.git

>$ cd Love-Ethereum

>$ git config user.name "yourname"

>$ git config user.email "your email"

更新内容后提交，并推送到自己的仓库。

> $ #do some change on the content

> $ git commit -am "Fix issue #1: change helo to hello"

> $ git push

最后，在 GitHub 网站上提交 pull request 即可。

另外，建议定期使用项目仓库内容更新自己仓库内容。

>$ git remote add upstream https://github.com/xianfeng92/Love-Ethereum

>$ git fetch upstream

>$ git checkout master

>$ git rebase upstream/master

>$ git push -f origin master
