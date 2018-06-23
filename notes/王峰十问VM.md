## Q 10

### Question 1，On June 15th, you mentioned at the Ethereum Core Devs conference that the development team behind Ethereum was considering possible changes to a planned rollout of new technology upgrades. The idea is that the team might seek to alter the sequence in which Casper and sharding, perhaps its two most-anticipated updates, are activated.

W:__Casper__, different from other POS mechanisms, is a new POS mechanism that has been brewing for a long time in Ethereum. By implementing the Casper protocol, Ethereum is able to quickly punish a node’s malicious behavior. __Sharding__ is a scale technology based on the traditional concept of database sharding.In my opinion, you are likely to activate Ethereum’s biggest upgrades under a combined protocol. But, just as a coin has two sides, the new design might enhance the scalability of Ethereum.

V:It's not an alteration of the sequence, it's an alteration of the strategy.The original plan was to create Casper as a smart contract on ethereum, to make the design as easy to build as possible, and at the same time continue working on sharding. However, at this point we have made enough progress on full proof of stake and sharding that continuing along that roadmap would lead to a worse product and a lot of wasted effort. We would have to build the first version of Casper and almost immediately throw it out.The new roadmap is still "Casper then sharding", but the first version of Casper is modified so that it is "along the way" to a full Casper and sharding implementation.There are other benefits; for example, we are looking at using __BLS aggregation__ in the short term, and __STARKs__ in the long term, for signature aggregation, which is an optimization that allows the Casper mechanism to process many more validators, which is what allows us to reduce the minimum validator size from 1500 ETH to 32 ETH.The core idea behind Casper is to combine together chain-based proof of stake with ideas from __traditional Byzantine fault tolerance (BFT)__ research, like Lamport, Paxos, PBFT, etc. Many asked us, why not just use those traditional algorithms directly? However, we believed that those algorithms are both too complicated and not well suited to the format and needs of a blockchain, and so we studied the algorithms and created a version that we believe is simpler and more suited for a blockchain context.

O:How is the __data availability issue__ you mentioned in the past  get solved or circumvented?

