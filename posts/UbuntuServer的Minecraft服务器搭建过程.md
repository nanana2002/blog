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

nano ~/server/eula.txt
eula=true

nano ~/server/server.properties
rcon.port=25575
rcon.password=strong-password
enable-rcon=true

sudo nano /etc/systemd/system/minecraft.service
'''
[Unit]
Description=Minecraft Server
After=network.target
[Service]
User=minecraft
Nice=1
KillMode=none
SuccessExitStatus=0 1
ProtectHome=true
ProtectSystem=full
PrivateDevices=true
NoNewPrivileges=true
WorkingDirectory=/opt/minecraft/server
ExecStart=/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui
ExecStop=/opt/minecraft/tools/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p strong-password stop
[Install]
WantedBy=multi-user.target
'''

sudo systemctl daemon-reload
sudo systemctl start minecraft
sudo systemctl status minecraft
sudo systemctl enable minecraft
sudo ufw allow 25565/tcp
sudo su - minecraft

nano /opt/minecraft/tools/backup.sh
'''
#!/bin/bash

function rcon {
  /opt/minecraft/tools/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p strong-password "$1"
}

rcon "save-off"
rcon "save-all"
tar -cvpzf /opt/minecraft/backups/server-$(date +%F-%H-%M).tar.gz /opt/minecraft/server
rcon "save-on"

## Delete older backups
find /opt/minecraft/backups/ -type f -mtime +7 -name '*.gz' -delete
'''

chmod +x /opt/minecraft/tools/backup.sh
crontab -e

nano ./.bashrc
'''
alias mccommand='/opt/minecraft/tools/mcrcon/mcrcon -H 127.0.0.1 -P 25575 -p strong-password -t'
'''
source ./.bashrc

mccommand

```

> 记录下发现的远古遗迹:
> 1666 -49 -1111 

> 参考来源：
> https://linuxize.com/post/how-to-make-minecraft-server-on-ubuntu-20-04/
