```shell
sudo apt update
sudo apt install git build-essential -y
sudo apt install openjdk-11-jre-headless

java -version

sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft
sudo su - minecraft
mkdir -p ~/{backups,tools,server}

git clone https://hub.fastgit.xyz/Tiiffi/mcrcon.git ~/tools/mcrcon 
gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c  #编译mcrcon

./mcrcon -v

wget https://launcher.mojang.com/v1/objects/a0d03225615ba897619220e256a266cb33a44b6b/server.jar -P ~/server
cd ~/server
java -Xmx1024M -Xms1024M -jar server.jar nogui



```

