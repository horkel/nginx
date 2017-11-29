## 基于 ArchLinux 的 nginx 镜像

编译过程不是必须的，如果需要调整编译参数，可以修改 `build.sh` 文件后重新编译，默认 nginx 文件已经编译完成

### 编译 nginx

docker 启动进入 build 环境

```
docker run -i -t -v ~/develop/projects/horkel/nginx/build:/build --name=build-nginx horkel/archlinux /bin/bash --login
```

执行 `/build/build.sh` 文件，编译 nginx

### 构建镜像

```
docker build -t horkel/nginx:1.12.2 .
```

### 运行容器

```
docker run -d -p 10080:80 -v ~/develop/docker:/docker -v ~/develop/projects:/public --network arpa --ip 172.20.20.21 --name=nginx horkel/nginx:1.12.2
```
