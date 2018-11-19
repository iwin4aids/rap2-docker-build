# rap2-docker

本仓库使用docker部署前后端分离开发调试神器rap2，当前版本rap版本v2.3，支持一键all-in-one构建镜像和部署启动

> 注意：需提前安装docker和docker-compose

## 后端部署

docker-compose.yml文件中对mysql进行持久化设置（如果不配置volumn则每次重启后数据丢失）

例如: 将宿主机的 `~/docker/mysql/volume` 映射到容器内目录 `/var/lib/mysql`

```yml
volumes:
  # change './docker/mysql/volume' to your own path
  # WARNING: without this line, your data will be lost.
  - "~/docker/mysql/volume:/var/lib/mysql"
```

启动后端服务

```cmd
cd rap2-delos
docker-compose up -d
```

校验是否成功部署

```cmd
> curl http://localhost:38080
```

打印出 ***Hello RAP!*** 即代表后端部署成功。

注意：
delos的docker-compose.yml文件以及根目录下的docker-compose-rap2.yml中容器启动脚本在第一次执行时使用以下语句初始化数据库：

```cmd
command: /bin/sh -c 'sleep 30; node scripts/init; node dispatch.js'
```

后续运行需要去掉数据库初始化命令，防止删掉之前mysql中的数据，改为直接启动后端服务即可：

```cmd
command: /bin/sh -c 'node dispatch.js'
```

## 前端部署

修改`rap2-dolores/src/config/config.prod.js`中的后端服务器地址

```javascript
// http://localhost:38080替换成自己rap2-delos的服务地址，或者域名
module.exports = {
  serve: 'http://localhost:38080',
  keys: ['some secret hurr'],
  session: {
    key: 'koa:sess'
  }
}
```

启动前端服务

```cmd
cd rap2-dolores
docker-compose up -d
```

访问以下url即可进入rap2登录页面：

> <http://localhost:38081>

## 前后端一键整体启动（推荐使用，需要成功构建出前后端的2个镜像）

docker images查看是否存在以下成功构建的镜像

> 后端镜像默认名称：rap2-dolores_dolores:latest
>
> 前段镜像默认名称：rap2-delos_delos:latest

执行以下命令管理rap2：

```cmd
#启动rap2
./rap2.sh start
#关闭rap2
./rap2.sh stop
#查看状态
./rap2.sh status
#重启rap2
./rap2.sh restart
```