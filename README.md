**[项目简介](#项目简介)** |
**[前提条件](#前提条件)** |
**[使用说明](#使用说明)** |
**[常见问题及解决方法](#常见问题及解决方法)** |

# [lpjupyter_hm](https://github.com/Chungtow/lpjupyter_hm)

## 项目简介
lpjupyter_hm 是在JupyterHub官方镜像（quay.io/jupyterhub/jupyterhub:5.2.1）基础上发展起来的镜像构建文件，将原镜像安装后所需要的多个配置步骤打包。完成构建后，直接运行容器即可使用。

## 前提条件
在开始之前，请确保满足以下前提条件：
- 操作系统：Linux 系统（推荐 Ubuntu 20.04 或更高版本）。
- Docker 安装：系统上已安装并配置好 Docker。
- 网络畅通：确保机器可以访问互联网，以便下载必要的依赖项。

## 使用说明
### 步骤一：克隆项目
你可以通过 HTTPS 或 SSH 方式克隆项目到本地：
HTTPS 方式：
```bash
git clone https://github.com/Chungtow/lpjupyter_hm.git
```
SSH 方式：
```bash
git clone git@github.com:Chungtow/lpjupyter_hm.git
```
### 步骤二：进入项目目录
切换到克隆下来的项目目录：

```bash
cd lpjupyter_hm
```

### 步骤三：构建镜像
```bash
docker build -f Dockerfile -t liangpu/jupyter:hm .
```

### 步骤四：验证镜像构建成功
构建完成后，可以通过以下命令查看已构建的镜像：

```bash
docker images
```

你应该能看到名为 `liangpu/jupyter:hm`（或你自定义的镜像名称）的镜像。

### 步骤五：启动容器
可根据需求选择合适的启动方式：

#### 启动方式一：交互式创建容器实例，直接启动 JupyterHub
```bash
docker run -it --name hmjupyter -p 8000:8000 liangpu/jupyter:hm
```

#### 启动方式二：交互式创建容器实例后，手动启动 JupyterHub
1. **交互式启动容器**

```bash
docker run -it --name hmjupyter -p 8000:8000 liangpu/jupyter:hm /bin/bash
```

2. **手动启动 JupyterHub**： 在容器内运行以下命令启动 JupyterHub：

```bash
/start.sh
```

#### 启动方式三：守护式启动
以守护进程模式启动容器：

```bash
docker run -d --name hmjupyter -p 8000:8000 liangpu/jupyter:hm
```

#### 启动方式四：挂载数据卷，设置自动重启
挂载宿主机上的数据卷，并设置容器自动重启：

```bash
docker run -d --name hmjupyter \
  -p 8000:8000 \
  --restart always \
  -v /home/jupyterusers/hm:/home \
  liangpu/jupyter:hm
```

### 步骤六：访问服务
打开浏览器，输入`http://(服务器IP):8000` 即可访问。如果部署至本机上，可使用`http://localhost:8000`访问。


## 常见问题及解决方法
#### 1. Docker 安装问题
+ **问题描述**：无法找到 Docker 命令。
+ **解决方法**：确认 Docker 是否正确安装。

#### 2. 构建失败
+ **问题描述**：在构建过程中遇到错误。
+ **解决方法**：检查输出日志中的错误信息，并确保所有依赖项都已正确安装。可以尝试使用多阶段构建来优化构建过程。

#### 3. 容器启动失败
+ **问题描述**：容器无法正常启动。
+ **解决方法**：检查容器的日志输出，使用以下命令查看容器日志：

```bash
docker logs hmjupyter
```

根据日志中的错误提示进行修复。

#### 4. 端口冲突
+ **问题描述**：端口 8000 已被占用。
+ **解决方法**：选择其他未被占用的端口，例如：

```bash
docker run -d --name hmjupyter -p 8001:8000 liangpu/jupyter:hm
```

## 贡献者
欢迎贡献代码！请先 fork 本项目并在本地进行修改，然后提交 pull request。

## 许可证
本项目遵循 MIT 协议。



