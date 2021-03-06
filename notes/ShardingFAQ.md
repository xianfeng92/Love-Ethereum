## 简介

目前，在所有的区块链协议中每个节点都会存储所有的状态（账户余额，合约代码和存储等）和处理所有的交易。这提供了很高的安全性，但极大的限制了可扩展性：区块链不能处理比一个单节点更多的交易。因此，比特币被限制在每秒3-7笔交易，以太坊每秒7-15笔交易，等等。这也向我们抛出了了一个问题：是否有方法创建一个新的机制，只让一部分的节点来验证每笔交易？只要有__足够多的节点__（验证节点集合）验证每笔交易那么系统依然是高度安全的，然后这些__验证节点集合__数量相比总节点数又足够的小。这样系统就可以并行处理很多的交易，我们是否可以使用这种技术来增加区块链的吞吐量？

### 目前有哪些方案可能会解决这个问题？

目前，主要有三种可能的解决方案。

第一种方案是不考虑单个区块链可扩展性，而是假设用户会使用许多不同的”altcoins"。这种方法极大提升了吞吐量，但是是以安全性为代价：使用这种方案在在吞吐量上N-factor的增加必然伴随在安全性上N-factor的下降。Hence, it is arguably non-viable for more than small values of N。

第二中方案是简单增加区块大小限制。这种方式可以起作用，而且在某些情况下可能是正确的处理方法，因为区块链大小可能更多受到政治上的约束而不是现实的技术的约束。但无论一个人对任何个案的看法如何，这种方法都不可避免地有其局限性：如果考虑的长远一点，那么在普通用户硬件上运行的节点将会退出，区块链网络的运行将开始完全依赖于极少数超级节点，这可能导致中心化风险。

第三种是“合并挖矿”，这是一种多条链共享挖矿算力（在POS中，即股权）的技术。目前，Namecoin通过这样做从比特币区块链中获得了很大一部分安全性。如果所有矿工都参与其中，理论上这可以在不影响安全性的情况下将吞吐量提高N倍。然而，这也存在这样的问题：它将每个矿工的计算和存储负荷增加了N倍，因此实际上这种解决方案只是块大小增加的隐形形式。

即使这被认为可以接受的，但依然存在这样的缺陷：这些链不是真正被“捆绑在一起"的；只需要少量的经济激励就能说服矿工放弃或妥协某个特定的链。这种可能性是非常真实的，并且有合并挖矿被攻击的[真实历史事件](actual historical incidents)，以及明确提倡使用合并挖掘攻击作为“治理”特性的开发人员，破坏对给定联盟而言并非“有利可图”的链。

如果只有少数矿工/矿池参与合并挖矿，那么集中化的风险即将来临，而合并挖矿的安全效益也会大大降低。

## 区块链的DSS(Decentralization, Scalability, Security)不可能原理

区块链的DSS不可能原理表明区块链系统最多只能拥有以下三个属性中的两个：

* Decentralization :定义为系统能够在每个参与者只能访问O(c)资源的场景中运行，即普通笔记本电脑或小型VPS

  从参与区块链的“门槛”来定义中心和去中心化

* Scalability : 定义为能够处理O(n)>O(c)交易

　系统处理交易的吞吐量是否能够大于单节点的吞吐量

* Security :　定义为对具有高达O(n)资源的攻击者是安全的
　　
　系统是否能够抵抗一定算力的攻击

在文档的剩余部分，我们将继续使用c来指代__每个节点可用的计算资源__（包括计算，带宽和存储）的大小----算力，n在某种抽象意义上指代__生态系统的大小__; 我们假设交易负载，状态大小和加密货币市值都与n成正比。

### 有人认为，由于梅特卡夫定律，一个加密货币的市值应该与n ^ 2成正比，而不是n。他们是正确的吗？

不。

为什么不？

梅特卡夫法则认为，网络的价值与用户数量的平方成正比（n ^ 2），因为如果网络有n个用户，那么网络对每个用户都有价值，但是每个用户的价值是与用户数量成正比，因为如果一个网络有n个用户通过网络有n-1个潜在的连接，每个用户都可以从中受益。

