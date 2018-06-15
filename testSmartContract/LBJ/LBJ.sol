pragma solidity ^0.4.20;

import "./owned.sol";
import "./baseCoin.sol";


/******************************************/
/*       This Is For You, LeBron James

勒布朗·詹姆斯（LeBron James），1984年12月30日出生在美国俄亥俄州阿克伦，
美国职业篮球运动员，司职小前锋，绰号“小皇帝”，效力于NBA克利夫兰骑士队。
勒布朗·詹姆斯在2003年NBA选秀中于首轮第1顺位被克利夫兰骑士队选中。
2003-2010年，詹姆斯效力于骑士队，期间2次当选NBA最有价值球员（MVP）。
2010年，詹姆斯转会至迈阿密热火队，与德怀恩·韦德、克里斯·波什组成“三巨头”阵容。
2012年，詹姆斯得到NBA个人生涯的第3座常规赛MVP，第1个总冠军和总决赛MVP。
詹姆斯代表美国男篮获得了2012年伦敦奥运会金牌，追平了迈克尔·乔丹在1992年所创的纪录。
2013年，詹姆斯获得第4个常规赛MVP、第2个NBA总冠军和第2个总决赛MVP，实现两连冠。
2014年，詹姆斯回归骑士，与凯里·欧文、凯文·乐福组成“三巨头”阵容。
2016年，詹姆斯带领骑士逆转战胜卫冕冠军勇士获得队史首个总冠军和个人第3个总决赛MVP。


　　　　　　We wait for decision ３

*/
/*********************************************/


contract LBJ is baseCoin, owned{
    
    mapping(address => bool) public frozenAccount;
    
    /* This generates a public event on the blockchain that will notify clients */
    event FrozenFunds(address target, bool frozen);
    
    /* Initializes contract with initial supply tokens to the creator of the contract */
    function LBJ(
        uint256 initialSupply,
        string tokenName,
        string tokenSymbol
    ) baseCoin(initialSupply, tokenName, tokenSymbol) payable public {}
    
    
    /* Internal transfer, only can be called by this contract */
    function _transfer(address _from, address _to, uint _value) internal {
        require (_to != 0x0);                               // Prevent transfer to 0x0 address. Use burn() instead
        require (balanceOf[_from] >= _value);               // Check if the sender has enough
        require (balanceOf[_to] + _value > balanceOf[_to]); // Check for overflows
        require(!frozenAccount[_from]);                     // Check if sender is frozen
        require(!frozenAccount[_to]);                       // Check if recipient is frozen
        balanceOf[_from] -= _value;                         // Subtract from the sender
        balanceOf[_to] += _value;                           // Add the same to the recipient
        Transfer(_from, _to, _value);
    }
    
    /// @notice Create `mintedAmount` tokens and send it to `target`
    /// @param target Address to receive the tokens
    /// @param mintedAmount the amount of tokens it will receive
    function mintToken(address target, uint256 mintedAmount) onlyOwner public {
        balanceOf[target] += mintedAmount;
        totalSupply += mintedAmount;
        Transfer(0, this, mintedAmount);
        Transfer(this, target, mintedAmount);
    }
    
    
    /// @notice `freeze? Prevent | Allow` `target` from sending & receiving tokens
    /// @param target Address to be frozen
    /// @param freeze either to freeze it or not
    function freezeAccount(address target, bool freeze) onlyOwner public {
        frozenAccount[target] = freeze;
        FrozenFunds(target, freeze);
    }
    
}
