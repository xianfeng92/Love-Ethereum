# Truffle 

## INSTALLATION

> npm install -g truffle

## REQUIREMENTS

* NodeJS 5.0+ recommended

* Windows, Linux or Mac OS X


# CREATING A PROJECT

To use most Truffle commands, you need to run them against an existing Truffle project. So the first step is to create a Truffle project.

You can create a bare project template, but for those just getting started, you can use Truffle Boxes, which are example applications and project templates. We'll use the MetaCoin box, which creates a token that can be transferred between accounts:


1 Create a new directory for your Truffle project:

> mkdir MetaCoin
> cd MetaCoin

2 Download ("unbox") the MetaCoin box:

> truffle unbox metacoin


3 Use Truffle Develop

> truffle develop
> compile
> migrage

5 In another Terminal

> npm run dev

then, you'll get this

```
Project is running at http://localhost:8080/
webpack output is served from /
Hash: 7d84f794b19e7c619de2
Version: webpack 2.7.0
Time: 1332ms
     Asset       Size  Chunks                    Chunk Names
    app.js    1.68 MB       0  [emitted]  [big]  main
index.html  925 bytes          [emitted]
chunk    {0} app.js (main) 1.65 MB [entry] [rendered]
   [71] ./app/javascripts/app.js 3.64 kB {0} [built]
   [72] (webpack)-dev-server/client?http://localhost:8080 7.93 kB {0} [built]
   [73] ./build/contracts/MetaCoin.json 47.7 kB {0} [built]
  [111] ./~/loglevel/lib/loglevel.js 7.86 kB {0} [built]
  [117] ./~/querystring-es3/index.js 127 bytes {0} [built]
  [119] ./~/strip-ansi/index.js 161 bytes {0} [built]
  [122] ./app/stylesheets/app.css 905 bytes {0} [built]
  [163] ./~/truffle-contract/index.js 2.64 kB {0} [built]
  [197] ./~/url/url.js 23.3 kB {0} [built]
  [199] ./~/web3/index.js 193 bytes {0} [built]
  [233] (webpack)-dev-server/client/overlay.js 3.67 kB {0} [built]
  [234] (webpack)-dev-server/client/socket.js 1.08 kB {0} [built]
  [235] (webpack)/hot nonrecursive ^\.\/log$ 160 bytes {0} [built]
  [236] (webpack)/hot/emitter.js 77 bytes {0} [built]
  [237] multi (webpack)-dev-server/client?http://localhost:8080 ./app/javascripts/app.js 40 bytes {0} [built]
     + 223 hidden modules
webpack: Compiled successfully.
```

6 Contract instance

> var metaCoin
> MetaCoin.deployed().then((instance) => {metaCoin = instance})

enter

> metaCoin

you'll get abi of MetaCoin


7 send a Transaction

> metaCoin.getBalance.call(web3.eth.accounts[1])

BigNumber { s: 1, e: 1, c: [ 20 ] }

> metaCoin.getBalance.call(web3.eth.accounts[0])

BigNumber { s: 1, e: 3, c: [ 9980 ] }

> metaCoin.sendCoin.sendTransaction(web3.eth.accounts[1],10,{from:web3.eth.accounts[0]})

>  metaCoin.getBalance.call(web3.eth.accounts[1])

BigNumber { s: 1, e: 1, c: [ 30 ] }