在实践中，实证研究表明，拥有n个用户的网络的价值”对于小的n值是与n ^ 2成比例且对于大的n值是与n×log n成比例“。这很容易理解，因为对于小的n值，这个论点是成立的，但是一旦这个系统变得很大，两个影响就会减缓增长。首先，实践中的增长通常发生在社区中，因此在中等规模的网络中，网络通常已经提供了每个用户关心的大部分连接。其次，连接往往是可以互相替代的。你可以争论说人们从k个连接中只能获得~O(log(k))的价值-有23个品牌的除臭剂可以选择是好的，但并不不是说比有22个选择好多了，而一个选择和零个选择是非常重要的差异。

另外，即使加密货币的价值与k个用户的O(k * log(k))成正比，如果我们接受上述解释作为这种情况的原因，那这也意味着交易量也是O(k * log(k))，因为每个用户的log(k)价值理论上来自于用户通过网络执行log(k)的连接，并且状态大小在许多情况下也应该随着O(k * log(k)) 一起增长，因为至少有某种类型的状态是特定关心而不是用户特定的。因此，假设n=O(k * log(k)) ，并且基于n(生态系统大小)和c（单节点的计算能力）是我们使用的完美模型。


### 有哪些可以部分解决可扩展性问题的方法？

许多分片提议（例如，新国立大学Loi Luu等人提出的早期BFT分片提案，现方案在Zilliq项目中使用，以及比特币建议的这种Merklix tree1方法）尝试仅进行分片交易处理或仅状态分片，而不考虑其它方面。这些努力令人钦佩，可能会带来一些效率提升，但根本问题是他们只解决了两个瓶颈中的一个，我们希望能够每秒处理10,000多个事务，而无需强制每个节点成为超级计算机或强制每个节点存储数TB的状态数据，这需要一个全面的解决方案，其中状态存储，交易的处理甚至交易信息下载和重新广播都是跨节点。

特别要注意的是，这要求在P2P级别做出变更，因为广播模型是不可扩展的，因为它要求每个节点下载和重复广播O(n)的数据（每个被发送的交易），而我们去中心化的标准假设是每个节点只能访问各种O(c)资源。

### 除了分片，还有那些方法？

Bitcoin-NG 可以通过另外一种区块链设计来增加扩展性，即使得节点花费大量CPU时间验证区块来使得网络更安全。在简单的PoW区块链中，存在较高的中心化风险，并且如果阀值增长到节点的CPU时间超过5%用于验证块则共识安全就会被削弱；Bitcoin-NG的设计缓解了这个问题。然而，这仅仅使得交易扩展性提升了大约常量因子5-50，但并没有提升状态扩展性。也就是说，Bitcoin-NG式的方法与分片并不互相排斥，两者当然可以同时实施。

基于通道的策略（闪电网络，雷电网络等）可以通过__常量因子扩展交易容量，但不能扩展状态存储__，并且还会带来他们自己独特的折衷和限制，特别是涉及到拒绝服务攻击；__通过分片实现链上扩展（加上其他的技术）和通过通道实现链下扩展可以说是必要和互补的__。

还有其他一些使用高级密码学的方法。如Mimblewimble 和基于ZK-SNARKs的策略来解决扩展性的部分问题。初始化全节点同步，而不是从创世块验证整个历史，节点可以验证一个密码学证明当前状态合法地遵循历史记录。这些方法确实解决了合法性问题，但是值得注意的是，可以依靠加密经济学用更简单的方式而不是纯粹密码学来解决同样的问题-参见以太坊当前fast syncing 和 warp syncing的实现。这两种方法都没有缓解状态大小的增长或者在线交易处理的限制。

### Plasma, state channels 以及其它第二层扩展方案是如何应对区块链DSS问题?