V:The data availability issue ( see https://github.com/ethereum/research/wiki/A-note-on-data-availability-and-erasure-coding ) is one of the more challenging problems in sharding, and one that I find many other projects, especially those with a cryptographic mindset, tend not to take seriously enough.


W:We are familiar with the early POW and POS mechanisms; but could you please kindly explain the working principle of the Casper mechanism in a simple way once again?


V:The basic idea behind the current Casper implementation is that users can send 32 ETH into a smart contract, and then once they are included in the blockchain they are added to the current validator set. Every block is created by a random member of the current validator set, and every 100 blocks the entire validator set needs to send a message __"finalizing"__ some checkpoint.

W:When it comes to Casper, I consulted a public blockchain designer. He said, why would they design Casper to prevent small miners’ verification rights in the Ethereum ecosystem by using the safe deposit? Currently, if you are an independent miner of BTC or ETH, you still have a chance to mine a block. However, under Casper’s design principle, small miners will not be able to verify a block. Does this mean that Casper may bring an uneven playing field and create more privileged nodes? @Vitalik Buterin

V:I would say not true anymore.First of all, 32 ETH is ~100,000 CNY; I don't think it's practical to be a PoW miner with less than that in any case, since PoW mining requires economies of scale. And even with less than that amount, you can always join a pool.


O:is there any restriction to become validator?  an extreme case: the rich people can easily have majority validators to control the shard even with random sampling. there must have critical security issues.

V:We expect there to be around 10,000,000 ETH staking in total, so taking over an entire shard requires at least ~40% of that, so it is very expensive. There are also ways to recover from attacks even in such cases.

### Question 2，Many people in the blockchain industry believe that 2018 will be a key year for blockchain applications. At the ‘2018 Conference on Ethereum Technology and Applications’, you mentioned that blockchain technology will be used in the financial industry firstly, and then in the gaming industry, identity authentication, value chain, and other industries will try this emerging technology.2018 is half way over, so why haven’t we seen blockchain applications widely adopted? What do you think are the most important factors preventing large-scale applications of blockchain?@Vitalik Buterin

V:Yes, I think that the financial industry and gaming are naturally the first two. In the financial case, the reason is that financial technology is generally harder to use and very "behind the times" compared to other forms of digital technology. Why can't I send money halfway across the world as easily as sending an email? I know within China sending money is fairly efficient, but in many places there are still no widely adopted good ways to just send money from one person to another online, and sending money across borders is hard everywhere. Gaming is a case where there are many companies interested in creating markets for in-game assets and this is an area that many people seem to be interested in.

Going beyond that, I think the main thing that blockchains can provide in other industries in the short term is interoperability. There are benefits from having a common platform where all providers of some service can interoperate with each other, so that users of one can more easily interact with users of another, but there are also very large benefits to being able to doing this without creating a centralized monopoly. There are examples of this in finance (eg. what OmiseGO is doing, also AMIS in taiwan), and I expect to see similar concepts in other industries as well.The main challenge with getting blockchain tech adopted in other industries is that the existing level of inefficiency is lower, and so it's more difficult to convince people to accept the inconveniences of current public blockchains like long confirmation times and high transaction fees.

W:__Yup, In some people’s point of view, there are only a few application scenarios for blockchain, such as cryptocurrency exchanges and ICOs. To be honest, many DAPPs don’t have very good design or practical usage__. Would you like to give any advice to the developers in the Ethereum ecosystem?@Vitalik Buterin

V:I think state channels will do a lot in the short term to make dapps with better user experience and scalability simpler to build; Jeff Coleman from L4 and others have been doing a lot recently to make state channel tech more standardized and easier to use. They recently published a state channels paper (http://counterfactual.com/statechannels). Plasma will help with scalability, and I think Plasma could be particularly helpful for enterprise use cases, as it allows applications to be built in a half centralized half decentralized way, where they can benefit from the blockchain's safety but still get the efficiency of a centralized system.

O: can you elaborate the __plasma__ for enterprise solution?

V:Basically, an enterprise entity (or potentially even government, eg. central bank) can create a plasma contract (specifically, Plasma Cash: https://ethresear.ch/t/plasma-cash-plasma-with-much-less-per-user-data-checking/1298), and they can operate their centralized service (eg. a currency system, an exchange) as a Plasma chain. They only need to publish one transaction to the public blockchain perhaps every minute, and an unlimited number of transactions can happen on the server side, fairly similarly to the traditional centralized way. But the server also sends each user Merkle proofs which allow them to verify their own history, and if the server ever goes down or gets hacked, the users will be able to tell, and the Plasma contract will guarantee that they will be able to move their assets into an Ethereum-based ERC20, and possibly migrate to a different Plasma chain. I'm already talking to a group in Russia that's interested in using this approach.One challenge that I see with that model is that if you create a general-purpose system, then because of Turing completeness you know that the system will still be general purpose in 20 years, and so still usable in 20 years. If you create a special-purpose system for some industry, on the other hand, the needs of that industry change rapidly, and so the specification of the protocol would need to change every few years, forever. This is not very good for a base layer public chain, because it puts a lot of load on the governance mechanism to keep agreeing on new protocol rules, which leads to centralization. However, I *do* think industry-specific Plasma chains have potential.

W:follow up,      let us open our minds and envision the future, does the idea ever cross your mind that smart contracts might be the wrong direction for the development of blockchains? Haha, I cannot believe I am asking you this question at this point

V:I think many people misunderstand smart contracts. There is an impression that smart contracts are for doing things like "I pay you 10 ETH to build a website, so I put the 10 ETH into a smart contract. The smart contract detects if you built the website, and automatically pays the 10 ETH if it detects that the website is finished".The problem with this approach is of course that verification is too difficult; a piece of smart contract code by itself cannot tell if something is a website.The right way to think about smart contracts is as economic mechanisms; they do not do everything by themselves, rather they set rules by which different parties can interact with each other, and some of those parties can be arbitrators, or potentially you can use game theory to create smart contracts that create good incentives even without any arbitrators. For example, there is an idea called 2-of-2 escrow, where if there is a dispute both people's money gets burned. This seems harsh, but it does create a strong incentive for both parties to act honestly, even in the absence of an arbitrator to determine who in a dispute was right or wrong.

### W:Question 3，At 2:11 AM on June 15, the Mainnet of EOS was successfully launched. EOS hopes to solve the problems of latency and data throughput by using parallel chain and DPOS. From the perspective of performance, it seems that EOS has "surpassed" Bitcoin and Ethereum. I notice that.I read the EOS whitepaper and found that BM (Dan Larimer) defined EOS as ‘Blockchain 3.0’.[偷笑] It is interesting to see that many people in the blockchain industry have the following idea：

BTC = Blockchain 1.0；
ETH = Blockchain 2.0；
EOS = Blockchain 3.0

Do you agree with it? What is Blockchain 3.0 in your perspective? [呲牙]

V:I don't really like talking in terms of 1.0, 2.0, 3.0 these days, but if there is such a thing as blockchain 3.0 then scalability is definitely a big part of it. I know that EOS's performance is higher than that of bitcoin and ethereum but I believe not too much harder; I recall hearing a few hundred TPS on some recent testnet. Ultimately, I do strongly believe that achieving the kind of scalability that is needed for large-scale applications needs much more than just throwing more computing power at the problem; it requires fundamentally new approaches and a lot of thinking to implement them. This is why I think the work on state channels, plasma and sharding is so valuable.EOS is definitely an interesting experiment, one that is trying to do things very differently from ethereum and other platforms. It's not just a technical experiment; it's also a political science experiment, as they are attempting to create a kind of digital government in cyberspace on their blockchain, with a constitution, an executive branch (the 21 delegate nodes), a judicial branch (arbitrators), etc, and it is a very explicit part of their philosophy that "code is not law" and this digital government is expected to very actively solve people's problems.That said, this kind of approach is risky, and so I expect there to be many applications that find it too risky and are interested in blockchains precisely because they want a platform that is safer and more difficult to change. EOS already froze 7 accounts, and very quickly without warning; this can certainly help people recover from theft and scams, but it poses challenges. What happens when you try to build an application on EOS, which the EOS establishment does not like? EOS itself was able to run its ICO and its token on the Ethereum blockchain, and we had no power to stop it; do you think that the EOS arbitrators will be similarly friendly to an EOS competitor running an ICO and issuing a token on EOS? Are you *sure*?I think that one component that needs to be built that can make smart contracts work better is oracles, for providing information to smart contracts about the outside world. I know that Oraclize has been working on centralized oracles for a long time, though I am also interested in the decentralized oracle projects. Augur has a built-in decentralized oracle for determining the "true" result of some event, and there is a project called Reality Check run by Edmund Edgar in Japan that is trying to do something similar. I think this will be very valuable to making smart contracts work well when it goes live.

W:Then, the first 21 EOS Block Producers (BPs) have been elected along with the EOS Mainnet launch. But it seems that you are not optimistic about it. As you said, the 21 Block Producers are not 21 independent entities, and there may be inherent connections between the nodes. Naturally, the network may be controlled by BP monopolies. 

In order to respond to your question, BM released an article called‘The Limits of Crypto-economic Governance'to explain the original intention and purpose of the DPOS election mechanism. 

BM thinks that you are committed to find a 'black box'  for the crypto-economy, which assumes that it cannot rely on equity (chaebolism) or individuals (democratic politics) to vote. But he believes that human nature is good. The main differences between you and BM seem to lie on the basic assumptions. Would you like to respond to BM's remarks right here right now?


V:I think my philosophy is that we want base-layer blockchains to work under as wide a range of situations as possible, and it really is difficult to predict what kind of interests and values coin holders will have in the future. The reason why economic incentives are so useful is that they are a kind of lowest common denominator; no matter whether someone is rich or poor, an individual or a corporation or a robot, American or Chinese or North Korean, we know that offering incentives to them can affect their behavior and drive them to act in some way. That said, economic incentives make much less sense in environments where we have close relationships with each other and know each other well, and in those cases relying on goodwill can generally work much better. Ethereum is a base-layer blockchain platform for the world, so it cannot make assumptions about who is participating in it or who is running the proof of stake validator nodes. Applications on top of Ethereum, on the other hand, can in many cases make more assumptions and rely on approaches that are more social than economic. I think there is definitely room for decentralized platforms that look more like "platforms for a community" than "platforms for the world", though it remains to be seen whether those kinds of platforms are best built as independent platforms, or as layer 2 plasma chains on top of public blockchains like ethereum.
If a base layer blockchain runs on code, you can build layer-2 systems on top of it that bring humans back in. If a base layer blockchain includes room for high levels of human intervention, it is much more difficult for layer-2 systems on top of that to take those humans out.


W:At present, any action on the Ethereum blockchain needs to burn a certain amount of ether in GAS fees, including simple transactions, smart contracts, and even ICOs. 

However, with the increasing number of new Ethereum projects, the network usage costs are progressively. GAS fees have become an unavoidable cost for developers and smart contract creators. Some people think that GAS fees are the‘stumbling block ' in Ethereum, and are killing many projects.[流泪]

Do you think GAS fees will affect the future development of Ethereum? Do you and your team have a solution? In contrast, transaction fees on the EOS blockchain are basically free. Have you ever worried about some DApps leaving for the EOS blockchain?@Vitalik Buterin

V:Transaction fees in EOS being free is a misconception. Transaction fees are not free; rather, instead of paying transaction fees directly, you have to pay transaction fees indirectly, by holding EOS tokens instead of holding whatever other tokens you wanted to hold. I wrote a long post here about why I think this is a bad idea, and will likely eventually simply lead to a more complicated version of a fee market: https://ethresear.ch/t/against-replacing-transaction-fees-with-deposits/940.I think that ultimately the only way to make fees less of an issue is to solve scalability, so that supply can catch up to demand, and we are very actively working on that with state channels, plasma and sharding.

### Question 4，On June 14, William Hinman, the director of the Finance Department of The U.S. Securities and Exchange Commission (SEC), said that Ethereum (Ether) is not a security. Affected by this news, the price of Ethereum rose 8% to $520 on that day.

V:We definitely considered the securities law issues in early 2014; we consulted with multiple law firms and were careful to confirm that what we were doing was compliant with the laws at the time. We're happy to see the SEC recognizing that not all crypto tokens are securities. I think that from here on, regulation policy absolutely will continue to impact the progress of blockchain technology, though primarily from the point of view of applications. I think in general governments have figured out that shutting down public blockchain networks is extremely difficult, but regulating their links to the outside world, like exchanges, is substantially easier.
That said, I think it is difficult to predict the progress of regulation, because much of it will depend on how blockchains are used in practice. Finance was only the first application, there will be many others, each with their own challenges.

W:Understand, according to your tweet, digital currency is still a new asset class with extremely high volatility. The price of digital is likely to fall to near zero. You also suggested that investing in traditional assets like stocks and real estate may be the safest option. How do you assess the value of digital currency?

V:I think assessing the value of cryptocurrencies is still very difficult, which is part of why the space continues to be so chaotic with all of these new assets constantly appearing. I expect that over the next few years the industry will stabilize, and we will see fewer new tokens issued and more projects that pay more attention to providing value, and there will be more correlation between fundamental value and price.

I think we'll continue to see thousands of tokens, but hopefully thousands of good tokens [Laugh]

I personally do hope that pension funds stay out of investing in crypto on a large scale at this point; if I was a 70 year old grandma I would be very upset if I learned that my retirement plan was invested in TRON [Grin]

W:According to the latest market information, the market value of Bitcoin is around 108.8 billion dollars, and the market value of Ethereum is around 48.9 billion dollars. Is it possible for the market value of Ethereum to exceed Bitcoin in the future? Will the value of ETH be affected if the price of Bitcoin becomes 0 ？(We of course believe this possibility can basically be checked off.) Haha.

if (BTC value == 0) {
ETH value = ?;
}
@Vitalik Buterin [得意]

V:Even though the prices continue to be fairly correlated day-to-day, in such extreme cases I really don't think ETH is that dependent on bitcoin anymore. Bitcoin is just one cryptocurrency of many. And I personally am very happy that the crypto space has diversified to this point; I think it is good for decentralization and makes it more difficult to shut every cryptocurrency down when you have so many approaches trying out different technologies.

### Question 5，On June 5, Microsoft announced that it had spent $7.5 billion to acquire GitHub, an online open source and collaboration platform. Currently, GitHub, which has more than 28 million developers, already hosted 85 million repositories. 

Some people welcomed this move. But some blockchain developers felt uneasy about the deal. They believed that Microsoft has always been against the open source community by using its centralized power. In fact, Microsoft is not a friend of the open source community. 10 years ago, Microsoft was accused of secretly attacking the patent of the open source software Linux. Former Microsoft CEO Steve Ballmer even labeled Linux as a‘cancer'. Even now, Microsoft still requires Android vendors to pay Android patent fees. Therefore, many open source enthusiasts and developers believe that Microsoft is not worth trusting.

What would you say about the deal? Do you think GitHub will keep its truly independent operation in the future? @Vitalik Buterin

V:I know Microsoft has been very hostile to open source before, and I remember the early 2000s when the internet community saw them as the big evil enemy. That said, from my interactions with them and seeing their behavior more recently I feel like they have taken many steps to improve their relationship with open source. It's not perfect, but we're seeing Azure cloud computing offering Linux, more and more contributions to open source, etc etc.

I personally see no reasons to be very afraid in the short term, that said, we should definitely be vigilant to ensure that Github does not become a monopoly and that there are alternatives we can switch to if there are any issues.

### Question 6，Let’s talk about China. Your legendary stories have been widely spread in my home country. [呲牙]
I heard that you were called a fraud（骗子） when you attended a road show in the Bund of Shanghai. [偷笑]Moreover, someone told me that you were standing on the corner of the last row when people took a picture in a Shenzhen blockchain meeting. It is interesting to hear that some Chinese investors rejected your funding request. 

Could you please tell us more about your China Trip?  What were the typical points of view people had on Ethereum at that time?

V:The first China trip in 2014 was interesting; I got to meet the Chinese community for the first time. Back then there was a heavy focus on exchanges and mining; there still is to some extent, though more and more development of actual technical projects. I unfortunately did not really understand much the Chinese community's reaction then, how many people were interested, how many people thought I was a fraud, etc.When creating a radical new project, of course there will be many people who think it is crazy. Though at the same time, I understand them; there are many projects in the space that really are crazy.I think that the quality of Chinese developers in the blockchain space has definitely been improving lately; I was impressed by the quality of attendees at the event in Beijing in June. I feel the main challenge in China has been on the research side; if you look at who is inventing algorithms like proof of stake, sharding, zero knowledge proofs, etc, it is all happening mostly in the USA and Israel, and somewhat in Europe; in Asia perhaps only in Singapore. That said, I have been starting to see more academic papers coming from China recently and have hopes that the research side will improve.Yes, I do think that the best thing to do for any blockchain protocol is to switch to or use PoS. ASICs are far too centralized, and we know that right now in bitcoin one person is producing a very large portion of all the ASICs and running many of them. ASIC-resistant PoW is more decentralized, but we have seen this year that there have been attacks on ASIC-resistant coins from rented GPUs, and there is more and more evidence that maintaining ASIC resistance is very difficult, see this article from David Vorick: https://blog.sia.tech/the-state-of-cryptocurrency-mining-538004a37f9b

### Question 7，Your father Dmitry Buterin, a co-founder of an early blockchain incubator, was your first teacher to encourage you to enter the blockchain industry.  He introduced Bitcoin to you when you were 17 years old. I heard you were skeptical about Bitcoin at that time. But two years later, you decided to enter the blockchain industry. 

Do you talk to your father often about things you do now? Does he give you any suggestions? What did he say when you launched the first version of Ethereum?@Vitalik Buterin

V:He was definitely very proud when ethereum launched, and participated in the sale and got many of his friends to participate [Laugh]

He recently sold his company, Wild Apricot, and I know he is looking to do more and more things in the blockchain space now; he's already part of BlockGeeks. So we always have much to talk about [Chuckle]


W:According to a research report published by Goldman Sachs in June 2017, ICO funding exceeded the total amount of early VC investments. Meanwhile, this brand-new funding model inspired a global wealth effect. Many lucky young people made their first fortunes, and they therefore have the ability to buy luxury houses and Lamborghinis. 

Your personal wealth has increased rapidly. What has changed in your life? I know that you donated to the Bill & Melinda Gates Foundation and GiveDirectly. When did you have the idea to donate?  @Vitalik Buterin

V:Not that much has changed for me personally, only that I do not have to take two-dollar buses to get around everywhere [Laugh]. Having more money for me is not about big houses and cars, it is about having safety so that I feel free to do what I want without having to worry about money, so I can focus on what I think is valuable without wasting my time or compromising my values.

Also, I am happy that the Ethereum Foundation has the funding to safely continue development for many more years, and that we are now able to be the ones that are also funding outside groups through our grant program, and cutting-edge research, like our recent $5m grant to Dan Boneh's lab at Stanford ( https://cbr.stanford.edu ). As for donating to the Against Malaria Foundation (not the same thing as the Bill & Melinda Gates foundation, even though both work a lot on malaria), GiveDirectly, and SENS, I feel that the money I have gives me a unique opportunity to save thousands of lives and support important work for humanity by giving to these groups, and so it's obvious that that's where the money should go. It feels wrong to buy a lambo when that money could have gone to protect thousands of people in Africa from malaria or help them buy food [Cry]

### Question 8，Smart contracts provides great help to blockchain applications. But so far, the biggest applications of Ethereum rest in issuing tokens. We found that there is a tutorial on the Internet to teach people how to issue tokens on the Ethereum blockchain in 3 minutes.According to a research report published by Goldman Sachs in June 2017, ICO funding exceeded the total amount of early VC investments. Meanwhile, this brand-new funding model inspired a global wealth effect. Many lucky young people made their first fortunes, and they therefore have the ability to buy luxury houses and Lamborghinis. 

Your personal wealth has increased rapidly. What has changed in your life? I know that you donated to the Bill & Melinda Gates Foundation and GiveDirectly. When did you have the idea to donate?  @Vitalik Buterins

V:Not that much has changed for me personally, only that I do not have to take two-dollar buses to get around everywhere [Laugh]. Having more money for me is not about big houses and cars, it is about having safety so that I feel free to do what I want without having to worry about money, so I can focus on what I think is valuable without wasting my time or compromising my values.

Also, I am happy that the Ethereum Foundation has the funding to safely continue development for many more years, and that we are now able to be the ones that are also funding outside groups through our grant program, and cutting-edge research, like our recent $5m grant to Dan Boneh's lab at Stanford ( https://cbr.stanford.edu ). As for donating to the Against Malaria Foundation (not the same thing as the Bill & Melinda Gates foundation, even though both work a lot on malaria), GiveDirectly, and SENS, I feel that the money I have gives me a unique opportunity to save thousands of lives and support important work for humanity by giving to these groups, and so it's obvious that that's where the money should go. It feels wrong to buy a lambo when that money could have gone to protect thousands of people in Africa from malaria or help them buy food [Cry]


### Question 9，You proposed a funding model called DAICO in January.  Blockchain projects are able to fund by utilizing smart contracts, a little bit like gambling. The funding can be gradually distributed to development teams. May I know why you proposed the DAICO?

V:The basic idea behind DAICO is to solve a major problem that I see with ICOs, where the funding for the project is front-loaded, so before a company receives funding they have the incentive to focus on heavy marketing but after a company receives funding for the project they have little incentive to continue development, not run away, maintain quality, etc.

The intention of a DAICO is to create a structure where the project developers only get funding a small amount at a time, and token holders can vote on whether or not the team deserves to get a larger amount of funding, and can also vote to cancel the project and return all remaining funds to themselves. This can align incentives better between token holders and developers.

### W:Question 10，At the beginning of establishing Ethereum, you insisted that The DAO should be a non-profit organization. I heard that some of the first 10 co-founders had proposed setting up a company to operate the project. But you rejected the idea and even “fired” two core staff members. It is interesting to hear the word ‘firing’ when it comes to a decentralized non-profit organization.

V:The Ethereum Foundation is still ultimately a traditional organization; until we somehow find ways to replace it with a DAO completetely, it's still an organization, it can hire people, it can fire people, etc. That said, we can only fire people from the organization, not the community; there are plenty people whom we've "fired" (or who quit) from the ethereum foundation, but who went on to do great work by themselves inside the ethereum community. This is the beauty of ethereum's decentralized nature.It's not at all clear that the rumor of my death was responsible for the price drop; that was at a time when a price downturn was taking place already. And I do believe that the DAO fork happened with the bulk of the community supporting it; the carbon vote, various community polls, etc, all showed something like 80% of people in favor of the fork. That said, as I said earlier, I do expect things like the DAO fork to become more and more difficult over time.I think at this point the Ethereum team other than myself is definitely competent enough to finish the Casper and sharding roadmaps on their own; even if I were to disappear I have full faith that they will do a good job.



O:Hey Vitalik, can I ask a question about sharding: how will Ethereum ensure data consistency and transaction reliability for cross-shard smart contracts?

V:See https://github.com/ethereum/wiki/wiki/Sharding-FAQs#how-can-we-facilitate-cross-shard-communication


O:In previois questions, Fred touched on ETH market cap and movement relative to bitcon, expanding on this is my long-lived ETH supply limit question:

While bitcoin slated 21 million BTC supply, Ethereum issues 18million ETH supply every year. Some say issuing new coins to proof of work miners is no longer a viable way to ensure ‘egalitarian coin distribution’ given this ‘altcoin attribute’.

Would you consider switching to Proof of Stake(PoS) algorithm by also placing a hard cap to counter the plunging price of Ethereum? (I noted you recently disclosed intention on agreeing a hard cap for the total quantity of ETH, with recommendation of setting MAX_SUPPLY 2x the amount of ETH sold in the original ether sale.)

Therefore, what is your optimal monetary policy of the Ethereum platform to secure the ‘economic sustainability’ for the network?

V:The ETH issuance is actually now down to only 7 million per year. I definitely belive that now that it is difficult for PoW to remain egalitarian, there's no reason to increase supply through PoW to make the distribution more fair. A supply cap seems absolutely reasonable to implement eventually, when we are confident that it will work well.


### Plus 1: There are three types of blockchain regulations in the world as follows:

1. Some countries are friendly to blockchain and ICOs, like Japan and Switzerland.
2. Some countries welcome blockchain innovations, but are cautious about ICO securitization, like the United States and the European Union.
3. Some countries strictly control ICOs and cryptocurrencies, but welcome blockchain technology, like China and Russia.

Some countries hope to put blockchain applications into the existing regulatory framework, but for various reasons, the progress is very slow. The effect is not as good as the regulators think.

How to regulate, who to regulate and what to regulate - have become big problems for regulators. Do you have any advice for regulators all over the world?

V:The main advice I would give is to focus on techniques like sandboxes and special-purpose guidelines that allow rules to be crafted around the specific experiences and challenges of the crypto industry, rather than trying to re-interpret rules from many decades ago. The software industry has a different culture from traditional finance, and does not find it reasonable to have to wait years, spend hundreds of thousands of dollars on lawyers, and publish the traditional style of audit reports and prospectuses, and I think this should be respected. In fact I think those kinds of traditional approaches often do not do a good job of targeting the kind of disclosures and consumer protection that people actually *want or need*. I personally am willing to publicly say that I find current accredited investor rules of many countries, which allow only millionaires to invest in securities, very unfair and plutocratic, and in some cases they can make things actually worse because they mean regular people can only buy in at higher prices and thus more easily become victims.

That said, there is certainly room for regulation to improve the situation in terms of requiring disclosure and transparency, encouraging alignment of incentives, and similar challenges. I also think the situation differs by country; in many developing countries, for example, the level of financial education is very low, and it is difficult for people to spot fraud and ponzis, in such contexts it makes sense for the level of regulation to be higher. I also think that the activity of many regulatory bodies including the SEC so far has been quite helpful, especially relative to what many expected, in that they have taken a targeted approach that focuses on the worst scams and encouraging an atmosphere of more caution, without trying to attack the entire industry.


### Plus 2：Two years ago, Amazon, Apple, Google, Facebook and other Internet giants did not pay much attention to blockchain because of its risk.

But now, most Internet giants have already entered the blockchain game. For example, Amazon released the first blockchain cloud computing SaaS solution.  Apple hopes to integrate Ripple’s Interledger API protocol into Apple Pay. Google is developing its own distributed ledger to support third-party release and verification transactions.  Facebook, which may issue its own cryptocurrency, has established a new blockchain department.

Do you believe that the blockchain industry will be controlled by these Internet giants?

V:I think they'll participate in the blockchain industry, but I don't think they will be able to control it. Unlike the internet, where the idealists saying it would lead to more decentralization were only a small part of the story, in the blockchain, maintaining decentralization is a core interest, and so many people will push back against the companies attempting to control the industry. And ultimately, they don't really have a way to control platforms like Ethereum.That Google thing was a joke; the email was clearly from a recruiter spamming everyone that their algos determined is a remotely competent developer [Grin]

O:@Vitalik Buterin How is plasma going? When can we use it? What is the most difficult thing about it?

V:There are versions being actively developed right now, eg. http://github.com/omisego/plasma-mvp; I expect we will see something effective and usable within the year.













