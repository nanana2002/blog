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
![image](https://github.com/BH3GEI/blog/assets/58540850/39ef2f7f-4958-4297-a0b5-4ef66661142c)

```bash
cs144@vm:~$ telnet mails.jlu.edu.cn smtp
Trying 202.198.16.89...
Connected to mails.jlu.edu.cn.
Escape character is '^]'.
220 mails.jlu.edu.cn ESMTP Server
EHLO mails.jlu.edu.cn
250-mails.jlu.edu.cn
250-PIPELINING
250-SIZE 1524000000
250-ETRN
250-STARTTLS
250-AUTH LOGIN PLAIN
250-AUTH=LOGIN PLAIN
250-ENHANCEDSTATUSCODES
250 8BITMIME
AUTH LOGIN
334 VXNlcm5hbWU6
dGhpcyBpcyB1c2VybmFtZQo=
334 UGFzc3dvcmQ6
dGhpcyBpcyBwYXNzd29yZA==
235 2.7.0 Authentication successful
MAIL FROM xxx@mails.jlu.edu.cn
501 5.5.4 Syntax: MAIL FROM:<address>
MAIL FROM: xxx@mails.jlu.edu.cn
250 2.1.0 Ok
RCPT TO: xxx@gmail.com
250 2.1.5 Ok
DATA
354 End data with <CR><LF>.<CR><LF>
From: xxx@mails.jlu.edu.cn
To: xxxi@gmail.com
Subject: Across the firewall we can reach every  corner of the world
.
250 2.0.0 Ok: queued as 4SHRdM0JbTz1gwbG
quit
221 2.0.0 Bye
Connection closed by foreign host.
```
课程指导中使用`HELO mycomputer.stanford.edu`直接认证。而我校没有这种东西，况且我也已经毕业。查询后，使用EHLO。

在SMTP协议中，HELO 和 EHLO 都是SMTP命令，用于SMTP客户端在建立连接后向SMTP服务器标识自己。它们之间的主要区别在于它们所支持的特性。

HELO：SMTP协议原始的标识命令，它只能告诉SMTP服务器客户端的主机名或IP地址。HELO 命令简单，只用于基本的SMTP会话，不支持任何扩展特性。

EHLO：这是SMTP协议的扩展命令，在原始的 HELO 命令基础上增加了对SMTP服务扩展的支持。当SMTP客户端发送 EHLO 命令后，SMTP服务器会返回一个代码和一系列的SMTP服务扩展。这些扩展可能包括身份验证（AUTH LOGIN）、传输加密（STARTTLS）等。

AUTH LOGIN 是SMTP认证命令的一种，通常在 EHLO 之后使用。在这个过程中，用户名和密码通常被Base64编码发送。这是为了在网络中传输时提供一定的保护，但并不是真正的安全机制，因为Base64编码可以很容易地被解码。

所以如果SMTP服务器支持服务扩展（如身份验证、传输加密等），那么应该使用 EHLO 命令。如果只需要基本的SMTP会话，那么可以使用 HELO 命令。

## 2.3 Listening and connecting:

## 3 Writing a network program using an OS stream socket:

## 3.1 Let’s get started—fetching and building the starter code

## 3.2 Modern C++: mostly safe but still fast and low-level

## 3.3 Reading the Minnow support code

## 3.4 Writing webget

## 4 An in-memory reliable byte stream

## 5 Submit
