# Truffle Project

> mkdir VickreyAuction

> cd VickreyAuction

> truffle unbox webpack

> rm contracts/ConverLib.sol contracts/MetaCoin.sol


# Ecommerce Product

```
pragma solidity ^0.4.18;

contract EcommerceStore {
    
    enum ProductStatus {
        
        Open,
        Sold,
        Unsold
    }
    
    enum ProductCondition {
        
        New,
        Used
    }
    
    
    uint public productIndex;
    mapping(address => mapping(uint => Product)) stores;
    mapping(uint => address) produceIdInStore;
    
    struct Product{
        uint id;
        string name;
        string category;
        string imageLink;
        string deskLink;
        uint autionStartTime;
        uint startPrice;
        address highestBidder;
        uint highestBid;
        uint secondHighestBid;
        uint totalBids;
        ProductStatus status;
        ProductCondition condition;
    }
    
    function EcommerceStore() public{
        productIndex = 0;
    }
    
}

```


# Add Product To Store

```
   function addProductToStore(string _name, string _category, string _imageLink, string _descLink, uint _auctionStartTime,
    uint _auctinEndTime, uint _startPrice, uint _productCondition) public{
        
        require(_auctinEndTime > _auctionStartTime);
        productIndex += 1;
        Product memory product = Product(productIndex, _name, _category, _imageLink, _descLink, _auctionStartTime, _auctinEndTime,
        _startPrice, 0, 0, 0, 0, ProductStatus.Open, ProductCondition(_productCondition));
        stores[msg.sender][productIndex] = product;
        produceIdInStore [productIndex] = msg.sender;
    }
    
    function getProduct(uint _productId) view public returns (uint, string, string, string,string,
    uint, uint, uint, ProductStatus, ProductCondition){
        
        Product memory product = stores[produceIdInStore[_productId]][_productId];
        
        return (product.id, product.name, product.category, product.imageLink,product.deskLink,
        product.autionStartTime, product.auctionEndTime, product.startPrice, product.status, product.condition);
        
    }
```

#　部署脚本

在migrations文件夹下添加部署脚本　2_deploy_contracts.js，脚本内容如下：

```
var EcommerceStore = artifacts.require("./EcommerceStore.sol");

module.exports = function(deployer) {
  deployer.deploy(EcommerceStore);
};

```



# Console 交互

* 编译合约

> truffle compile

* 进入truffle develop

> truffle develop

* 部署合约

> migrate

