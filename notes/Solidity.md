# Solidity

## 结构

　　　Solidity中的合约与面向对象编程语言中的类（Class）很相似，在一个合约中可以声明多种成员，包括状态变量、函数、函数修改器、事件等。同时，一个合约可以继承另一个合约。

* 状态变量是__永久存储在合约账户存储__中的值，用于保存合约的状态。

contract SimpleStorage {

uint someData; //状态变量

}

* 函数是合约代码的执行单位，一个合约中可能包含许许多多提供各种功能的函数，它们相互调用，共同组成合约的工作逻辑。合约中还有一些特殊的函数，比如合约创建时执行的构造函数、想要调用一个不存在的函数时自动执行的fallback函数等。


* 函数修改器可用于改变函数的行为，在函数执行前或执行后插入其他逻辑，比如在函数执行前进行参数检查等。下面的代码演示了如何使用一个函数修改器确保一个函数只能被合约的创建者调用。

contract SimpleContract {

address public creater;

function SimpleContract() {

creater = msg.sender; //构造函数中记录合约创建者

}

modifier onlyCreater () { //函数修改器

require(msg.sender == creater);

_; //使用下划线指代原函数代码

}

function abort() onlyCreater { //使用函数修改器

　}

}

* 事件是以太坊日志协议的高层次抽象，用于记录合约执行过程中发生的各种事件和状态变化。在下面的代码中，当donate函数被调用时会自动记录调用者的地址和以太币数量，以供将来查看。

contract Funding {

event Deposit(address _from, uint _amount); //事件

function donate() payable {

Deposit(msg.sender, msg.value); //触发事件

 }
}


## 变量类型

Solidity提供了一些基础的变量类型，可以使用这些基础类型组合形成复杂的类型。变量类型根据参数传递方式的不同可以分为两类：值类型和引用类型。

* 值类型在每次赋值或者作为参数传递时都会创建一份拷贝

* 引用类型则有两种存储地点，即账户存储和内存。状态变量与部分类型的局部变量（数组、结构体等复杂类型）是默认保存在账户存储中的，而函数的参数和其他简单类型的局部变量则保存在内存中。必要时还可以在声明变量时加上memory或者storage修饰词来强制限定变量的存储地点。数据的存储地点非常重要，引用类型在不同的存储位置赋值，其产生的结果完全不同

值类型包括布尔类型、整数类型、地址类型、固定长度字节数组等，引用类型包括数组、结构体等。

### 值类型

* 布尔类型

布尔类型（bool）可能的取值是常量true和false。支持！（逻辑非）、&&（逻辑与）、||（逻辑或）、==（等于）、！=（不等于）等运算符。

* 整数类型

int表示有符号整数，uint表示无符号整数。变量支持通过后缀指明变量使用多少位进行存储，后缀必须是8～256范围内8的整数倍，比如int8、int16、int256。如果没有显式指明后缀，int默认表示int256，uint默认表示uint256。

* 枚举类型

枚举类型（enums）是一种用户自定义的类型，用于声明一些命名的常数。下面的代码演示了如何声明和使用枚举类型。枚举类型的成员默认从0开始，依次递增，在下面的例子中DEFAULT、ONE、TWO分别对应整数0、1、2。

contract SimpleEnum {

enum SomeEnum {DEFAULT, ONE, TWO}; //声明一个枚举类型

}


* 地址类型

地址类型（address）的长度为20字节（与以太坊账户地址长度一致），其是合约的基类，拥有一些成员方法和变量。从Solidity 0.5.0版本开始，合约不再继承自地址类型，但是开发者仍可以通过显式类型转换将合约转换为地址类型。


·<address>.balance：类型为uint，表示账户的余额，单位是wei。

·<address>.transfer（uint256 amount）：发送amount数量的以太币给address表示的账户，单位是wei，失败会抛出异常。

·<address>.send（uint256 amount）returns（bool）：与<address>.transfer类似，同样是进行以太币的转账。两者的区别是如果执行失败，<address>.transfer会抛出异常并且终止代码，<address>.send则是返回false，代码继续执行。


### 引用类型

