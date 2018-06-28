pragma solidity ^0.4.11;
import "./DataContract.sol";

contract ControlContract{
    
    address public owner;
    DataContract dataContract;
    mapping(uint256 => address) public name2Address;

    
    modifier contractOwner(){
        require(owner == msg.sender);
        _;
    }
    
    function ControlContract(address _dataContractAddress, address _owner){
        
        dataContract = DataContract(_dataContractAddress);
        owner = _owner;
    }
    
    function add(uint256 _id, uint256 _amount) public{
        
         dataContract.balanceOf(getAddress4Name(_id))+_amount;
    }
    
    function withdraw(uint _id, uint256 amount) public{
        
        dataContract.balanceOf(getAddress4Name(_id))-amount;
    }
    
    function setName2Address(uint256 _id, address _addr) contractOwner {
        
        name2Address[_id] = _addr;
        
    }
    
    function getAddress4Name(uint256 _id) internal returns(address) {
        
        return name2Address[_id];
    }
}
