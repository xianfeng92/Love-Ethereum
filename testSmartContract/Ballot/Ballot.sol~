pragma solidity ^0.4.20;

contract Ballot{
    
    struct Voter{
        uint weight;
        bool voted;
        uint vote;
        address delegate;
    }
    
    struct Proposal{
        bytes32 name;
        uint voteCount;
    }
    
    address chairPerson;
    
    mapping(address => Voter) voters;
    
    Proposal[] proposals;
    
    function Ballot(bytes32[] proposalName){
        
        chairPerson = msg.sender;
        voters[chairPerson].weight = 1;
        for (uint i = 0; i < proposalName.length ; i++){
            
            proposals.push(Proposal({name:proposalName[i],voteCount:0}));
        }
    }
    
    function giveRightToVote(address voter) public{
        
        require(msg.sender != voter && (!voters[voter].voted) && (voters[voter].weight == 0));
        voters[voter].weight = 1;
    }
    
    function delegate(address to){
        
        Voter storage sender = voters[msg.sender];
        require(!sender.voted);
        require(to != msg.sender);
        while(voters[to].delegate != address(0)){
            to = voters[to].delegate;
            require(to != msg.sender);
        }
        
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate = voters[to];
        if(delegate.voted){
            
            proposals[delegate.vote].voteCount += sender.weight;
            
        }else{
            
            delegate.weight += sender.weight;
        }
    }
    
    
    
    function vote(uint proposal){
        
        Voter storage sender = voters[msg.sender];
        require(!sender.voted);
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }
    
    
    function winningProposal() constant returns (uint winningProposal){
        
        uint winningVoterCount = 0;
        for(uint p = 0; p < proposals.length; p++){
            
            if(proposals[p].voteCount > winningVoterCount){
                winningVoterCount = proposals[p].voteCount;
                winningProposal = p;
            }
            
        }
        
    }
    
    function winningName() returns (bytes32 winningName){
        
        winningName = proposals[winningProposal()].name;
    }
       
}
