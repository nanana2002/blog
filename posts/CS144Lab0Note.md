## 一、环境配置：

### 下载课程提供的virtubox镜像：
- 说明文档：[https://stanford.edu/class/cs144/vm_howto/vm-howto-image.html](https://stanford.edu/class/cs144/vm_howto/vm-howto-image.html)

### 安装和打开ssh

```bash

sudo apt-get install openssh-server
sudo service ssh start
sudo ps -e |grep ssh

```

编辑ssh配置文件：

```bash
sudo vim /etc/apt/sshd_config
```

将 `'PermitRootLogin without-password'` 注释为 `'#PermitRootLogin without-password'` 并添加 `'PermitRootLogin yes'`

### 设置端口转发
![image]()使用mobaxterm进行连接。### 换成国内源以便于中国国内使用：

```bash

sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak

sudo bash -c "cat << EOF > /etc/apt/sources.list && apt update 
deb http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
EOF"

```

根据 [LittleTools](https://github.com/BH3GEI/LittleTools) 中的小工具配置国内网络环境。

## 二、Fetch a Web page：

示例：

```bash

proxychains4 telnet cs144.keithw.org http
GET /hello HTTP/1.1
Host: cs144.keithw.org
Connection: close

```

### Assignment：
