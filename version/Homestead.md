# Homestead


-----------------------
## 以太坊

区块链通常被定义为去中心的分布式记账系统，该系统中的节点无需互相信任，通过统一的共识机制共同维护一份账本。在前几年，大家会关注比特币而不会单独谈论区块链这个技术。直到2015年，区块链这一概念才被单独提出来为更多人所了解，且向着更广泛的应用场景发展。发生在这个时间点的主要原因之一是以太坊的出现和日益成熟。

简单地说，以太坊是一个有智能合约（Smart Contract）功能的公共区块链平台。用智能手机打个比方，如果说以太坊是智能手机的操作系统，那么智能合约就是上面搭载的应用（App）。有了以太坊，用户可以直接开发自己的区块链应用。


### 以太币(ETH)

以太币是以太坊发行的一种数字货币, 在以太坊上发起任何一笔交易都需要支付一定的以太币.

以太币来源包括: 矿前 + 区块奖励 + 叔区块奖励 + 数区块引用奖励, 具体分配大致如下:

* 预付款的贡献者总共有6000万个ETH

* 新区块的挖矿奖励5ETH

* 如果一个矿工挖出一个新区块, 但不是在主链中,则该区块称为叔区块. 如果该叔区块在之后的区块链中被引用, 每个叔区块挖矿者有4.375个ETH, 引用者有0.15ETH.


以太币发行:

*  以太币发行使用GHOST协议, 每年发1800w ETH

* 2018年开始,以太坊将使用Casper来替代目前的Pow, 该协议运行效率更高且需要更少的挖矿补贴. 此时ETH的发行率可能会有所降低


### 交易(Transactions)
  
  以太坊的交易指的是一个外部账户发送到区块链上另一账户的消息的签名数据包,该消息中主要包含 发送者签名, 接收者地址, 交易的ETH数量等内容.在以太坊上的每一笔交易都需要支付一定的费用, 该费用主要用于支付执行交易所需要的计算开销. 以太坊中Gas是执行开销的基本单位.
  
#### 交易费用

以太坊中采用Gas和GasPrice来对交易所需的手续费进行定价:

* Gas

   用来衡量一笔交易所需要消耗计算资源的基本单位, 当执行一笔交易所需的计算步骤越多或者需要消耗更多的内存,那么这笔交易就需要越多的Gas.一般,一个普通的转账交易会消耗 21000Gas, 而创建一个智能合约交易可能会消耗几万甚至几百万的Gas
   
* GasPrice

   是指1 Gas所需要的以太币, 如果一个转账交易消耗21000Gas, 假设GasPrice为 0.000000001 wei/Gas,那么这笔交易的手续费为0.000021Ether.
   
   
* GasLimit

  对于单个交易, GasLimit表示交易者愿意为这笔交易所支付的最大Gas数量,其可以保护用户可能由于错误的代码影响而支付过多的交易费;
  
  对于区块来说, GasLimit表示单个区块所允许包含的最大Gas数量, 其由矿工决定大小. 区块的GasLimit设置的越大, 那么矿工就可以获得越多的交易费,但是需要更多的带宽, 同时会加叔数区块出现的概率, 造成挖出的区块无法形成最长的交易链.根据以太坊协议, GasLimit只能在1到1024之间.

#### 交易内容

一笔交易会包含一下内容:

* from: 交易发送者地址
* to: 交易接受者地址, 如果为空,则意味这是一个创建智能合约的交易
* value:转移的ETH数量
* data: 如果存在data字段,表明这是一个创建或者调用智能合约的交易
* GasLimit: 这个交易允许消耗的最大Gas数量
* GasPrice: 发送者愿意支付给矿工的Gas价格
* nonce:用来区别同一用户发出不同交易的标志
* hash:由以上信息生成的散列值,作为交易的id
* r  s  v: 交易签名的三个部分, 由发送者的私钥对交易的hash进行签名生成

不同场景下, 交易的三种类型:

* 转账交易

> web3.eth.sendTransaction(from:sendAddress, to:receiveAddress, value:10000000000)

* 创建智能合约

> web3.eth.sendTransaction(from:sendAddress,data:"contract binary code")

* 执行智能合约

> web3.eth.sendTransaction(from:sendAddress, to:"contract address", data:"hash of the invoked method signature and encoded parameters")