```
zhongxianfeng@zhongxianfeng-HP-EliteDesk-800-G1-SFF:~/Dapps/VickreyAuction$ truffle compile
Compiling ./contracts/EcommerceStore.sol...
Compiling ./contracts/Migrations.sol...

Compilation warnings encountered:

/home/zhongxianfeng/Dapps/VickreyAuction/contracts/EcommerceStore.sol:40:5: Warning: Defining constructors as functions with the same name as the contract is deprecated. Use "constructor(...) { ... }" instead.
    function EcommerceStore() public{
    ^ (Relevant source part starts here and spans across multiple lines).
,/home/zhongxianfeng/Dapps/VickreyAuction/contracts/Migrations.sol:11:3: Warning: Defining constructors as functions with the same name as the contract is deprecated. Use "constructor(...) { ... }" instead.
  function Migrations() public {
  ^ (Relevant source part starts here and spans across multiple lines).

Writing artifacts to ./build/contracts

zhongxianfeng@zhongxianfeng-HP-EliteDesk-800-G1-SFF:~/Dapps/VickreyAuction$ truffle develop
Truffle Develop started at http://127.0.0.1:9545/

Accounts:
(0) 0x627306090abab3a6e1400e9345bc60c78a8bef57
(1) 0xf17f52151ebef6c7334fad080c5704d77216b732
(2) 0xc5fdf4076b8f3a5357c5e395ab970b5b54098fef
(3) 0x821aea9a577a9b44299b9c15c88cf3087f3b5544
(4) 0x0d1d4e623d10f9fba5db95830f7d3839406c6af2
(5) 0x2932b7a2355d6fecc4b5c0b6bd44cc31df247a2e
(6) 0x2191ef87e392377ec08e7c08eb105ef5448eced5
(7) 0x0f4f2ac550a1b4e2280d04c21cea7ebd822934b5
(8) 0x6330a553fc93768f612722bb8c2ec78ac90b3bbc
(9) 0x5aeda56215b167893e80b4fe645ba6d5bab767de

Private Keys:
(0) c87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3
(1) ae6ae8e5ccbfb04590405997ee2d52d2b330726137b875053c36d94e974d162f
(2) 0dbbe8e4ae425a6d2687f1a7e3ba17bc98c673636790f1b8ad91193c05875ef1
(3) c88b703fb08cbea894b6aeff5a544fb92e78a18e19814cd85da83b71f772aa6c
(4) 388c684f0ba1ef5017716adb5d21a053ea8e90277d0868337519f97bede61418
(5) 659cbb0e2411a44db63778987b1e22153c086a95eb6b18bdf89de078917abc63
(6) 82d052c865f5763aad42add438569276c00d3d88a2d062d36b2bae914d58b8c8
(7) aa3680d5d48a8283413f7a108367c7299ca73f553735860a87b08f39395618b7
(8) 0f62d96d6675f32685bbdb8ac13cda7c23436f63efbb9d07700d8669ff12b7c4
(9) 8d5366123cb560bb606379f90a0bfd4769eecc0557f1b362dcae9012b548b1e5

Mnemonic: candy maple cake sugar pudding cream honey rich smooth crumble sweet treat

⚠️  Important ⚠️  : This mnemonic was created for you by Truffle. It is not secure.
Ensure you do not use it on production blockchains, or else you risk losing funds.

truffle(develop)> migrate
Using network 'develop'.

Running migration: 1_initial_migration.js
  Deploying Migrations...
  ... 0x75c270b5e944f6982acfb89c9b8132f5988eb104a0f48399d687dd2b081be3dd
  Migrations: 0x8cdaf0cd259887258bc13a92c0a6da92698644c0
Saving successful migration to network...
  ... 0xd7bc86d31bee32fa3988f1c1eabce403a1b5d570340a3a9cdba53a472ee8c956
Saving artifacts...
Running migration: 2_deploy_contracts.js
  Deploying EcommerceStore...
  ... 0x9ab3d790ca5dc393f45cc0fbfa24e6b70091597f51ad0c3e3db9bda4d2371425
  EcommerceStore: 0x345ca3e014aaf5dca488057592ee47305d9b3e10
Saving successful migration to network...
  ... 0xf36163615f41ef7ed8f4a8f192149a0bf633fe1a2398ce001bf44c43dc7bdda0
Saving artifacts...
truffle(develop)> 
```

* 交互

```
truffle(develop)> amount_1 = web3.toWei(2,"ether")
'2000000000000000000'
truffle(develop)> current_time = Math.round(new Date() / 1000)
1531280644
truffle(develop)> EcommerceStore.deployed().then(function(i){i.addProductToStore("iPhone8","Cell phones","imagelink","descLink",current_time,current_time+1800,amount_1,0).then(function(f){console.log(f)})})
undefined
truffle(develop)> { tx:
   '0x2074f4c47dec6de38461783f38aece036980fc37a84e90df168101811c3d9fe9',
  receipt:
   { transactionHash:
      '0x2074f4c47dec6de38461783f38aece036980fc37a84e90df168101811c3d9fe9',
     transactionIndex: 0,
     blockHash:
      '0x0d9f4a40c2fc1ca0298c8ae9f4db0b9231a28d4b86c9e6d63456fe85407c1e56',
     blockNumber: 5,
     gasUsed: 263667,
     cumulativeGasUsed: 263667,
     contractAddress: null,
     logs: [],
     status: '0x01',
     logsBloom:
      '0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000' },
  logs: [] }

undefined
truffle(develop)> EcommerceStore.deployed().then(function(i){i.getProduct.call(1).then(function(f){console.log(f)})})
undefined
truffle(develop)> [ BigNumber { s: 1, e: 0, c: [ 1 ] },
  'iPhone8',
  'Cell phones',
  'imagelink',
  'descLink',
  BigNumber { s: 1, e: 9, c: [ 1531280644 ] },
  BigNumber { s: 1, e: 18, c: [ 20000 ] },
  BigNumber { s: 1, e: 9, c: [ 1531282444 ] },
  BigNumber { s: 1, e: 0, c: [ 0 ] },
  BigNumber { s: 1, e: 0, c: [ 0 ] } ]

```


