一、环境配置：

下载课程提供的virtubox镜像：
说明文档：https://stanford.edu/class/cs144/vm_howto/vm-howto-image.html

安装和打开ssh

sudo apt-get install openssh-server
sudo service ssh start
sudo ps -e |grep ssh

sudo vim /etc/ssh/sshd_config
注释'PermitRootLogin without-password'->'#PermitRootLogin without-password'
添加'PermitRootLogin yes'

设置端口转发
![image](https://github.com/BH3GEI/blog/assets/58540850/24098a42-f11f-4ee0-9c75-2d31ad28b492)

使用mobaxterm连接

换成国内源以便于中国国内使用：
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo bash -c "cat << EOF > /etc/apt/sources.list && apt update 
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse
EOF"

根据https://github.com/BH3GEI/LittleTools中的小工具配置国内网络环境


二、Fetch a Web page：
示例：
proxychains4 telnet cs144.keithw.org http
GET /hello HTTP/1.1
Host: cs144.keithw.org
Connection: close
Assignment：