* 数组

Solidity中的数组包括固定长度的数组，以及运行时可动态改变长度的动态数组。对于账户存储中的数组，数组元素可以是任何类型，而内存中的数组，其数组元素不可以是映射。

一个包含固定k个T类型数据的数组可以用T[k]语句来声明，一个动态长度的数组用T[]来声明。


下面来了解数组的成员变量和函数。

* length：数组可以通过访问length成员获取数组的长度。对于账户存储中的数组，可以通过修改数组的length成员动态地改变数组的长度，而内存中的数组在创建之后，其length成员就已经完全确定了，无法修改。


* push：账户存储中的动态数组以及bytes类型的变量，可以通过调用push方法在数组尾部添加元素，返回值为数组新的长度。


* bytes和string：一种特殊的数组。bytes通常用于表示任意长度的字节数据，而string用于表示任意长度的字符数据（UTF-8编码）。



### 结构体

Solidity语言中的结构体（struct）与C语言中很相似，允许开发者根据需要自定义变量类型。


contract Funding {

struct Donator {//结构体

address add;

uint amount;

 }
}

结构体可以作为映射或者数组中的元素，其本身也可以包含映射和数组等类型，但是不能将一个结构体用作其本身的成员，因为结构体嵌套自身会导致无限循环。


### 映射

映射（Mapping）是一种键值对映射关系的存储结构，我们使用mapping（KeyType=>ValueType）来声明一个映射，其中KeyType可以是除了映射、动态数组、合约、枚举类型、结构体以外的任何类型，ValueType则可以是任意类型，包括映射本身。


### 类型转换

如果一个运算符作用于两个类型不同的变量，编译器会自动尝试将一个变量类型转换为另一个变量的类型，这是隐式类型转换。通常，在语义合理并且不会造成信息损失的情况下允许进行隐式类型转换，比如uint8转换为uint16或者uint32，但是int8不能转换成uint16，这是因为uint16不能表示负数。任何可以转换为uint16的变量都可以转换为address类型。

有时在编译器不能进行隐式类型转换的情况下可以强行进行类型转换，这叫作显式类型转换。但是请注意，进行显式类型转换前必须知道你在进行什么操作并且确定操作的结果是你想要的，否则会造成很多异常情况。


### 运算符

Solidity语言中也包括算术运算符、比较运算符、位运算等。

__在Solidity中，delete仅仅是一项赋值运算，它用作给变量赋初始值__。例如，delete a与a=0是等效的；delete用于数组表示将该数据变成一个长度为0的空数组；当作用于固定长度数组时，该数组将变为一个长度不变但每个元素都被赋值为默认值的数组；当作用于结构体时，delete将递归作用于除映射外的所有成员；delete对映射无效。


### 类型推断

Solidity语言中，var关键字和C++语言中的auto关键字类似，用于类型推断。

uint24 x = 0x123;

var y = x;

var声明的变量将会拥有第一个赋值变量的类型。


## 内置单位、全局变量和函数

Solidity包含一些内置单位、全局变量和函数以供使用。

### 货币单位

一个字面量的数字可以使用wei、finney、szabo和ether等后缀表示不同的额度，不加任何后缀则默认单位为wei。比如“2ether==2000finney”的结果是true。


### 区块和交易属性

有一些方法和变量可以用于获取区块和交易的属性。


* block.blockhash（uint blockNumber）returns（bytes32）：获取特定区块的散列值，只对不包括当前区块的256个最近的区块有效。

* block.coinbase：类型为address，表示当前区块“矿工”的账号地址。

* block.difficulty：类型为uint，表示当前区块的挖矿难度。

* block.gaslimit：类型为uint，表示当前区块的Gas限制。

* block.number：类型为uint，表示当前区块编号。

* block.timestamp：类型为uint，以UNIX时间戳的形式表示当前区块的产生时间。

* msg.data：类型为bytes，表示完整的调用数据。

* msg.gas：类型为uint，表示剩余的Gas。

* msg.sender：类型为address，表示当前消息的发送者地址。

* msg.sig：类型为bytes4，调用数据的前4字节，函数标识符。

