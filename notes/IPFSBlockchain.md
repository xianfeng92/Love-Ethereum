# IPFS + Blockchain

## create-react-app 

> npm install -g create-react-app

## React创建和运行项目

> create-react-app ipfs-demo

> npm start

## 安装ipfs-api

终端进入ipfs-demo的根目录下：

> npm install --save-dev ipfs-api

[关于ipfs-api参考](https://github.com/ipfs/js-ipfs-api)

## 项目中导入IPFS

> var ipfsAPI = require('ipfs-api')

  // connect to ipfs daemon API server
> var ipfs = ipfsAPI('localhost', '5001', {protocol: 'http'}) // leaving out the arguments will default to these values

  // or connect with multiaddr
> var ipfs = ipfsAPI('/ip4/127.0.0.1/tcp/5001')

  // or using options
> var ipfs = ipfsAPI({host: 'localhost', port: '5001', protocol: 'http'})

  // or specifying a specific API path
> var ipfs = ipfsAPI({host: '1.1.1.1', port: '80', 'api-path': '/ipfs/api/v0'})

## 上传文本数据到IPFS

* ipfs add

```
saveData2Ipfs = (blob) => {
  return new Promise(function(resolve, reject) {
  const descBuffer = Buffer.from(blob, 'utf-8');
  // 调用ipfs的add方法添加文本到ipfs中
  ipfs.add(descBuffer).then((response) => {
  console.log(response)
  // response[0].hash即上传内容的hash值
  resolve(response[0].hash);
  }).catch((err) => {
  　　console.error(err)
  　　reject(err);
  　})
  })
 }

```

```
 this.saveData2Ipfs(content).then((hash) => {
   // hash即为上传内容content　的hash值
   console.log(hash);
  })
```

## 从IPFS读取数据

* ipfs cat

```
ipfs.cat(contentHash).then((stream) => {
   console.log(stream);
　　　// 将array 转为　string
   let strContent = Utf8Array2Str(stream);
   // strContent　根据contentHash从ipfs 中读取的字符串内容
   console.log(strContent);
})

```

## 上传图片到IPFS

```
saveImage2Ipfs = (reader) => {
 
  return new Promise(function(resolve, reject)){

    const buffer = Buffer.from(reader.result);
    ipfs.add(buffer).then((response) => {

      console.log(response);
      resolve(response[0].hash);
     }).catch((err) => {

        console.error(err);
        reject(err);
      })
    }
 }

```

```
 var file = this.refs.file.files[0];
 var reader = new FileReader();
 // reader.readAsDataURL(file);
 reader.readAsArrayBuffer(file)
 reader.onloadend = function(e) {
  console.log(reader);
  saveImageOnIpfs(reader).then((hash) => {
   console.log(hash);
 });

```
* reader.readAsDataURL(file) 上传图片路径

* reader.readAsArrayBuffer(file) 上传图片内容

* 上传图片

```
saveImage2Ipfs(reader).then((hash) => {
   console.log(hash);
 });

```










