# Auction

## 公开拍卖

假设一个待拍卖的产品初始价格为100，所有我们可以出任何高于100的价格来参与拍卖。

* Alice 出价200

* Bob 看到Alice 出价200，他出价245

* John看到Bob的出价，他决定出价300

* 由于没有更高的竞价，所有John赢得了这次竞拍，他只需要支付第二高的价格245


## Vickery拍卖（密封拍卖）

* Alice 将实际投标金额和一个秘钥加密，另外再附带一个200美金，所有人都能看见Alice出了500美金的竞标价格，但是不知道她实际的出标价格为200美金

> sha3($200,"secretstring")

* Bob 只能看到Alice出价500

同样，每个人都会出价他们愿意为这个产品支付的金额。

如果一个实际的出价大于公开出价金额，则会被判定为一个无效的投标。


## 公告出标价格

一旦拍卖结束，所有投标人必须透露他们的出价，为了显示出价，__投标人必须将他们的出价的金额和保密字符串发送到合约__。合约通过投标金额和保密字符计算出一个hash值，并将该hash与投标人在投标时发送的hash进行匹配。如果匹配且实际出价小于公开的出价，那么投标有效。



## 交互

* package.json　中安装依赖


> sudo npm install --save-dev ethereumjs-util


* 添加拍卖品

> amount_1 = web3.toWei(0.5,"ether")
> current_time = Math.round(new Date() / 1000)

```
EcommerceStore.deployed().then(function(i){i.addProductToStore("iWatch","Cell","imageLink","descLink",current_time, current_time+3600,amount_1,0).then(function(f){console.log(f)})})

```

* 查询拍卖的物品信息

> EcommerceStore.deployed().then(function(i){i.getProduct.call(1).then(function(f){console.log(f)})})


* 导入　ethereunjs-util

> Eutil = require('ethereumjs-util')


* 竞拍

> sealedBid = '0x'+Eutil.sha3((2*amount_1)+"hello1").toString('hex')
> EcommerceStore.deployed().then(function(i){i.bid(3,sealedBid, {value:5*amount_1,form:web3.eth.accounts[1]}).then(function(f){console.log(f)})})


> sealedBid = '0x'+Eutil.sha3((3*amount_1)+"hello2").toString('hex')

> EcommerceStore.deployed().then(function(i){i.bid(4,sealedBid, {value:3*amount_1,form:web3.eth.accounts[2]}).then(function(f){console.log(f)})})


> sealedBid = '0x'+Eutil.sha3((4*amount_1)+"hello3").toString('hex')

> EcommerceStore.deployed().then(function(i){i.bid(2,sealedBid, {value:4*amount_1,form:web3.eth.accounts[3]}).then(function(f){console.log(f)})})


* 查看账户余额

> web3.eth.getBalance(web3.eth.accounts[1])

> web3.eth.getBalance(web3.eth.accounts[2])

> web3.eth.getBalance(web3.eth.accounts[3])

Note:　

* 拍卖开始时间：current_time　和　拍卖结束时间：current_time+3600　需要注意，确保　bid 是在拍卖结束前调用，不然会出现异常。

* 在truffle develop中测试的，在Mac上竞拍(bid)正常，在ubuntu上(bid)老是出现 EVM 异常。

* 如果代码测试异常时，除了语法和逻辑错误，还应该多换换测试环境 




































