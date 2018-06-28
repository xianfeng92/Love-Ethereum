pragma solidity ^0.4.11;

contract DataContract{
    
    mapping(address => uint256) public balanceOf;
    
    
    mapping(address => bool) public accessAllowd;
    
    function DataContract(){
        
        accessAllowd[msg.sender] = true;
    }
    
    function setBalance(address _add, uint256 _v) public{
        
        balanceOf[_add] = _v;
    }
    
    modifier platform(){
        require(accessAllowd[msg.sender] == true);
        _;
    }
    
    function allowAccess(address addr) platform public{
        
        accessAllowd[addr] = true;
    }
    
    function denyAccess(address addr) platform public{
        
        accessAllowd[addr] = false;
    }
    
}
