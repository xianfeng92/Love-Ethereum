# IPFS

## 关于IPFS使用的一些操作命令

* IPFS节点的创建

> ipfs init

* 查看节点id

> ipfs id

* 启动IPFS所创建的节点

> ipfs daemon

* 跨域资源共享CORS配置

> ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT","GET", "POST", "OPTIONS"]'
> ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
> ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials '["true"]'
> ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers '["Authorization"]'
> ipfs config --json API.HTTPHeaders.Access-Control-Expose-Headers'["Location"]'

* 查看ipfs的相关命名

> ipfs --help

* 往ipfs本地节点中添加file.txt文件

> ipfs add file.txt

注意：add 只是在本地节点中添加文件，并没有同步到ipfs网络中。只有连接上ipfs网络（ipfs daemon）才能同步此文件。

* 往ipfs本地节点中添加目录 dir/

> ipfs add -r dir/

* IPNS

可以将内容发布到IPNS,在IPNS中，允许我们的节点的域名空间中引用一个 IPFS hash,即我们可以通过节点id对项目根目录的IPFS HASH 进行绑定，以后我们访问内容时只需要通过节点的id访问即可。当我们需要更新内容时，只要将内容重新发布到IPNS即可。

> ipfs name publish 需要发布内容的hash

命令执行后，节点id的hash(<peerId>)即可与发布内容的hash绑定起来

> http://ipfs.io/ipns/<peerId>

直接通过节点id的hash访问发布的内容

> ipfs name resolve <peerId>

解析<peerId>所绑定的hash


* 缓存内容到本地

> ipfs pin add -r <hash>

缓存内容到本地不仅可以自己使用，也能为其他节点提供资源。

