### 智能合约

现实生活中经常遇到这样的场景：买家与卖家要进行一笔交易，为了保证交易的顺利进行，双方签订了一份合约，合约中声明双方各自的身份、权利和义务（买家付钱、卖家交货的时间节点和方式等），一式两份，各自保存。这样，当交易出现纠纷时，合约将成为寻求法律援助的依据，而法律将成为确保合约执行的强制力保障。


虽然合约为交易的顺利进行提供了一些保障，但是也存在很多不足之处。一旦交易中发生了纠纷，比如卖家拖延发货或者买家拒绝付款，即使在法律的援助下解决了纠纷，交易的效率也会大大降低。甚至在一些情况下，合约将会失去约束效力，比如合约中存在歧义或者合约丢失等。

那么有没有一种更有效的方式来保证交易的进行呢？假设有一个绝对可信和公正的交易代理人，卖家将商品交给代理人，买家与代理人进行一手交钱一手交货的当面交易。如果买家拒绝购买，卖家可以从代理人手中取回商品；买家也不会存在付钱后拿不到商品的风险。

智能合约就可以充当这样一个代理人。简单地说，智能合约就是区块链上一个包含合约代码和存储空间的虚拟账户,智能合约的行为由合约代码控制，而智能合约的账户存储则保存了合约的状态。

相比较传统合约，区块链智能合约在很多方面具有优势:

* 智能合约的条款是由代码确定的。由于代码逻辑的明确性，比起自然语言，更加不容易产生歧义。

* 智能合约存储和部署在区块链网络中，而网络中的节点相互独立，都拥有同一份副本，因此合约内容几乎不可能被篡改。同时区块链中也保存了合约的执行记录，可以作为永久的交易凭证。

* 合约的创建和执行都依赖于区块链协议，所以合约执行的强制力可以保证。


理论上讲，任意计算复杂度的金融交互过程均可以由智能合约安全、自动地完成。除了金融方面的应用，以太坊平台还可以在如财产登记、投票、智能交通、物联网等任何需要信任、安全和性能兼顾的环境中进行部署和使用。


### 以太坊虚拟机（EVM）

在以太坊平台上，智能合约的代码运行在以太坊虚拟机（EVM）中，EVM是一个图灵完备的虚拟机，是以太坊协议的核心。在以太坊的点对点（P2P）网络中，__每个全节点上都包含一个以太坊虚拟机__，当节点需要打包或验证区块时，便将交易相关的可执行代码送入EVM中执行，执行的结果更新了以太坊账户的状态并被记录在区块链上。


以太坊网络中的每个节点都需要在各自的EVM中执行代码，这就导致了两个问题:

* 一是这样会产生__大量的平行化计算__，每个节点都必须执行代码以验证区块中的结果状态。这虽然牺牲了一定的计算效率，但保证了分布式网络中更高的安全性。

* 二是__EVM的执行结果必须有严格的确定性__，所有节点必须得到同样的运行结果。这就对智能合约以及EVM造成了一定的局限性，智能合约目前仍无法实现一些可能会带来不确定结果的简单操作，如生成随机数、调用操作系统API等，因为这些操作会因时间、系统等执行环境的差异而产生不同的结果，进而使以太坊节点无法对区块中的账户状态达成共识。

### 相关文章

