# Love-Ethereum

----------------------------------------------------------------------------------------------------------------------------

## [Ethresear](https://ethresear.ch/)

### Sharding

以太坊仍处于初级阶段。现在，它不具备安全性和可扩展性。以太坊和web3期望建设的——一个安全、易用、由一套共同的经济协议约束、可供数十亿人使用的分布式互联网，仍处于发展阶段，直到关键基础设施建成之后才能实现。致力于构建此 __基础架构__ 并扩大以太坊容量的项目通常称为扩容方案。

* [Sharding FAQ 英文版](https://github.com/ethereum/wiki/wiki/Sharding-FAQs)

* [Sharding FAQ 中文版](https://github.com/xianfeng92/Love-Ethereum/blob/master/notes/ShardingFAQ.md)


### Cross-Shard

#### 几种跨分片的方案

* 客户端来维护分片之间状态一致性,典型的就是Omniledger

  分片之间的通信完全是靠客户端来驱动。优点是分片协议不用考虑维护一致性的问题，技术简单，且避免了分片之间一致性协议的开销。缺点显而易见，没法做到交易丢出去不管，客户端在这个过程中必须保持运行。让客户端去分片间状态维护，总是感觉不靠谱。我更倾向于认为，由于分片机制不完善，解决不了状态一致性而强行打的补丁。

* 基于trace对 transaction 进行标注,典型的就是Chainspace

  交易注入到网络中之前，先模拟trace，并以此标注出可能与其他交易冲突的地方，然后再根据这些冲突发到相关的分片中处理，相关的分片之间再用S-BAC（Sharded Byzantine Atomic Commit）去共识。如果每一个交易可能的冲突都要相关的分片之间去跑一轮共识，一个分片如果牵涉到很多个这样的交易，那每一次就要跟不同的分片跑很多个这样的共识，自然而然就会产生效率问题。

* 分割交易，典型的就是Ethereum

  这种方案类似于将交易过程切开，交易的发送+交易的接收，并且这两个过程在不同的共识周期中完成。具体在Ethereum中的话，假设Alice给Bob发送 10 eth。在一个共识周期中，分片A上，Alice 产生一笔交易（转移10Eth给Bob），其账户余额会减少 10 Eth，并在主链中产生一个收据（receipt），然后在下一个共识周期中，另一个分片B中，Bob依据这个收据（receipt）来接收交易，即其账户会增加 10 Eth。
  
  这类似于火车和旅馆问题。旅游旺季，我们准备去西藏旅游，要定火车票和旅馆。倘若我们定了火车票，但是旅馆没订到，那GG了；倘若我们订到了旅馆，但是火车票没订到，那总不能走过去吧。问题产生的原因就是交易分裂到多个共识周期，破坏了原子性。 
  
  Ethereum目前在这一块还处于初步的理论研究阶段，计划在分片的第四期中实现。

--------------------------------------------------------------------------------------------------------------------------

关于跨分片解决方案之一拜占庭原子提交的讨论，多分片问题最理想的解决方案可能就是归并成单分片处理。如果每个"交易状态都涉及到多分片"那将严重影响分片的性能，所以分片以后的重点问题可能就是处理应用和分片的关系。

* [Sharded Byzantine Atomic Commit](https://ethresear.ch/t/sharded-byzantine-atomic-commit/1285)

--------------------------------------------------------------------------------------------------------------------------


以太坊的一个跨分片的解决方案，方案核心就是多分片的单分片的处理方式，在EVM级别处理，可能比其他方案相对“简单”。

* [Cross-shard contract yanking](https://ethresear.ch/t/cross-shard-contract-yanking/1450)

--------------------------------------------------------------------------------------------------------------------------

* [Cross-links between main chain and shards](https://ethresear.ch/t/cross-links-between-main-chain-and-shards/1860)

* [Cross Shard Locking Scheme](https://ethresear.ch/t/cross-shard-locking-scheme-1/1269/25)

 
### Casper

### Plasma

### Economics

### Applications

-------------------------------------------------------------------------------------------


## 版本说明

* [Frontier](https://github.com/xianfeng92/Love-Ethereum/blob/master/version/Frontier.md)

  简单的介绍区块链基础知识，通过阅读此版本可以对区块链技术有个初步的认知。
  
* [Homestead](https://github.com/xianfeng92/Love-Ethereum/blob/master/version/Homestead.md)

  介绍以太坊项目，并对涉及到的区块链核心技术点进行介绍和分析。

* [Metropolis](https://github.com/xianfeng92/Love-Ethereum/blob/master/version/Metropolis.md)

  该本版主要是关于智能合约和Dapp
  
* [Serenlity](https://github.com/xianfeng92/Love-Ethereum/blob/master/version/Serenlity.md)
  
  以太坊源码分析

-------------------------------------------------------------------------------------------


# Project progress

## 阅读和整理区块链资料, 制作Frontier ---- 已完成
  
* 已完成Frontier版本,目前正在以太坊私有链上测试和部署 LBJ Token的功能.

* 已完成LBJ　Token的功能测试，LBJ　可以部署在以太坊主网上。

 [点击直达](https://github.com/xianfeng92/Love-Ethereum/blob/master/version/Frontier.md)

----------------------------------------------------------------------------------------------------------------------------

## 以太坊私有链上测试和部署一些经典的智能合约 ----进行中

### Solidity

* [Solidity官方文档翻译](https://github.com/xianfeng92/Solidity-Docs)

### Web3 Api

* [Web3 Api](https://github.com/xianfeng92/Web3js-Doc)

### 经典的智能合约案例

* 基于区块链的投票　－－Ballot
* 盲拍 -- Blind Auction
* 权限控制　－－　AccessControl

### 智能合约设计模式

* CD（Controller-Data）模式

### Dapp

* [NBASTAR](https://github.com/xianfeng92/NBASTAR)

* [dog-shop](https://github.com/xianfeng92/dog-shop)


### Dapp开发利器－Truffle

* [Truffle技术文档翻译](https://github.com/xianfeng92/Truffle-Docs)


 [点击直达](https://github.com/xianfeng92/Love-Ethereum/blob/master/version/Metropolis.md)
 
--------------------------------------------------------------------------------------------------------------

## P2P网络




-----------------------------------------------------------------------------------------------------------

## 可信之石(共识算法) ----进行中

在一个分布式系统中，如何保证集群中所有节点中的数据完全相同并且能够对某个提案（Proposal）达成一致是分布式系统正常工作的核心问题，而共识算法就是用来保证分布式系统一致性的方法。无论是 Bitcoin、Ethereum 还是 EOS，作为一个分布式网络，首先需要解决分布式一致性的问题，也就是所有的节点如何对同一个提案或者值达成共识，这一问题在一个所有节点都是可以被信任的分布式集群中都是一个比较难以解决的问题，更不用说存在拜占庭节点的区块链网络中了。


* [共识算法介绍](https://github.com/xianfeng92/Love-Ethereum/blob/master/DistributedSystem/consensus.md)

* [Paxos](https://github.com/xianfeng92/Love-Ethereum/blob/master/DistributedSystem/paxos.md)

* [PBFT](https://github.com/xianfeng92/Love-Ethereum/blob/master/DistributedSystem/pbft.md)

* [Proof of Stake FAQs](https://github.com/ethereum/wiki/wiki/Proof-of-Stake-FAQs)


-------------------------------------------------------------------------------------------------------------


# IPFS ----进行中

星际文件系统IPFS（InterPlanetary File System）是一个面向全球的、点对点的分布式版本文件系统，目标是为了补充（甚至是取代）目前统治互联网的超文本传输协议（HTTP），将所有具有相同文件系统的计算设备连接在一起。

* [IPFS基本介绍](https://github.com/xianfeng92/Love-Ethereum/blob/master/notes/IPFS.md)
* [IPFS基本操作](https://github.com/xianfeng92/Love-Ethereum/blob/master/notes/IPFSCommand.md)
* [IPFS项目中的使用](https://github.com/xianfeng92/Love-Ethereum/blob/master/notes/IPFSBlockchain.md)

## Vickrey auction

* [Vickreyauction](https://github.com/xianfeng92/Love-Ethereum/tree/master/Vickreyauction)

------------------------------------------------------------------------------------------------------------

## 以太坊源码的分析 ---- 进行中

* 目前主要是阅读一些以太坊源码解读的文章

下面的文章主要是CSDN上的一个teaspring的技术专栏里面关于以太坊源代码分析的文章，文章写的超级好，强烈推荐！

* [区块和交易，合约和虚拟机](https://blog.csdn.net/teaspring/article/details/75389151)
* [数据的呈现和组织，缓存和更新](https://blog.csdn.net/teaspring/article/details/75390210)
* [挖矿和共识算法的奥秘](https://blog.csdn.net/teaspring/article/details/78050274)
* [Clique共识算法](https://ethfans.org/posts/Clique-Consensus-Algorithm)
* [ 椭圆曲线密码学和以太坊中的椭圆曲线数字签名算法应用](https://blog.csdn.net/teaspring/article/details/77834360)
* [从钱包到客户端](https://blog.csdn.net/teaspring/article/details/78350888)

 [点击直达](https://github.com/xianfeng92/Love-Ethereum/blob/master/version/Serenlity.md)
 
### [源码分析](https://github.com/xianfeng92/ethereum-code-analysis)

----------------------------------------------------------------------------------------------------------------------

# 大事件

## 6月10号EOS主网成功上线
      
      未来已来,只是尚未流行!

这里引用EOS官方的话：

Finally, the moment we have all been working for. After nearly a year long development process and community involvement, we have lift-off! The ideas on a whitepaper are brought to life thanks to all the contribution by a large community of well-wishers!
Together we present EOS, a crypto-economic solution for securing life, liberty, property, and justice for all. Along with other crypto platforms we move toward the same end goal: minimizing corruption and maximizing freedom in society.

"The greatness of a community is most accurately measured by the compassionate actions of its members." 

- Coretta Scott King

-----------------------------------------------------------------------------------------------------------


# 参与贡献

区块链技术自身仍在快速发展中，生态环境也在蓬勃成长。欢迎 [参与维护项目](https://github.com/xianfeng92/Love-Ethereum/blob/master/contribute.md)。


-----------------------------------------------------------------------------------------------------------















