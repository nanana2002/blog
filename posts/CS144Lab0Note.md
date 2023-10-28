## 1、环境配置：

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

### 使用mobaxterm进行连接

### 换成国内源以便于中国国内使用：

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

## 2.1 Fetch a Web page：

示例：

```bash

proxychains4 telnet cs144.keithw.org http
GET /hello HTTP/1.1
Host: cs144.keithw.org
Connection: close

```

### Assignment：

```bash

cs144@vm:~$ proxychains4 telnet cs144.keithw.org http
[proxychains] config file found: /etc/proxychains4.conf
[proxychains] preloading /usr/lib/x86_64-linux-gnu/libproxychains.so.4
[proxychains] DLL init: proxychains-ng 4.16
Trying 224.0.0.1...
[proxychains] Strict chain  ...  192.168.1.12:9808  ...  cs144.keithw.org:80  ...  OK
Connected to cs144.keithw.org.
Escape character is '^]'.
GET /lab0/11190307 HTTP/1.1
Host: cs144.keithw.org
Connection: close

HTTP/1.1 200 OK
Date: Fri, 27 Oct 2023 15:49:35 GMT
Server: Apache
X-You-Said-Your-SunetID-Was: 11190307
X-Your-Code-Is: 241933
Content-length: 112
Vary: Accept-Encoding
Connection: close
Content-Type: text/plain

Hello! You told us that your SUNet ID was "11190307". Please see the HTTP headers (above) for your secret code.
Connection closed by foreign host.

```
## 2.2 Send yourself an email：

## 2.3 Listening and connecting:

## 3 Writing a network program using an OS stream socket:

## 3.1 Let’s get started—fetching and building the starter code

## 3.2 Modern C++: mostly safe but still fast and low-level

## 3.3 Reading the Minnow support code

## 3.4 Writing webget

## 4 An in-memory reliable byte stream

## 5 Submit
