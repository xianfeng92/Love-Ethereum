ERC20是以太坊定义的一个[代币标准](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md), 利用以太坊的智能合约可以轻松编写出属于自己的代币，这里的代币可以代表在平台或者社区的所拥有的权益。


# 太坊的代币标准

使用代币合约标准可以在以太坊上发行在区块链应用（Dapp）上所使用的代币。

## Token

## Methods

NOTE: Callers MUST handle false from returns (bool success). Callers MUST NOT assume that false is never returned!

调用者必须处理返回值为false的方法

## name

Returns the name of the token

## symbol

Returns the symbol of the token

## decimals

Returns the number of decimals the token uses

## totalSupply

Returns the total token supply

## balanceOf

Returns the account balance of another account with address _owner

返回账户owner中的余额

## transfer

Transfers _value amount of tokens to address _to, and __MUST fire the Transfer event__. The function SHOULD throw if the _from account balance does not have enough tokens to spend

Note Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event


## transferFrom

Transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event

The transferFrom method is used for a withdraw workflow, allowing contracts to transfer tokens on your behalf. This can be used for example to allow a contract to transfer tokens on your behalf and/or to charge fees in sub-currencies

transferFrom方法用于"转账"流程，允许合约代表您转让token。 例如，这可用于允许合同代表您转让代币或者以子货币收取费用。

Note Transfers of 0 values MUST be treated as normal transfers and fire the Transfer event


## approve

Allows _spender to withdraw from your account multiple times, up to the _value amount. If this function is called again it overwrites the current allowance with _value

允许spender从你的账户中多次"提取"token,直到规定的金额value

## allowance

Returns the amount which _spender is still allowed to withdraw from _owner

返回账户spender可以从合约所有者owner中提取的token数量


## Events

### Transfer

MUST trigger when tokens are transferred, including zero value transfers.

涉及到token转移时必须触发此事件

A token contract which creates new tokens SHOULD trigger a Transfer event with the _from address set to 0x0 when tokens are created

代币合约部署时也需要触发此事件

### Approval

MUST trigger on any successful call to approve(address _spender, uint256 _value)



# 代币合约实例

下面是一个　token 合约的例子，可以直接复制到remix进行合约部署的。

事先说明两点：

１token的发行很简单的,其价值还是要看和token所关联的项目。有很多组织没有项目就胡乱发token。

２token这个概论本身是有很大的价值的，如何发行和利用token,对项目成败也有很多影响。


pragma solidity ^0.4.20;

interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) public; }

