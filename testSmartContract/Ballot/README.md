在现实生活中，投票是一个最能体现公平民主的机制，而且有广泛的应用场景。但是以往的投票过程，都或多或少存在着人为干预的风险，而区块链提供了公开透明、不可篡改的技术保障，使得利用区块链技术进行投票有着天然的可靠性。

以太坊官方也给出了一个针对投票的智能合约示例Ballot。Ballot合约是一个十分完整的投票智能合约，这个合约不仅支持基本的投票功能，投票人还可以将自己的投票权委托给其他人。虽然投票人身份和提案名称是由合约发布者制定的，不过这不影响投票结果的可信度。这个合约相对比较复杂，也展示出了一个去中心智合约运作的很多特性。


## 合约测试


* 新建或打开以太坊测试网络

> geth --datadir testNet --dev console

* 确保每个账户都有一定量的以太币（投票时需要消耗gas）

* 将web3Deploy中的内容copy到终端中，并回车
  
  默认是web3.eth.accounts[0]账户部署合约
  

* 终端输入ballot即可查看合约的abi

 ballot

{
  abi: [{
      constant: false,
      inputs: [{...}],
      name: "vote",
      outputs: [],
      payable: false,
      stateMutability: "nonpayable",
      type: "function"
  }, {
      constant: false,
      inputs: [],
      name: "winningName",
      outputs: [{...}],
      payable: false,
      stateMutability: "nonpayable",
      type: "function"
  }, {
      constant: false,
      inputs: [{...}],
      name: "delegate",
      outputs: [],
      payable: false,
      stateMutability: "nonpayable",
      type: "function"
  }, {
      constant: true,
      inputs: [],
      name: "winningProposal",
      outputs: [{...}],
      payable: false,
      stateMutability: "view",
      type: "function"
  }, {
      constant: false,
      inputs: [{...}],
      name: "giveRightToVote",
      outputs: [],
      payable: false,
      stateMutability: "nonpayable",
      type: "function"
  }, {
      inputs: [{...}],
      payable: false,
      stateMutability: "nonpayable",
      type: "constructor"
  }],
  address: "0x33bbec8590741e743394d1df6a0bf90dc9ddd6d8",
  transactionHash: "0x02a92e25437c83bd792348b3f3acfa8362df32d200d6218dfebc50772022952c",
  allEvents: function(),
  delegate: function(),
  giveRightToVote: function(),
  vote: function(),
  winningName: function(),
  winningProposal: function()
}

* 分配投票权
> ballot.giveRightToVote(eth.accounts[1],{from:eth.accounts[0]})
> ballot.giveRightToVote(eth.accounts[2],{from:eth.accounts[0]})
> ballot.giveRightToVote(eth.accounts[3],{from:eth.accounts[0]})
> ballot.giveRightToVote(eth.accounts[4],{from:eth.accounts[0]})

* 投票

> ballot.vote.sendTransaction(1,{from:eth.accounts[1]})
> ballot.vote.sendTransaction(2,{from:eth.accounts[2]})
> ballot.vote.sendTransaction(3,{from:eth.accounts[3]})
> ballot.vote.sendTransaction(1,{from:eth.accounts[4]})

* 查看获胜提案

> ballot.winningProposal.call()

