# Metropolis


-----------------------

## Solidity

Solidity是一种用于编写智能合约的高级语言，语法类似于JavaScript。在以太坊平台上，Solidity编写的智能合约可以被编译成字节码在以太坊虚拟机上运行。使用Solidity语言编写智能合约避免了直接编写底层的以太坊虚拟机代码，提高了编码效率，同时该语言也具有更好的可读性。

* [Solidity简介](https://github.com/xianfeng92/Love-Ethereum/blob/master/notes/Solidity.md)


## 相关文章

* [以太坊开发入门](http://me.tryblockchain.org/getting-up-to-speed-on-ethereum.html)
* [Solidity 官方文档中文版](http://wiki.jikexueyuan.com/project/solidity-zh/)
* [区块链技术-智能合约-以太坊（译文）](http://ethfans.org/posts/block-chain-technology-smart-contracts-and-ethereum) - 简单易懂的例子“智能赞助”
* [区块链在线演示版本](https://blockchaindemo.io/) - 在线演示区块链
* [blockchain-demo 演示区块链的原理](https://github.com/xianfeng92/blockchain-demo) - 自己搭建环境去演示区块链结构
* [自己动手部署以太坊联盟链](https://github.com/xianfeng92/Love-Ethereum/blob/master/notes/%E8%87%AA%E5%B7%B1%E5%8A%A8%E6%89%8B%E9%83%A8%E7%BD%B2%E4%BB%A5%E5%A4%AA%E5%9D%8A%E8%81%94%E7%9B%9F%E9%93%BE.md)


## 合约分析

### 代币合约

目前，在以太坊上的众多智能合约之中，应用最为广泛的是代币合约（Token Contract）。代币合约是在以太坊上管理__账户及其拥有的代币__的智能合约，实质上可以理解为一张账户地址和对应账户代币余额的映射表。从某种意义上讲，以太坊上的代币可以被称为数字资产，记录资产数据的代币合约就是一份账本。代币既可以__表示某一虚拟货币的价值__，又可以__象征某些实际的物理量__，甚至可用于__记录账户持有者的信誉值__。但归根结底，以太坊上的数字资产就是指以太坊上代币合约中记录的账户代币余额数据。

数字资产的发行无须经过复杂的“挖矿”程序，代币合约的创建者可以通过智能合约定义自己的代币发行标准，直接在合约代码中实现“铸币”功能。并且，__代币的流通是通过在以太坊交易中调用智能合约的函数接口进行转账__，代币合约创建者同样可以在这一过程中添加一些自定义的操作。

以太坊上的代币作为一种数字资产，需要有它的发行和流通机制。相较于以太币等加密货币基于PoW和PoS共识算法的发行机制以及基于发送交易进行转账的流通机制，以太坊上数字资产的发行和流通更加简便灵活，相关的操作一般由代币合约创建者在代币合约中实现。__常见的代币合约在记录账户及代币余额的基础上，还包含一些基本的数字资产管理操作，如铸造代币、销毁代币以及代币转账等__。


* 代币转账

  代币转账是代币合约的一项基本功能，也是数字资产流通功能的具体实现。例如，账户Alice调用合约的转账功能函数，向账户Bob转入50个代币，此时合约中记录的Alice账户余额减少了50，而Bob账户余额增加了50。

* 铸造代币

  当其他账户通过向合约转入以太币或其他方式调用合约铸造功能时，该代币合约向账户对应的余额值增加相应数量的代币，代币的总供应量也相应增加，完成铸币

* 销毁代币

  账户通过调用合约的销毁功能函数，销毁其账户余额中的代币，代币总供应量也相应地减少。但是，通常代币合约的代币销毁功能是通过向特殊的__零地址0x000...0000__中转入相应数量的代币来完成，此时代币总供应量不会减少。


### ERC 20代币合约

ERC 20代币合约标准规定了一个以太坊代币合约所需实现的函数功能和事件记录。该标准满足了代币作为数字资产所必须具备的一些基本功能和要求，如注明代币名称、代币转账、本账户中允许链上第三方使用的代币限额等。ERC 20的出现为以太坊上的代币合约提供了一个标准化的方案，也对以太坊上数字资产的实现进行了一定的规范。ERC 20标准使得种类繁多的代币能够被更多的去中心化应用（DApp）、交易所等兼容。

自2015年提出以来，ERC 20代币合约标准在以太坊开发社区的协商下逐步确定为11个标准接口。ERC 20标准接口总共可分为三类：常量、功能函数以及事件。


* 常量

 常量类接口包含代币名称、代币符号和小数点位三个常量，分别定义了合约代币的名称、符号等基本信息。

 值得注意的是代币名称以及代币符号都是合约创建者指定的，其无法唯一标示一个智能合约。但在代币交易所中，符合ERC 20标准的代币可以向交易所提供代币名称进行注册，交易所通过注册机制可以检查并保证代币名称与代币合约一一对应，实现类似于ENS的效果。
　
　之所以要引入小数点位这一常量，是因为以太坊虚拟机不支持小数计算，智能合约代码中涉及小数的数值只能先转换为整数后再进行计算。当数字资产用于表示一些无法分割的实际物品，如软件证书时，代币的最小单位应为1，此时小数点位应设为0。


* 函数功能

  函数功能包含总供应量、余额、转账、从他人处转账、允许量值以及限额6个功能函数，分别规定了实现代币合约所必需的查询、转账、权限控制等基本功能的函数接口。

　（1）总供应量

　　　总供应量totalSupply（）函数用于查看代币当前的总供应量，即当前合约账本中所有账户余额的总和。该函数没有输入参数，返回值为无符号整数常量。


　（2）余额
　　　　　
　　　余额balanceOf（）函数用于查看当前合约中指定账户的代币余额。

　（3）转账

　　　转账transfer（）函数用于__从当前账户向其他账户进行代币转账__。该函数的输入参数为目标账户地址和转账的代币数额，返回值为布尔型变量。当账户满足当前有足够的余额、转账数额为正数以及合约编写者指定的其他条件时，转账成功，则合约中当前账户的余额减少，目标账户中的余额增加，函数返回值为真；否则转账失败，函数返回值为假。

  （4）从他人处转账

      从他人处转账transferFrom（）函数用于__从他人账户向其他账户进行代币转账__。在有些情况下，用户不仅可以使用transfer（）函数自己发起转账，还可以__授权他人在一定限额下调用transferFrom（）函数从自己账户中转出代币，而无须自己介入__。


  （5）允许量值

       允许量值approve（）函数用于设定当前账户对指定账户的__允许转账量值（allowed)__。allowed是一个二元组，allowed[A][B]记录的是用户A对本账户中允许账户B转走的代币额度。该函数的输入参数为代币使用方地址和允许使用的额度，返回值为设置是否成功的布尔型变量。__用户A通过调用approve（）函数并指定账户B和允许额度，对allowed[A][B]进行设置__。当账户B调用transferFrom（）函数从账户A中转出代币时，需先通过检查，确保转出的数额不超过账户A设置的allowed[A][B]值，并且转账之后allowed[A][B]值会减少相应的数额。


   （6）限额

       限额allowance（）函数用于查看当前的allowed值。__该函数的输入参数为代币持有方A的地址和代币使用方B的地址，返回值为当前在账户A中允许账户B转出的代币数额allowed[A][B]，为无符号整型常量__。


* 事件

  智能合约中还包括了记录事件的event类型接口，ERC 20合约标准也对代币合约基本的事件接口进行了规范。__ERC 20标准要求代币合约包含至少两个事件：转账（Transfer）和允许（Approval）__。 

    （1）转账

      Transfer（）事件用于记录代币合约最基本的功能——转账。事件的输入参数为转账的发起方、接收方以及转账的代币金额，一般位于transfer（）函数和transferFrom（）函数中转账成功之后触发。用户可以从交易收据（receipt）中查看每一笔代币转账的相关信息。

    （2）允许

      Approval（）事件__用于记录代币合约的进阶功能——允许他人从本账户中转出代币__。事件的输入是代币的持有者、使用者以及所设置的允许金额，一般位于approve（）函数中，设置允许限额成功之后触发。用户可以从交易收据（receipt）中查看代币持有者对他人设置的允许转账限额等相关信息。
   

* [ERC-20协议详解](https://github.com/xianfeng92/Love-Ethereum/blob/master/notes/ERC-20%E5%8D%8F%E8%AE%AE%E8%AF%A6%E8%A7%A3.md)


* [以太坊智能合约的设计模式与升级方法](https://github.com/FISCO-BCOS/Wiki/tree/master/%E6%B5%85%E8%B0%88%E4%BB%A5%E5%A4%AA%E5%9D%8A%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6%E7%9A%84%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F%E4%B8%8E%E5%8D%87%E7%BA%A7%E6%96%B9%E6%B3%95%EF%BB%BF)

## 经典合约案例

* [Token LBJ](https://github.com/xianfeng92/Love-Ethereum/tree/master/testSmartContract/LBJ)
* [Ballot](https://github.com/xianfeng92/Love-Ethereum/tree/master/testSmartContract/Ballot)
* [Auction](https://github.com/xianfeng92/Love-Ethereum/tree/master/testSmartContract/Auction)
* [AccessControl](https://github.com/xianfeng92/Love-Ethereum/tree/master/testSmartContract/AccessControl)


## Truffle

Truffle是针对基于以太坊的Solidity语言的一套开发框架。本身基于Javascript。

* [truffle官方技术文档](https://truffleframework.com/docs)

## Dapp

* [智能合约开发环境搭建及Hello World合约](https://bihu.com/article/565996)
* [搭建以太坊私有链](https://bihu.com/article/567206)
* [区块链应用之dog shop](https://github.com/xianfeng92/dog-shop)
* [Collection your favorite NBA All-Star](https://github.com/xianfeng92/NBASTAR)



