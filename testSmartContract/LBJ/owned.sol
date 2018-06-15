pragma solidity ^0.4.20;

contract owned{
    address public owner;
    
    function owned() public{
        owner =msg.sender;
    }
    
    modifier onlyOwner{
        require(owner == msg.sender);
        _;
    }
    
    function transferOwnerShip(address newOwner) onlyOwner public{
        owner = newOwner;
    }
    
}
