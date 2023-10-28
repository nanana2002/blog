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

课程指导让我给发件邮箱发，我直接给自己gmail发了，发完才发现Assignment就是这个。

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

btw，如果你不问好的话，会提示如下：

```bash
cs144@vm:~$ telnet mails.jlu.edu.cn smtp
Trying 202.198.16.89...
Connected to mails.jlu.edu.cn.
Escape character is '^]'.
220 mails.jlu.edu.cn ESMTP Server
AUTH LOGIN
334 VXNlcm5hbWU6
dGhpcyBpcyB1c2VybmFtZQo=
334 UGFzc3dvcmQ6
dGhpcyBpcyBwYXNzd29yZA==
235 2.7.0 Authentication successful
MAIL FROM: xxx@mails.jlu.edu.cn
550 5.7.1 It's polite to say helo first.

```

## 2.3 Listening and connecting:

两个终端，一个netcat，另一个telnet。建立连接后实现通信。

```bash
cs144@vm:~$ netcat -v -l -p 9090
Listening on 0.0.0.0 9090
Connection received on localhost 51960
aaa
i am your father
^C
cs144@vm:~$

```

```bash

cs144@vm:~$ telnet localhost 9090
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
aaa
i am your father
Connection closed by foreign host.

```
## 3 Writing a network program using an OS stream socket:

#### 内容翻译：

在本实验中，我们将编写一个简单的程序，该程序能通过互联网获取网页。这是通过使用操作系统（例如Linux）提供的一项功能实现的，即创建一个可靠的双向字节流，该字节流连接运行在本地计算机和互联网上另一台计算机（例如Web服务器）的两个程序。这种功能被称为流套接字，它对于程序和Web服务器来说，就像是一个普通的文件描述符。

然而，互联网实际上并不提供可靠的字节流服务。相反，互联网的工作方式是尽最大努力将短片段的数据，即互联网数据报，传送到它们的目的地。这些数据报可能会丢失、顺序错乱、内容被更改，甚至被复制并多次传送。通常，将这些“尽力而为的数据报”转换为“可靠的字节流”是操作系统的工作，这是通过使用传输控制协议（TCP）完成的。

在这个实验中，我们将使用操作系统对TCP的预先支持，编写一个名为“webget”的程序，它创建一个TCP流套接字，连接到Web服务器，并获取一个页面。在未来的实验中，我们将自己实现TCP，以便从不太可靠的数据报中创建可靠的字节流。