* [以太坊的网络结构](http://8btc.com/thread-170796-1-1.html)-很基础，适合初学者阅读

* [王峰十问之以太坊VM 英文原话](https://github.com/xianfeng92/Love-Ethereum/blob/master/notes/%E7%8E%8B%E5%B3%B0%E5%8D%81%E9%97%AEVM.md)


>
* [以太坊白皮书](https://ethfans.org/wikis/%E4%BB%A5%E5%A4%AA%E5%9D%8A%E7%99%BD%E7%9A%AE%E4%B9%A6)
* [以太坊官网文档中文版](http://book.8btc.com/books/6/ethereum/_book)
* [<<以太坊技术详解与实战>>] -在读中
>
* [Teahour 以太坊专访-文字版](http://ethfans.org/shaoping/articles/talk-with-jan-about-ehtereum) - 强烈推荐
* [智能合约](http://ethfans.org/wikis/%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6)
* [以太坊开发计划](http://ethfans.org/wikis/%E4%BB%A5%E5%A4%AA%E5%9D%8A%E5%BC%80%E5%8F%91%E8%AE%A1%E5%88%92)
>
* [实现这些扩容方案，以太坊将可支持10亿用户](http://www.8btc.com/scaling-ethereum-to-billions-of-users)
>
* [以太坊开发入门，完整入门篇](http://me.tryblockchain.org/getting-up-to-speed-on-ethereum.html)
* [以太坊入门](https://bihu.com/article/563457)
* [从区块链的基础知识出发，研究ETH和EOS的区别](https://bihu.com/article/165408)
* [关于以太坊，你必须要知道的～～～Casper](https://bihu.com/article/142335)


-----------------

## 重要的技术点

### 密码学

 区块链的密码学算法为区块的生成,交易的传输等进行加密.


### 经济学

  * [你对“钱”的认知已经严重落伍了](https://bihu.com/article/530100)-强烈推荐

  * [现代经济中的货币](https://ethfans.org/posts/money-creation-in-modern-economy-part-1) -强烈推荐


## P2P网络

* [P2P技术是什么](https://shuwoom.com/?p=721)
* [详解区块链P2P网络](https://keeganlee.me/post/blockchain/20180313)
* [P2P对等网络原理与应用](https://github.com/xianfeng92/Love-Ethereum/blob/master/p2p/P2P%E5%AF%B9%E7%AD%89%E7%BD%91%E7%BB%9C%E5%8E%9F%E7%90%86%E4%B8%8E%E5%BA%94%E7%94%A8.pdf)
* [KADEMLIA算法学习](https://shuwoom.com/?p=813)

### 节点通信（TCP/IP）


### Merkle Tree - 梅克尔树

* [Merkle Tree 学习](http://www.cnblogs.com/fengzhiwu/p/5524324.html)
* [谈谈以太坊的Merkle树](http://www.8btc.com/merkling-in-ethereum) / [Merkling in Ethereum](https://blog.ethereum.org/2015/11/15/merkling-in-ethereum) - Vitalik Buterin

### Merkle Patricia Tree - 梅克尔帕特里夏树

* [Understanding the Ethereum Trie](https://easythereentropy.wordpress.com/2014/06/04/understanding-the-ethereum-trie) - Ethereum 推荐
* [Ethereum Patricia Tree](https://github.com/ethereum/wiki/wiki/Patricia-Tree) - Ethereum Wiki
>
* [深入浅出以太坊MPT (Merkle Patricia Tree) ](http://blog.csdn.net/qq_33935254/article/details/55505472)
* [Merkle Patricia Tree (MPT) 以太坊merkle技术分析](http://blog.csdn.net/zslomo/article/details/53434883?t=1498537389197)
* [Merkle Patricia Tree (MPT) 详解](http://www.cnblogs.com/fengzhiwu/p/5584809.html)
>
* [Ethereum RLP](https://github.com/ethereum/wiki/wiki/%5B%E4%B8%AD%E6%96%87%5D-RLP) - Ethereum Wiki
* [RLP编码原理](https://my.oschina.net/u/2349981/blog/894117)

### 共识算法介绍

区块链构造的去中心化账本需要解决的首要问题是如何确保不同节点上的账本数据的一致性和正确性,而共识算法正是解决这个问题。

#### 相关文章

* [共识算法（POW,POS,DPOS,PBFT）介绍和心得](http://blog.csdn.net/lsttoy/article/details/61624287)
* [掰一掰区块链共识机制与分布式一致性算法](https://yq.aliyun.com/articles/60400)
* [什么是区块链共识？](http://8btc.com/article-2238-1.html)
* [区块链共识机制浅谈](http://blog.csdn.net/jeffrey__zhou/article/details/56672948)
* [区块链共识机制有哪些？](https://www.zhihu.com/question/53385152)
>
* [微信PaxosStore：深入浅出Paxos算法协议](http://www.infoq.com/cn/articles/wechat-paxosstore-paxos-algorithm-protocol)
* [Raft 一致性算法论文译文](http://www.infoq.com/cn/articles/raft-paper)
>
* [POS白皮书：基于权益证明的交易](https://yq.aliyun.com/articles/60400)
* [深度解析POS和POW的区别](http://8btc.com/article-1882-1.html)
>
* [DPOS共识算法-by BM](http://me.tryblockchain.org/blockchain-dpos-bm-eos.html) -强烈推荐
* [DPOS——回归中本聪](http://www.8btc.com/dpos-back-to-satoshi)
* [信息图：股份授权证明机制（DPOS）](http://www.8btc.com/dpossha)
* [DPOS共识算法 -- 缺失的白皮书](https://steemit.com/dpos/@legendx/dpos)
* [DPOS委托权益证明 vs POW工作量证明](https://zhuanlan.zhihu.com/p/28127511)
* [区块链核心算法解析] -在读中


#### 经典的共识算法

[几种经典共识算法分析](https://github.com/xianfeng92/Love-Ethereum/blob/master/DistributedSystem/ConsensusAlgorithm.md)

#### POW

Pow即通过工作结果来证明你完成了相应的工作. 其工作工程是繁琐而低效的,而对工作结果的验证确实很容易的.比如: 我们可以用一份高考成绩单来衡量一个学生在高中三年中各学科的学习情况.Pow的目的是使得区块的创建变的困难,从而阻止“女巫“攻击者恶意重新生成区块链.

一般加密货币的Pow算法可以描述如下:

* 节点打包经过验证的交易

* 不断地更换随机数来探寻合适的散列值(该散列值小于系统提供的指定散列值)

* 当节点计算出合适的散列值时, 如果其打包的快通过了其他共识节点的验证,则会被加入到区块链中.


节点想要计算出合适的散列值需要经过大量的散列计算, 计算时间则取决于机器的散列速度.所以一般矿机的性能越好,其成功计算出合适的散列值的概率就会越大.


#### Pos

Pos是基于网络参与者目前所持有的数字货币的数量和时间进行利益分配, 是一种对货币所有权的证明. 


在以太坊中, Pos 算法可以描述如下:

* 以太坊区块链由一组验证着决定, 任何持有以太币的用户都能发出一笔特殊的交易, 将他们的以太币锁定在一个存储中, 从而是自己成为验证者

* 然后, 通过一个当前验证者都能参与的共识算法, 完成新区块的产生和验证过程.

验证者参与的共识算法有哪些? 

*  基于链的Pos
    
    该算法中在每个时间单位(比如说 10s )内伪随机地从验证者集合中选择一个验证者, 给予这个验证者创建新区块的权利, 但是该验证者要保证其所产生的块是在最长链上.
    

*  基于BFT的Pos

   让每个验证者自己去提出块并给被提出的块投票, 该投票过程使用的BFT算法. 最后, 被BFT算法所确定出来的块将会被添加到区块链上.


在Pos中对“胡乱”投票的行为会给予惩罚:

* Slasher
   
   如果验证者在不同的链上创建块, 则在事后会将其行为记录在区块链上, 并扣除其押金.
   
* Casper

  Casper有可能做到秒级别的共识, Casper中有很多抵押了一定代币的验证者, 这些验证者对新块进行投票已决定它是否有效, 最后根据投票的结果形成大多数人的意见. 投票新块有效的用户会获得奖励, 而作恶用户将会被没收押金。


### 权益证明

* [权益证明 FAQ（完整版）](https://ethfans.org/posts/Proof-of-Stake-FAQ-new-2018-3-15)

### Casper

* [以太坊Casper项目](https://github.com/xianfeng92/casper)
* [科普 | 什么是以太坊Casper协议？](https://ethfans.org/posts/ethereum-casper)
* [如果你想变成 Casper PoS/分片的验证者](https://ethfans.org/posts/you-want-to-be-casper-sharding-validator) -Vitalik 在 2018 以太坊技术及应用大会上的演讲内容

### Sharding

 整体来讲，如何提高一个单链区块链的tps性能就是__并行化__和__适当中心化__。并行化得一个思路就是分片sharding, 分片主要用于加快交易验证的速度。

* [什么是分片？](http://8btc.com/thread-170816-1-1.html)
* [图文详解以太坊的节点和分片](http://8btc.com/thread-169987-1-1.html)
* [以太坊分片：overview and finality](https://cloud.tencent.com/developer/article/1021579)

----------------