* msg.value：类型为uint，表示该消息转账的以太币数额，单位是wei。

* now：类型为uint，表示当前时间，是block.timestamp的别名。

* tx.gasprice：类型为uint，表示当前交易的Gas价格。

* tx.origin：类型为address，表示完整调用链的发起者。


## 异常处理


下面列举了几个与异常处理相关的函数:

* assert（bool condition）：当条件不为真时抛出异常，用于处理内部的错误

* require（bool condition）：当条件不为真时抛出异常，用于处理输入或者来自外部模块的错误


## 与合约相关的变量和函数

* this：__指代当前的合约，可以转换为地址类型__

* selfdestruct（address recipient）：__销毁当前合约，并且将全部的以太币余额转账到作为参数传入的地址recipient中__


## 函数

在Solidity中，一个函数可以有多个参数，同时也可以有多个返回值，如果没有对返回值进行赋值，默认值为0。

函数调用分为两种情况，一种是__调用同一合约中的函数，这种调用叫做内部调用__；另外一种为__调用其他合约实例的方法，这种调用称为外部调用__。


contract SimpleContract {

function calculate(uint a, uint b) returns (uint sum, uint product){

sum = a + b;

product = a * b;

 }

}


在合约内部如foo（a，b）这样就可以发起一个内部调用，其中foo是函数名，a、b是传递的参数。内部调用对应EVM指令集中的JUMP指令，所以是非常高效的，在此期间内存不会被回收。

函数的外部调用会创建一个消息发送给被调用的合约，如this.a（）或者foo.bar（）这样调用外部的合约函数，这里foo是一个合约的实例。对其他合约函数的调用必须是外部调用，外部调用会将函数调用的所有参数都保存到内存中。注意，在构造函数中不能通过this调用函数，因为此时合约实例还未创建完成。

在调用一个外部函数时，我们可以像下面代码这样通过value和gas指定__转账的以太币和Gas的数量__。对于funding.donate.value（10）.gas（800）（），其中funding是一个合约的实例，donate是想要调用的函数，value指定通过这个函数调用转账10单位wei，gas指定Gas数量，最后一个括号进行函数调用。注意，__Funding（addr）进行了一个显式类型转换，表示我们知道这个地址对应的合约是Funding__，在这个过程中不会调用构造函数。


contract Funding {

function donate() payable {}

}

contract Donator {

Funding funding;

function setFunding(address addr) { funding = Funding(addr); }

function callDonate() { funding.danate.value(10).gas(800)(); }

}


在以下几种情况下将会抛出异常：①调用的合约不存在；②被调用的不是一个合约账户，即该账户不包括代码；③被调用的函数抛出了异常；④调用过程中Gas耗尽。


有时，我们并不希望某一些函数可以被外部其他合约调用，Solidity提供了4种可见性修饰词用于修改函数和变量的可见性，分别为external、public、internal、private。函数的默认属性为public，状态变量的默认属性为internal，并且不可设置为external。


1）external：用于修饰函数，表示函数为一个外部函数，外部函数是合约接口的一部分，这意味着__只能通过其他合约发送交易的方式调用外部函数__。

2）public：用来修饰公开的函数/变量，表明该函数/变量既可以在合约外部访问，也可以在合约内部访问。

3）internal：内部函数/变量，表示__只能在当前合约或者继承自当前合约的其他合约中访问__。

4）private：私有函数和变量，__只有当前合约内部才可以访问__。


__可见性只限制了其他合约的访问权限，但是因为所有区块链数据都是以公开透明的方式存储的，外部观察者可以看到所有的合约数据__。



## constant函数和fallback函数

在声明一个函数时，可以像下面这样使用constant或者view关键字告诉编译器这个函数进行的是只读操作，不会造成其他状态变化。

contract SimpleContract {

function f(uint a, uint b) view returns (uint) {

return a * (b + 42) + now;

 }
}

造成状态变化的语句包括：修改变量的值、触发事件、创建其他合约、调用任何非constant函数等。


