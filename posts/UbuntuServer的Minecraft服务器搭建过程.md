```shell
sudo apt update
sudo apt install git build-essential -y
sudo add-apt-repository ppa:linuxuprising/java 
 sudo apt-get install oracle-java17-installer

java -version

sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft
sudo su - minecraft
mkdir -p ~/{backups,tools,server}

git clone https://hub.fastgit.xyz/Tiiffi/mcrcon.git ~/tools/mcrcon 
gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c  #编译mcrcon

./mcrcon -v

wget https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar -P ~/server
cd ~/server
java -Xmx1024M -Xms1024M -jar server.jar nogui



```

> https://linuxize.com/post/how-to-make-minecraft-server-on-ubuntu-20-04/
