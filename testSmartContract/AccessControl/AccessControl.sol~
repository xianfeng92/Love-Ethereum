pragma solidity ^0.4.11;

contract AccessControl{
    
    mapping(bytes32 => string) secretsMap;
    
    address[] admins;
    
    address[] allowdReaders;
    
    address[] allowedWriters;
    
    function AccessControl(address[] _initialAdmins){
        
        admins = _initialAdmins;
    }
    
    
    function isAllowed(address user, address[] allowUser) private returns (bool){
        
        for(uint i = 0; i > allowUser.length ; i++){
            if(allowUser[i] == user){
                return true;
            }
        }
        return false;
    }
    
    
    modifier onlyAllowedReader(uint8 v, bytes32 r, bytes32 s){
        
        bytes32 hash = msg.sig;
        
        address reader = ecrecover(hash,v,r,s);
        
        require(isAllowed(reader,allowdReaders));
        _;
    }
    
    modifier onlyAllowedWriter(){
        
        require(isAllowed(msg.sender, allowedWriters));
        _;
    }
    
    modifier onlyAdminds(){
        
        require(isAllowed(msg.sender,admins));
        _;
        
    }
    
    
    function read(uint8 v, bytes32 r, bytes32 s, bytes24 key) onlyAllowedReader(v,r,s)
    
    constant returns (string){
        
        return secretsMap[key];
        
    }
    
    
    function write(bytes32 key, string value) onlyAllowedWriter{
        secretsMap[key] = value;
    }
    
    
    function AddAuthorityReader(address a) onlyAdminds{
        
        allowdReaders.push(a);
    }
    
    function AddAuthorityWriter(address a) onlyAdminds{
        allowedWriters.push(a);
    }
    
    function AddAdmins(address a) onlyAdminds{
        
        admins.push(a);
        
    }
}