__在合约中，有一个默认隐式存在的函数叫做fallback函数__。fallback函数不能接受任何参数并且不能拥有返回值。当一个合约收到无法匹配任何函数名的函数调用或者仅仅用于转账的交易时，fallback函数将会被自动执行，默认的行为是抛出异常。

在Solidity 0.4.0以后的版本中，如果我们想让合约以简单的Transfer方式进行以太币转账，则需要像“function（）payable{}”这样实现fallback函数，给函数加上payable修饰词。

contract Test {

// 这个合约收到任何函数调用都会触发fallback函数（因为没有其他函数）

// 向这个合约发送以太币会触发异常，因为fallback函数没有payable修饰词

function() { x = 1; }

uint x;

}

contract Caller {

function callTest(Test test) {

test.call(0xabcdef01); // 对应的函数不存在

// 触发test的fallback函数，导致test.x的值变为1

// 下面这句话不会通过编译

// 即使某个交易向test发送了以太币，也会触发异常并且退回以太币

//test.send(2 ether);

 }
}

当手动实现fallback函数时，需要特别注意Gas消耗，因为fallback函数只拥有非常少的Gas（2300Gas）。比起fallback函数的Gas限制，一个触发了fallback函数的交易会消耗更多的Gas，因为大约有21000或者更多的Gas会用于签名验证等过程。


## 函数修改器

函数修改器与Python中的装饰器类似，可以在一定程度上改变函数的行为，比如可以在函数执行前自动检查参数是否合法。函数修改器可以被继承，也可以被派生类覆盖重写。

下面代码展示了如何声明并使用函数修改器。

contract owned {

function owned() { owner = msg.sender; }

address owner;

// 这个合约定义了一个在派生合约中使用的函数修改器

// "_;" 指代被修改函数的函数体

// 在这个函数执行前，先检查msg.sender是否是合约创建者

// 如果不是就会抛出异常

modifier onlyOwner {

require(msg.sender == owner);

_;

}

}

contract Contract is owned {

// 从owned合约继承了onlyOwner函数修改器并且将其作用于close函数

// 确保了这个函数只有在调用者为合约创建者时才会生效

function close() onlyOwner { selfdestruct(owner); }

}



## 异常处理

__太坊使用状态回退机制处理异常__。如果发生了异常，当前消息调用和子消息调用产生的所有状态变化都将被撤销并且返回调用者一个报错信号。

Solidity语言提供了两个函数assert和require来检查条件，并且当条件不满足的时候抛出一个异常。__assert函数通常用于检查变量和内部错误，require函数用于确保程序执行的必要条件是成立的__。一个正常运行的程序不应该遇到assert和require失败，否则程序代码中一定存在需要修复的问题。


下面的例子展示了如何使用assert和require确保程序正确运行。


contract AssertExample {

function sendHalf(address addr) payable returns (uint balance) {

require(msg.value % 2 == 0); // 只允许偶数

uint balanceBeforeTransfer = this.balance;

addr.transfer(msg.value / 2);

// 使用assert确保transfer转账成功，否则抛出异常

assert(this.balance == balanceBeforeTransfer - msg.value / 2);

return this.balance;

}
}


## 事件和日志

事件使用了EVM内置日志功能，以太坊客户端可以使用JavaScript的回调函数监听事件。当事件触发时，会将事件及其参数存储到以太坊的日志中，并与合约账户绑定。以太坊的日志是与区块相关的，只要区块可以访问则日志会一直存在。日志无法在合约中访问，即使是创建该日志的合约。

以下代码创建了一个含有事件的合约。

contract Funding {

event Deposit(

address indexed _from,

bytes32 indexed _id,

uint _value

);

function deposit(bytes32 _id) payable {

// 在JavaScript API中过滤Deposit事件

// 每次该函数的调用都可以被监听到

Deposit(msg.sender, _id, msg.value);

 }

}


## 智能合约的继承


Solidity支持继承与多重继承，它的继承系统与Python很像，尤其是在多重继承方面。值得注意的是，__当一个通过继承产生的合约被部署到区块链上时，实际上区块链上只创建了一个合约，所有基类合约的代码都会在子类合约中有一份拷贝__。

















