如果对 Plasma 子链发起大规模攻击，则Plasma子链的所有用户的状态都需要回退根链（主链）。如果Plasma有O(N)个用户，那么这个回退将需要O(N)个事务，因此O(N/C)时间来处理所有回退。如果回退延迟固定为D，那么只要 D < N/C，区块链就没有足够的空间来及时处理所有的回退，因此系统将是不安全的; 在这种模式下，Plasma应被视为常数因子级别(可能很大的）可扩展性的提高。如果回退的延迟是不固定的，那么如果有很多提款，它们会自动延长，那么这意味着随着N的进一步增加，攻击者可以强制每个人的资金被锁定的时间增加，所以等级系统的“安全性”在某种意义上进一步降低，因为扩展的拒绝访问可被视为安全性失败，尽管比完全失去访问权限要轻一些。然而，这是与其他解决方案进行权衡的不同方向，并且可以说是更温和的权衡，因此，为什么Plasma子链仍然是对现状的大幅改进。

state channel　具有相似的属性，但在多功能性和finality速度之间有不同的权衡。其他第2层扩展性技术包括TrueBit执行的离线交互式验证和Raiden，后者是另一个在state channel上工作的组织。与Casper（第1层）的股权证明也将提高可扩展性 - 它更加去中心化。

sharding 不同于state channel和 Plasma，因为周期性公证人被伪随机分配来对collations(分片中验证节点产生的块)的有效性进行投票，通过主链验证投票后，这些collations被存储到主链中 。在阶段5， 分片与主链紧密耦合，因此如果任何分片或主链无效，则整个网络都是无效的。每种机制之间还存在其他差异，但在较高层次上，Plasma，state channel和Truebit可以在无限期间内脱链，通过智能合约连接到主链。而分片则是通过协议定期连接到主链。


## 状态大小，历史，加密经济学等相关术语

* 状态：表示系统“当前状态”的一组信息; 在最简单的模型中，决定交易是否有效以及交易的效果应该仅取决于状态。包括比特币中设置的UTXO，以太坊中的余额+随机数+代码+存储以及Namecoin中的域名注册表条目。这些都是状态数据的例子。

* 历史：自创世区块以来发生的所有交易的有序列表。 在一个简单的模型中，当前状态应该是由创世区块的初始状态和交易来确定。

* 事务：an object that goes into the history。 实际上，交易表示某个用户想要进行的操作，交易信息是被加密签名的。在一些系统中，交易被称为blob，以强调这样的事实：在这些系统中，这些对象可能包含任意数据，并且可能并非在所有情况下都表示在协议中执行某些操作。

* 状态转换函数：接受状态参数，执行交易并输出新状态的函数。涉及到的计算可能涉及从交易指定的账户中增加和减去余额，数字签名的验证以及合约代码的执行。

* Merkle树：一种加密哈希树结构，可以存储大量数据，其中对每个单独的数据进行身份验证只需要O(log(n))空间和时间。在以太坊中，每个区块中的交易以及状态都保存在Merkle树中，其中树的根值是存储在区块头中。

* 收据：代表交易执行结果的对象，它并不存储在状态中，但存储在一个默克尔的收据树中并提交到区块，以便节点在没有拥有所有数据的情况下可以高效验证收据。在以太坊中Logs就是收据。在分片模型中，收据可以用来异步跨分片通信。

* 轻客户端：与区块链交互的一种方式，它只需要非常少量的计算资源，默认情况下只需要跟踪链的区块头，并根据需要请求关于交易，状态和收据的相关信息，并验证相关数据的默克尔证明。

* 状态根：代表状态的默克尔树根哈希。

## 分片背后的基本思想？

把状态分成　K = O(n / c)　分区，我们称之为”分片“。例如，以太坊的分片方案可能会将所有0x00开头的所有地址放入一个分片，所有以0x01开头的地址放入另外一个分片等等。在最简单的分片形式中，每个分片都有自己的交易历史，且在某个分片k中的交易影响仅限于分片k的状态。一个简单的例子是多资产区块链，其中有k个分片，每个分片存储余额和处理一个特定资产相关的交易。在更高级的分片形式中，包括了某些形式的跨分片通信能力，其中一个分片上的交易可以触发其他分片上的事件。


## 分片区块链的基本设计是怎么样的？

为简单起见，此设计仅跟踪数据blob，不会尝试处理状态转换函数。

分片的区块链中的　proposers(提议者)节点，其会与　shard k　关联起来（取决于协议，proposers要么主动选择　shard　k，要么是随机分配到　shard　k），proposers　可以创建　collations（该　shard k　中的所有交易），因此它们也充当collator。每个collations都有一个collation header，其形式为“这是shard k上的blob，父 collation 为0x7f1e74，Blob的Merkle根为0x3f98ea”的消息。每个分片中的collation的连接起来就会形成一个链。

分片的区块链中还有一些　notaries　（公证人）的角色，他们可以下载和验证分片中的　collations，他们所验证的分片是随机分配的，并且每个时间段通过random beacon chain（随机信标链）将它们　shuffled（分配）到新的分片中（使用一些可验证的随机函数，例如BLS聚合签名产生的阻塞或 RANDAO，虽然后者已被测试为易于操纵）。这些　notaries　会对　shard 中的　collations　数据的可用性进行投票（使用EVM，他们也可以充当执行者并对数据的有效性进行投票）。

然后，committee　还可以检查notaries（公证人）的这些投票，并决定是否在将　collation header 记录到主链中 ，从而建立与分片中　collation　的交叉链接。 其他方可以向委员会，公证人，提名人，验证人（Casper of Stake of Stake）等提出质疑，例如：使用交互式验证游戏，或通过验证有效性证明。如果对区块信息存在质疑，可以向　committee，notaries，proposers，验证人（Casper　Proof of Stake）等提出质疑。

每个人仍然处理的“主链”，但是这个主链的作用仅限于存储所有分片的collation headers（校对头）。 shard k的“规范链”是shard k上有效归类的最长链，其所有标题都在规范主链内。shard k的“canonical chain”是shard k上有效collations的最长链，其所有headers都在canonical chain内。

这分片区块链系统中存在如下几种节点：

* Super-full node : 下载每个分片以及主链的每个 collations，会验证所有内容

* Top-level node ：　处理所有主链块，为主链块提供对所有分片的“轻客户端”访问
会
* Single-shard node : 充当Top-level node，但也下载并验证它关心的某些特定 shard 上的每个 collation

* Light node : 仅下载和验证主链块的块头; 不会处理任何归　collation　header 或 交易，除非它需要读取某些特定分片状态下的某些特定条目，在这种情况下，它会将Merkle分支下载到该分片的最新collation　header，并下载在该状态下的默克尔证明的期望值。


## 分片的实现上还有哪些挑战？

* 单一分片的攻击

如果攻击者在一个单独的分片中控制了大多数　notaries（公证人）或者 prolators（说明者），其就可以阻止任何
collation　获取足够的签名，或者提交无效的　collation。

* 状态转换执行 

单一分片攻击通常可以通过随机抽样方案来防止，但是此类方案也使得安全人员更难以计算状态根，因为他们无法获得被分配到的每个分片的最新状态信息。我们如何确保轻客户仍能获得有关状态的准确信息？

* 欺诈检测 

如果确实进行了无效的 collation 或状态声明，如何能够可靠地通知节点（包括轻节点），以便他们可以检测到欺诈并拒绝无效的　collation？

* 跨分片通信 

上述设计不支持夸分片通信，我们如何安全地添加跨分片通信？

* 数据可用性问题 

作为欺诈检测的一个子集，对 collation 中缺少数据的情况如何处理？

* 超级二次分片 

在 n>c^2 的情况下，在上面给出的简单设计中，将有多个 O(c) 校对头，因此普通节点甚至不能处理 the top-level blocks。 因此，交易　和　the top-level blocks　之间需要两个以上的间接级别（即我们需要“分片的分片”）。有哪些好的方法可以实现这些？


但是，交易可能也受之前在其他分片中发生的交易的影响。一个典型的例子是货币转移，首先创建一个“借据”交易来减少分片i中的货币，然后再创建一个在分片j中增加货币的“信用”交易，指向“借据”交易创建的收据作为“信用”交易的合法想性证明。


## CAP定理是否意味着完全安全的分布式系统是不可能的，因此分片也是无用的？

CAP定理是有关分布式共识的结果。一个简单的陈述是：“在发生网络分区的情况下，你必须选择一致性或可用性，你不能同时拥有它们”。直观的论点很简单：如果网络存在两个分区，在一个分区我发送交易“发送我的10个硬币到A”，在另一个分区我发送交易“发送我的10个硬币到B”，这时候系统将不可用，因为一个或两个交易将不会被处理，或者变得不一致，因为网络的一个分区将看到第一个交易完成，另一分区将看到第二个交易完成。注意CAP定理与可扩展性无关。它适用于多个节点需要就某个值达成一致的任何情况，无论其数据量如何。所有现有的分布式系统都在可用性和一致性之间找到了一些妥协；在这方面，分片不会使任何事情变得更加困难。


## 我们正在运行的安全模型是什么？



------------------------------------------

## 翻译也有很多地方不理解，欢迎讨论～


未完......












