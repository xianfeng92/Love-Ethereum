pragma solidity ^0.4.20;


interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) public; }

contract LBJ{
    
    string public name;
    string public symbol;
    uint256 public decimals = 18;
    uint256 public totalSupply;
    
    mapping(address => uint256) public balanceof;
    mapping(address => mapping(address => uint256)) public allowance;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed target, uint256 value);
    
    function LBJ(uint256 initialSupply, string tokenName, string tokenSymbol) payable public {
        
        name = tokenName;
        symbol = tokenSymbol;
        totalSupply = initialSupply*10**decimals;
    }
    
    function _transfer(address _from, address _to, uint256 _value) internal{
        
        require(_to != 0);
        require(balanceof[_from] > _value);
        require(balanceof[_to]+_value > balanceof[_to]);
        uint previousTotal = balanceof[_from] + balanceof[_to];
        balanceof[_from] -= _value;
        balanceof[_to] += _value;
        Transfer(_from,_to,_value);
        assert(balanceof[_from] + balanceof[_to] == previousTotal);
    }
    
    function transfer(address to, uint256 value) public{
        _transfer(msg.sender,to,value);
    }
    
    function bachTransfer(address[] to, uint256 value) public{
        require(to.length >= 0);
        for(uint i = 0; i < to.length;i++){
            _transfer(msg.sender, to[i],value);
            
        }
    }
    
    function transferFrom(address from, address to, uint256 value) public returns (bool success){
        
        require(allowance[from][msg.sender] >= value);
        allowance[from][msg.sender] -= value;
        _transfer(from, to, value);
        return true;
        
    }
    
    function approve(address _spender, uint256 _value) returns (bool success){
        allowance[msg.sender][_spender] = _value;
        return true;
    }
    
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) public returns (bool success){
        
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
        }
        
    }
    
    function burn (uint256 _value) public returns (bool success){
        require(balanceof[msg.sender] >= _value);
        balanceof[msg.sender] -= _value;
        totalSupply -= _value;
        Burn(msg.sender, _value);
        return true;
    }
    
    function burnFrom(address from, uint256 value) public returns (bool success) {
        require(balanceof[from] > value);
        require(allowance[from][msg.sender] >= value);
        balanceof[from] -= value;
        totalSupply -= value;
        Burn(from, value);
        return true;
    }
    
}