## 3.1 Let’s get started—fetching and building the starter code
```bash
cs144@vm:~$ proxychains4 git clone https://github.com/cs144/minnow
[proxychains] config file found: /etc/proxychains4.conf
[proxychains] preloading /usr/lib/x86_64-linux-gnu/libproxychains.so.4
[proxychains] DLL init: proxychains-ng 4.16
Cloning into 'minnow'...
[proxychains] DLL init: proxychains-ng 4.16
[proxychains] DLL init: proxychains-ng 4.16
[proxychains] Strict chain  ...  192.168.1.12:9808  ...  github.com:443  ...  OK
[proxychains] DLL init: proxychains-ng 4.16
remote: Enumerating objects: 278, done.
remote: Counting objects: 100% (155/155), done.
remote: Compressing objects: 100% (79/79), done.
remote: Total 278 (delta 83), reused 76 (delta 76), pack-reused 123
Receiving objects: 100% (278/278), 111.67 KiB | 536.00 KiB/s, done.
Resolving deltas: 100% (135/135), done.
[proxychains] DLL init: proxychains-ng 4.16
cs144@vm:~$ ls
minnow
cs144@vm:~$ cd minnow
cs144@vm:~/minnow$ cmake -S . -B build
-- The CXX compiler identification is GNU 12.2.0
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Setting build type to 'Debug'
-- Building in 'Debug' mode.
-- Configuring done
-- Generating done
-- Build files have been written to: /home/cs144/minnow/build
cs144@vm:~/minnow$ cmake --build build
[  8%] Building CXX object util/CMakeFiles/util_debug.dir/address.cc.o
[ 16%] Building CXX object util/CMakeFiles/util_debug.dir/file_descriptor.cc.o
[ 25%] Building CXX object util/CMakeFiles/util_debug.dir/random.cc.o
[ 33%] Building CXX object util/CMakeFiles/util_debug.dir/socket.cc.o
[ 41%] Linking CXX static library libutil_debug.a
[ 41%] Built target util_debug
[ 50%] Building CXX object src/CMakeFiles/minnow_debug.dir/byte_stream.cc.o
[ 58%] Building CXX object src/CMakeFiles/minnow_debug.dir/byte_stream_helpers.cc.o
[ 66%] Linking CXX static library libminnow_debug.a
[ 66%] Built target minnow_debug
[ 75%] Building CXX object tests/CMakeFiles/minnow_testing_debug.dir/common.cc.o
[ 83%] Linking CXX static library libminnow_testing_debug.a
[ 83%] Built target minnow_testing_debug
[ 91%] Building CXX object apps/CMakeFiles/webget.dir/webget.cc.o
[100%] Linking CXX executable webget
[100%] Built target webget

```
签到表真的非常暖心。
![image](https://github.com/BH3GEI/blog/assets/58540850/f7a5bc9d-80ea-4af2-aec2-920293789075)

## 3.2 Modern C++: mostly safe but still fast and low-level

#### 内容翻译：

实验室的作业将会使用现代C++风格完成，这种风格使用了最近（2011年）的特性，以尽可能安全地编程。这可能与你过去被要求编写C++的方式不同。关于这种风格的参考，请查看[C++核心指南](http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines)。基本的想法是确保每个对象都设计有尽可能小的公开接口，有许多内部安全检查，难以被错误使用，并知道如何自我清理。我们想要避免“配对”操作（例如，malloc/free，或new/delete），其中第二半对可能不会发生（例如，如果函数提前返回或抛出异常）。相反，操作发生在对象的构造函数中，反向操作发生在析构函数中。这种风格被称为“资源获取即初始化”，或RAII。喵～

特别是，我们希望你能：

- 使用[https://en.cppreference.com](https://en.cppreference.com)上的语言文档作为资源。（我们建议你避免使用可能过时的cplusplus.com。）
- 不要使用`malloc()`或`free()`。
- 不要使用`new`或`delete`。
- 基本上不要使用原始指针(`*`)，只有在必要时才使用“智能”指针（`unique_ptr`或`shared_ptr`）。（在CS144中你不需要使用这些。）
- 避免使用模板，线程，锁，和虚函数。（在CS144中你不需要使用这些。）
- 避免使用C风格的字符串（`char *str`）或字符串函数（`strlen()`，`strcpy()`）。这些都很容易出错。请使用`std::string`代替。
- 不要使用C风格的类型转换（例如，`(FILE *)x`）。如果必须要用，使用C++的静态类型转换（在CS144中你一般不需要这个）。
- 优先使用`const`引用传递函数参数（例如：`const Address & address`）。
- 除非需要变动，否则所有变量都应该是`const`的。
- 除非需要改变对象，否则所有的方法都应该是`const`的。
- 避免使用全局变量，并给每个变量最小的可能范围。
- 在提交作业之前，运行`cmake --build build --target tidy`以获取关于如何改进C++编程实践的代码建议，以及运行`cmake --build build --target format`以保持代码的一致性格式。喵～

关于使用Git：实验室是以Git（版本控制）库的形式分发的，这是一种记录更改，检查版本以帮助调试，以及跟踪源代码起源的方式。请在工作时频繁地进行小的提交，并使用提交消息来标识发生了什么改变以及为什么。理想的情况是，每次提交都应该能够编译，并且不断地通过更多的测试。进行小的“语义”提交有助于调试（如果每次提交都可以编译，并且消息描述了提交所做的一件明确的事情，那么调试就会容易得多），并通过记录你的稳步进展来保护你免受作弊的指控，这是一种在任何包括软件开发的职业中都会有帮助的技能。批改者将会阅读你的提交消息，以了解你是如何开发你的实验室解决方案的。

如果你还不会使用Git，请在CS144的办公时间向我们寻求帮助，或者查询教程（例如，[Git Handbook](https://guides.github.com/introduction/git-handbook)）。最后，你可以将你的代码存储在GitHub、GitLab、Bitbucket等的私有仓库中，但请确保你的代码不是公开可访问的。


## 3.3 Reading the Minnow support code

#### 内容翻译：

为了支持这种编程风格，Minnow的类将操作系统函数（可以从C中调用）封装在“现代”C++中。我们为你提供了C++封装器，用于我们希望你在CS 110/111中已经熟悉的概念，特别是套接字和文件描述符。

请阅读公共接口（在文件util/socket.hh和util/file descriptor.hh中，位于“public:”后的部分）。（请注意，Socket是FileDescriptor的一种类型，而TCPSocket是Socket的一种类型。）喵～

## 3.4 Writing webget

## 4 An in-memory reliable byte stream

## 5 Submit
