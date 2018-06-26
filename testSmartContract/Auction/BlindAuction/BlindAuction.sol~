pragma solidity ^0.4.11;

contract BlindAuction{
    
    struct Bid {
        bytes32 blindedbid;
        uint deposit;
    }
    
    // 拍卖所得的受益者 beneficiary,在合约部署时指定
    address public beneficiary;
    // 竞拍期的时长 biddingTime (s)
    uint public biddingEnd;
    // 竞拍期之后的揭晓期时长 revealTime (s)
    uint public revealEnd;
    
    bool public ended;
    
    mapping(address => Bid[]) public bids;
    
    address public highestBidder;

    uint public highestBid;
    
    mapping(address => uint) pendingReturns;
    
    event AuctionEnded(address winner, uint amount);
    
    modifier onlyBefore(uint _time){
        require(now < _time);
        _;
    }
    
    modifier onlyAfter(uint _time){
        require(now > _time);
        _;
    }
    
    function BlindAuction(uint _biddingTime, uint _revelTime,address _beneficiary){
       
        beneficiary = _beneficiary;
        biddingEnd = now + _biddingTime;
        revealEnd = biddingEnd + _revelTime;
    }
    
    // blindedBid 实际出价金额 本次出价的“真伪” 出价者生成的一个密钥 三者取散列生成的
    // 有两个作用：一是隐含本次出价真伪的信息；二是用以在揭晓期验证用户所揭晓的实际出价信息是否可信
    function bid(bytes32 _blindBid) public payable onlyBefore(biddingEnd){
  
        bids[msg.sender].push(Bid({
            blindedbid:_blindBid,
            deposit:msg.value
            
        })); 
    }
    
    // 揭晓函数,在竞拍结束后，每个出价者都需要在揭晓期执行reveal函数，揭晓自己每次出价的详细信息
    function reveal(uint[] _values, bool[] _fake, bytes32[] _serect) public onlyAfter(biddingEnd) onlyBefore(revealEnd){
        
        uint length = bids[msg.sender].length;
        require(_values.length == length);
        require(_fake.length == length);
        require(_serect.length == length);
        
        uint refund;
        
        for(uint i=0; i< length; i++){
            var bid = bids[msg.sender][i];
            var (value, fake, serect) = (_values[i], _fake[i],_serect[i]);
            if(bid.blindedbid != keccak256(value,fake,serect)){
                continue;
            }
            // 把每次出价时所付的金额（bid.deposit）先叠加到refund中
            refund += bid.deposit;
            if(!fake && bid.deposit > 0){　
                if(placeBid(msg.sender,value)){
                    refund -= value;    
                }
                bid.blindedbid = bytes32(0);
            }
            msg.sender.transfer(refund);
        }
    }
    
    //　更新当前的最高出价，内置函数，被 reveal　调用
    function placeBid(address bidder,uint value) internal returns (bool success){
        
        if(value < highestBid){
            return false;
        }
        
        if(highestBid != 0){
            pendingReturns[highestBidder] += highestBid;
        }
        
        highestBidder = bidder;
        highestBid = value;
        return true;
    }
    
　　　　// 退款函数
    function withdraw() public{
        
        uint amount = pendingReturns[msg.sender];
        if(amount > 0){
            pendingReturns[msg.sender] = 0;
            msg.sender.transfer(amount);
        }
    }
    
    function auctionEnd() public onlyAfter(revealEnd){
        require(!ended);
        AuctionEnded(highestBidder,highestBid);
        ended = true;
        beneficiary.transfer(highestBid);
    }    
}