contract TokenLBJ {
　　　　// 代币名称,如:"LeBron James"
    string public name;
    // 代币符合，一般用代币名称的缩写，如 LBJ
    string public symbol;
    // 每个代币可细分的到多少位，即最小代币单位。18为默认值
    uint8 public decimals = 18;
　　　　//　代币总供应量，这里指的是一共有多少个以最小单位所计量的代币
    uint256 public totalSupply;

    // 用mapping保存每个地址对应的余额
    mapping (address => uint256) public balanceOf;

    // 存储对账号的控制，有两点需要注意的：１本合约账户可以授权其他账户转移token数量　２　其他账户授权该合约账户转移token数量
    mapping (address => mapping (address => uint256)) public allowance;

    // 事件，用来通知客户端交易发生
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 事件，用来通知客户端代币被销毁
    event Burn(address indexed from, uint256 value);

    /**
     * 初始化构造，初始化后代币全部存储于合约创建者账户
     */
    function TokenERC20(uint256 initialSupply, string tokenName, string tokenSymbol) public {
        totalSupply = initialSupply * 10 ** uint256(decimals);  // 供应的份额，份额跟最小的代币单位有关，份额 = 币数 * 10 ** decimals
        balanceOf[msg.sender] = totalSupply;                // 创建者拥有所有的代币
        name = tokenName;                                   // 代币名称
        symbol = tokenSymbol;                               // 代币符号
    }

    /**
     * 代币交易转移的内部实现,只能被本合约调用
     */
    function _transfer(address _from, address _to, uint _value) internal {
        // 确保目地地址不为0x0，因为0x0地址代表的是销毁
        require(_to != 0x0);
        // 确保发送者账户有足够的余额
        require(balanceOf[_from] >= _value);
        // 确保_value为正数，如果为负数，那相当于付款者账户钱越买越多～哈哈～
        require(balanceOf[_to] + _value > balanceOf[_to]);

        // 交易前，双方账户余额总和
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        // 将发送方账户余额减value
        balanceOf[_from] -= _value;
        // 将接收方账户余额加value
        balanceOf[_to] += _value;
　　　　　　　　//通知客户端交易发生
        Transfer(_from, _to, _value);

        // 用assert来检查代码逻辑,即交易前后双发账户余额的和应该是相同的
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }

    /**
     * 从合约创建交易者账号发送`_value`个代币到 `_to`账号
     *　这种类似于现在很多项目的空头吧，很多空气项目其实也就是在以太坊上发个币，然后就割韭菜，所以学学区块链技术还是很有必要的
     * @param _to 接收者地址
     * @param _value 转移数额
     */
    function transfer(address _to, uint256 _value) public {
　　　　　　　　//_from始终是合约创建者的地址
        _transfer(msg.sender, _to, _value);
    }

    /**
     *批量转帐固定金额
    /
    function batchTransfer(address[] _to, uint _value) public{
        require(address.length > 0)
        for(uint i=0 ; i< address.length; i++){
           _transfer(msg.sender,address[i], _value);
         }
    }

    /**
　　　　　* Transfer tokens from other address
     * Send '_value' tokens to '_to' on behalf of '_from'
     * @param _from 发送者地址
     * @param _to 接收者地址
     * @param _value 转移数额
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        // _from 所授权　msg.sender 转移的代币数量
        require(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    /**
     *
     * 允许发送者`_spender` 花费不多于 `_value` 个代币
     *
     * @param _spender The address authorized to spend
     * @param _value the max amount they can spend
     */
    function approve(address _spender, uint256 _value) public
        returns (bool success) {
　　　　　　　　//具体结构如下：(msg.sender --> allowance[msg.sender])--> mapping(address => uint)
        // msg.sender　允许　_spender　最多花费的代币数量　
        allowance[msg.sender][_spender] = _value;
        return true;
    }

    /**
     * 设置允许一个地址（合约）以我（创建交易者）的名义可最多花费的代币数。
     *
     * @param _spender 被授权的地址（合约）
     * @param _value 最大可花费代币数
     * @param _extraData 发送给合约的附加数据
     */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData)
        public
        returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            // 通知合约
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
        }
    }

    /**
     * 销毁合约账户中指定数量的代币
     */
    function burn(uint256 _value) public returns (bool success) {
　　　　　　　　// 检查合约账户是否有足够的代币
        require(balanceOf[msg.sender] >= _value);
　　　　　　　　// 将合约账户余额减少value
        balanceOf[msg.sender] -= _value;
　　　　　　　　// 对应代币总供应量也应该减少
        totalSupply -= _value;
        Burn(msg.sender, _value);
        return true;
    }

    /**
     * 销毁用户账户中指定个代币
     *
     * Remove `_value` tokens from the system irreversibly on behalf of `_from`.
     *
     * @param _from the address of the sender
     * @param _value the amount of money to burn
     */
    function burnFrom(address _from, uint256 _value) public returns (bool success) {
        require(balanceOf[_from] >= _value);                // Check if the targeted balance is enough
        require(_value <= allowance[_from][msg.sender]);    // Check allowance
        balanceOf[_from] -= _value;                         // Subtract from the targeted balance
        allowance[_from][msg.sender] -= _value;             // Subtract from the sender's allowance
        totalSupply -= _value;                              // Update totalSupply
        Burn(_from, _value);
        return true;
    }
}


参考:[Create your own crypto-currency](https://ethereum.org/token)
