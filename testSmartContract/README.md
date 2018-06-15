该文档主要为合约LBJ功能的测试

# Geth中部署LBJ合约

* 将LBJ.sol放入[Remix](https://ethereum.github.io/browser-solidity/#optimize=false&version=soljson-v0.4.24+commit.e67f0147.js)中,然后编译并且查看Details，并复制WEB3DEPLOY中的内容，最后为WEB3DEPLOY中涉及到的变量赋值。


# Geth启动以太坊LBJ测试网络

> geth --datadir ./LBJ --dev console


# LBJ合约中相关方法的说明和测试

* function transfer(address to, uint256 value) public
　　
　转移value金额代币到地址to，该方法的msg.sender　为部署合约的外部账户地址，即 from: web3.eth.accounts[0]
 
  例如eth.accounts[1]账户转移　10000000 金额的XFORG

　　>lbj.transfer.sendTransaction(eth.accounts[1],10000000,{from:eth.accounts[1]})

* function approve(address _spender, uint256 _value) returns (bool success)

该函数可以看做账户对合约的一种授权，其主要完成下面操作。

> allowance[msg.sender][_spender] = _value


> lbj.approve.sendTransaction(eth.accounts[0],10000000,{from:eth.accounts[1]})

msg.sender（eth.accounts[1]）授权eth.accounts[0]（即合约）最多可以转移　10000000　金额的 XFORG


* function transferFrom(address from, address to, uint256 value) public returns (bool success)

账户１解锁：

> personal.unlockAccount(eth.accounts[1])


转账：

> lbj.transferFrom.sendTransaction(eth.accounts[1],eth.accounts[2],12345,{from:eth.accounts[0]})

* function burn (uint256 _value) public returns (bool success)

> function burn (uint256 _value) public returns (bool success)


* function burnFrom(address from, uint256 value) public returns (bool success)

从指定账户中销毁　value　金额的XFORG

解锁账户１

> personal.unlockAccount(eth.accounts[1])

从账户１中销毁一定量的代币

> lbj.burnFrom.sendTransaction(eth.accounts[1],111111,{from:eth.accounts[0]})














