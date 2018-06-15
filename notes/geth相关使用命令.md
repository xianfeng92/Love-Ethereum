
## geth

我们可以通过Geth创建的私有网络，是一个非常适合开发、调试和测试的网络。

优点：

* 方便开发者深入理解以太坊的技术底层
* 因为节点相对较少，速度较快
* 用户可以随时创建，随时销毁，随时重建一个以太坊网络
* 随意的增加节点数目，或者删除节点，
* 既可以在服务器上建立，也可以在自己的windows或者Mac机器上建立，
* 甚至一台机器可以建立多个节点，在一台机器上实现多节点的私有网络。

缺点

* 因为不是全球化的，只有在私有网络内的节点才能查看智能合约的执行、调用等。


## geth控制台- 启动、退出

* 最简单启动方式如下

> geth console

geth控制台启动成功之后，可以看到>提示符,退出输入exit。

* 启动一个开发模式测试节点

> geth --datadir testNet --dev console

* 连接geth节点

> geth attach ipc:/some/custom/path
> geth attach http://191.168.1.1:8545
> geth attach ws://191.168.1.1:8546

如果想要连接刚刚打开的开发模式节点使用：

> geth attach ipc:/testNet/geth.ipc

## geth 日志控制

* 重定向日志到文件


使用geth console启动时，会在当前的交互界面下时不时出现日志。可以使用以下方式把日志输出到文件。

> geth console 2 >> test.log

还可以新开一个命令行终端输入以下命令查看日志：

> tail -f test.log


* 重定向另一个终端

也可以把日志重定向到另一个终端，先在想要看日志的终端输入：

> tty

就可以获取到终端编号，如：/dev/ttys003
然后另一个终端使用：

> geth console 2 >> /dev/ttys003

启动geth, 这是日志就输出到另一个终端。

如果不想看到日志还可以重定向到空终端：

> geth console 2 >> /dev/null


日志级别控制

使用--verbosity可以控制日志级别，如不想看到日志还可以使用：

> geth --verbosity 0 console



## 启动本地多节点连接集群

为了启动多个节点，需要先确保:

* 每个节点都有不同的--datadir
* 每个节点要运行在不同的端口，使用--port及--rpcport控制
* 每个节点ipc唯一或禁用ipc，使用参数--ipcpath或--ipcdisable
* 节点需要需要建立连接

先启动第一个节点

> geth --datadir="test1" --ipcdisable --port 30301 --rpcport 8101 console 2>> test1.log

在另一个终端开启另一个节点：

> geth --datadir="test2" --ipcdisable --port 30302 --rpcport 8102 console 2>> test2.log


分别查看节点信息

> net.peerCount
0

> admin.nodeInfo.enode

"enode://2f7683398c1......@192.168.1.3:30301"

使用admin.addPeer建立连接：

> admin.addPeer("enode://2f7683398c1......@192.168.1.3:30301")

true

参数是另一个节点的enode，返回true，说明成功建立连接。

再次查看节点数量:

> net.peerCount

1


## geth各种模块的命令（API）

我们打开一个控制台后, modules代表了所有可以使用的模块：

> modules: admin:1.0 clique:1.0 debug:1.0 eth:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 shh:1.0 txpool:1.0 web3:1.0

在交互式命令行里输入任何一个模块名，就会列出所有支持的属性和函数，如输入：

> admin
{
  datadir: "/home/zhongxianfeng/test1",
  nodeInfo: {
    enode: "enode://8b969cc7a558c5b73b7a09d8d4ce7959e1db964f2257a38bd2203a52977550185fd22b842efe62b73a0bf16c1276856c965946ffbc994058c08d2f78747847fe@[::]:30301",
    id: "8b969cc7a558c5b73b7a09d8d4ce7959e1db964f2257a38bd2203a52977550185fd22b842efe62b73a0bf16c1276856c965946ffbc994058c08d2f78747847fe",
    ip: "::",
    listenAddr: "[::]:30301",
    name: "Geth/v1.8.10-stable-eae63c51/linux-amd64/go1.10",
    ports: {
      discovery: 30301,
      listener: 30301
    },
    protocols: {
      eth: {
        config: {...},
        difficulty: 17179869184,
        genesis: "0xd4e56740f876aef8c010b86a40d5f56745a118d0906a34e69aec8c0db1cb8fa3",
        head: "0xd4e56740f876aef8c010b86a40d5f56745a118d0906a34e69aec8c0db1cb8fa3",
        network: 1
      }
    }
  },
  peers: [{
      caps: ["eth/63"],
      id: "495b2f5d604367a484f0946b678c62e519ecc88d84842c01d232c551d7584b19f6bad215cfc94a4916989e0682900bc344302ad234c8afd741a3b9d704a70782",
      name: "Geth/v1.8.10-stable-eae63c51/linux-amd64/go1.10",
      network: {
        inbound: false,
        localAddress: "[::1]:57272",
        remoteAddress: "[::1]:30302",
        static: true,
        trusted: false
      },
      protocols: {
        eth: {...}
      }
  }],
  addPeer: function(),
  clearHistory: function(),
  exportChain: function(),
  getDatadir: function(callback),
  getNodeInfo: function(callback),
  getPeers: function(callback),
  importChain: function(),
  removePeer: function(),
  sleep: function github.com/ethereum/go-ethereum/console.(*bridge).Sleep-fm(),
  sleepBlocks: function github.com/ethereum/go-ethereum/console.(*bridge).SleepBlocks-fm(),
  startRPC: function(),
  startWS: function(),
  stopRPC: function(),
  stopWS: function()
}






















